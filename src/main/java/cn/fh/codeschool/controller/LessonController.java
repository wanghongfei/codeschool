package cn.fh.codeschool.controller;

import java.util.Date;
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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.fh.codeschool.model.Comment;
import cn.fh.codeschool.model.Course;
import cn.fh.codeschool.model.CourseChapter;
import cn.fh.codeschool.model.CourseSection;
import cn.fh.codeschool.model.Member;
import cn.fh.codeschool.service.AccountService;
import cn.fh.codeschool.service.ChapterService;
import cn.fh.codeschool.service.CommentService;
import cn.fh.codeschool.service.CourseService;
import cn.fh.codeschool.service.SectionService;
import cn.fh.codeschool.service.ValidationService;
import cn.fh.codeschool.util.Security;

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
	
	@Autowired
	private CommentService commentService;
	
	/**
	 * 用户请求课程学习页面，将小节和评论放到model中
	 * @return
	 */
	@RequestMapping(value = "/courses/start")
	public String startCourse(@RequestParam Integer sectionId,
			@RequestParam Integer courseId,
			@RequestParam("commentPage") int page, // 评论页码
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
		
		// 将评论放入model中
		//List<Comment> comList = commentService.queryComments(cs);
		List<Comment> comList = commentService.queryComentsByPage(cs, page);
		model.addAttribute("commentList", comList);
		
		// 判断评论是否有下一页
		if (true == commentService.isNextPageAvailable(cs, page)) {
			model.addAttribute("nextPage", page + 1);
		}
		// 判断是否有上一页
		if (true == commentService.isPreviousPageAvailable(page)) {
			model.addAttribute("previousPage", page - 1);
		}
		
		// 标记当前课程为用户开始学习
		if (null != req.getSession(false)) {
			//Member m = (Member)req.getSession(false).getAttribute("currentUser");
			Member m = Security.getLoggedInUser(req);
			
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
	 * 响应用户回复评论的POST请求
	 * @param req
	 * @param content 回复的内容
	 * @return
	 */
	@RequestMapping(value = "/courses/start/comment/reply", method = RequestMethod.POST)
	public String commentReply(HttpServletRequest req,
			@RequestParam String content) {
		
		return "redirect:/courses/start";
	}
	
	/**
	 * 响应用户评论AJAX请求
	 * @param reqMap
	 * @param req
	 * @return
	 */
	@RequestMapping(value = "/courses/start/comment/add", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	public @ResponseBody String addComment(@RequestBody Map<String, Object>reqMap, HttpServletRequest req) {
		// 取出 content 参数
		String content = (String)reqMap.get("content");
		Integer sectionId = Integer.valueOf( (String)reqMap.get("sectionId") );
		
		JsonObject json = null;
		if (null == content || true == content.isEmpty()) {
			// 查检内容是否为空
			json = Json.createObjectBuilder()
					.add("result", false)
					.add("message", "content is empty")
					.build();
		} else {
			// 检查是否登陆
			if ( false == Security.isLoggedIn(req) ) {
				json =  Json.createObjectBuilder()
						.add("result", false)
						.add("message", "not logged in")
						.build();
			} else {
				// 写入数据库
				CourseSection cs = sectionService.findSection(sectionId);
				Comment com = new Comment();
				com.setMsgContent(content);
				com.setMsgTime(new Date());
				
				//Member m = (Member)req.getSession().getAttribute("currentUser");
				Member m = Security.getLoggedInUser(req);
				commentService.save(m, cs, com);

				json =  Json.createObjectBuilder()
						.add("result", true)
						.add("message", "success")
						.build();
			}
			
		}
		
		return json.toString();
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
	public @ResponseBody String validateCode(@RequestBody Map<String, Object> reqMap, HttpServletRequest req) {
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
		//Member m = (Member)session.getAttribute("currentUser");
		Member m = Security.getLoggedInUser(req);
		
		CourseSection cs = sectionService.findSection(sectionId);

		if (logger.isDebugEnabled()) {
			logger.debug("得到section : {}", cs.getSectionName());
		}

		boolean result = validationService.process(cs, m, code, lan);
		
		// 得到反馈信息
		String msg = validationService.getMessage();
		
		// 返回结果
		if (logger.isDebugEnabled()) {
			logger.debug("## 验证结果:{}, 反馈信息:{}", result, msg);
		}
		
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
		if ( true == Security.isLoggedIn(req) ) {
			Member m =  Security.getLoggedInUser(req);
			
			for (CourseChapter chapter : chapters) {
				chapter.setPercentage(calculatePercentage(m, chapter));
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
