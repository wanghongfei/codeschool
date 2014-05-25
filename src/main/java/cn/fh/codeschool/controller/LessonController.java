package cn.fh.codeschool.controller;

import java.util.List;
import java.util.Map;

import javax.json.Json;
import javax.json.JsonObject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.fh.codeschool.model.Course;
import cn.fh.codeschool.model.CourseChapter;
import cn.fh.codeschool.model.CourseSection;
import cn.fh.codeschool.model.Member;
import cn.fh.codeschool.service.AccountService;
import cn.fh.codeschool.service.ChapterService;
import cn.fh.codeschool.service.CourseService;
import cn.fh.codeschool.service.SectionService;
import cn.fh.codeschool.service.ValidationService;

/**
 * 执行与 课程 有关页面的逻辑
 * @author whf
 *
 */
@Controller
public class LessonController {
	private static final Logger logger = LoggerFactory.getLogger(LessonController.class);
	
	private String languageName;
	
	@Autowired
	private CourseService courseService;
	
	@Autowired
	private ChapterService chapterService;

	@Autowired
	private SectionService sectionService;
	
	@Autowired
	private ValidationService validationService;
	
	@Autowired
	private AccountService accountService;
	
	/**
	 * 用户请求课程学习页面，将小节放到model中
	 * @return
	 */
	@RequestMapping(value = "/courses/start")
	public String startCourse(@RequestParam Integer sectionId,
			@RequestParam Integer courseId,
			Model model,
			HttpServletRequest req) {

		// 将小节放入model中
		CourseSection cs = sectionService.findSectionEager(sectionId);
		String trimmedCode = cs.getInitialCode().replace("\n", "\\n");
		cs.setInitialCode(trimmedCode);
		model.addAttribute("section", cs);
		
		// 将语言放入model中
		String[] lan = courseService.fetchCourseLanguage(courseId).split(";");
		model.addAttribute("languageList", lan);
		
		// 标记当前课程为用户开始学习
		if (null != req.getSession(false)) {
			Member m = (Member)req.getSession(false).getAttribute("currentUser");
			
			// 下面的if测试用
			/*if (null != m) {
				System.out.println("完成百分比: " + accountService.fetchPercentageByCourse(m, courseId));
			}*/

			// 用户的 startedCourseIds中没有此id时,再进行添加
			if (null != m && false == m.includeCourseId(courseId)) {

				m.addCourseId(courseId);
				accountService.saveMember(m);
			}
		}
		

		return "/courses/course-content";
	}
	
	/**
	 * 用户在学习页面切换小节
	 * @return
	 */
	@RequestMapping(value = "/courses/start/changeSection", method = RequestMethod.GET, produces = "application/json; charset=utf-8")
	public @ResponseBody String changeSection(@RequestParam Integer sectionId) {
		CourseSection cs = sectionService.findSection(sectionId);
		
		JsonObject json = Json.createObjectBuilder()
				.add("sectionId", cs.getId())
				.add("name", cs.getSectionName())
				.add("content", cs.getCourseContent())
				.add("initialCode", cs.getInitialCode())
				.build();
		
		return json.toString();
	}
	
	/**
	 * 验证处理用户代码
	 * @param reqMap
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/courses/start/submit-code", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	public @ResponseBody String validateCode(@RequestBody Map<String, Object> reqMap, HttpSession session) {
		// 取出参数
		String code = (String)reqMap.get("code");
		String lan = (String)reqMap.get("language");
		this.languageName = lan;
		Object id = reqMap.get("sectionId");
		
		Integer sectionId = null;
		if (id instanceof Integer) {
			sectionId = (Integer)id;
		} else {
			sectionId = Integer.valueOf((String)id);
		}
		
		// 取出session中的Member
		Member m = (Member)session.getAttribute("currentUser");
		
		CourseSection cs = sectionService.findSection(sectionId);
		logger.info("得到section : {}", cs.getSectionName());
		boolean result = validationService.process(cs, m, code, lan);
		
		// 得到反馈信息
		String msg = validationService.getMessage();
		
		// 返回结果
		System.out.println("验证结果：" + result + ", 反馈信息:" + msg);
		JsonObject json = Json.createObjectBuilder()
				.add("result", result) // 验证结果
				.add("message", msg) // 反馈信息
				.add("point", m.getPoint()) // 用户最新的分数
				.build();
		
		return json.toString();
	}
	
	/**
	 * 显示某一课程的所有章节，小节
	 * @return
	 */
	@RequestMapping(value = "/courses/list")
	public String showCourseList(@RequestParam Integer courseId, Model model, HttpServletRequest req) {
		List<CourseChapter> chapters = chapterService.chapterListEager(courseId);
		model.addAttribute("chapterList", chapters);
		
		Course c = courseService.findCourse(courseId);
		model.addAttribute("course", c);
		
		// 如果用户已经登陆，则计算章节完成度
		HttpSession session = req.getSession(false);
		if (null != session) {
			Member m =  (Member)session.getAttribute("currentUser");
			if (null != m) {
				for (CourseChapter chapter : chapters) {
					chapter.setPercentage(calculatePercentage(m, chapter));
				}	
			}
		}
		
		return "/courses/course-list";
	}
	
	/**
	 * 计算当前章节的完成度
	 * @param m
	 * @param chapter
	 * @return
	 */
	private int calculatePercentage(Member m, CourseChapter chapter) {
		List<Integer> finishedIds = m.getFinishedSectionIdList();

		if (true == finishedIds.isEmpty()) {
			return 0;
		}
		
		int tot = chapter.getCourseSections().size();
		int sum = 0;
		for (Integer id : finishedIds) {
			for (CourseSection section : chapter.getCourseSections()) {
				if (section.getId().equals(id)) {
					++sum;
				}
			}
		}
		
		return (int)((double)sum / tot * 100);
	}
	
	
	@RequestMapping(value = "/courses/code-preview")
	public String showCodePreview() {
		return "/courses/code-preview";
	}

	public String getLanguageName() {
		return languageName;
	}

	public void setLanguageName(String languageName) {
		this.languageName = languageName;
	}
}
