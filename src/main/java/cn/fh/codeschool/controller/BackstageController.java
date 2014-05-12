package cn.fh.codeschool.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.json.Json;
import javax.json.JsonArrayBuilder;
import javax.json.JsonObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.fh.codeschool.model.Course;
import cn.fh.codeschool.model.CourseChapter;
import cn.fh.codeschool.model.CourseSection;
import cn.fh.codeschool.model.ValidationRule;
import cn.fh.codeschool.service.ChapterService;
import cn.fh.codeschool.service.CourseService;
import cn.fh.codeschool.service.SectionService;
import cn.fh.codeschool.service.validation.RuleType;

@Controller
public class BackstageController {
	private static final Logger logger = LoggerFactory.getLogger(BackstageController.class);
	
	private String message;
	
	@Autowired
	private CourseService courseService;
	
	@Autowired
	private ChapterService chapterService;
	
	@Autowired
	private SectionService sectionService;
	
	
	@RequestMapping(value = "/backstage/course")
	public String addCourse(Model model) {
		return "/backstage/console-course";
	}
	
	/**
	 * 响应添加课程表单POST请求
	 * @param course
	 * @return
	 */
	@RequestMapping(value = "/backstage/course/save", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	public @ResponseBody String saveCourse(@RequestBody Course course) {
		JsonObject json = null;
		if (false == validateCourse(course)) {
			json = Json.createObjectBuilder()
					.add("result", false)
					.add("message", this.message)
					.build();
		} else {
			courseService.saveCourse(course);
			json = Json.createObjectBuilder()
					.add("result", true)
					.add("message", this.message)
					.build();
		}
		
		
		System.out.println(json.toString());

		return json.toString();
	}
	
	/**
	 * 验证用户填写的表单是否合法
	 * @param c
	 * @return
	 */
	private boolean validateCourse(Course c) {
		if (0 == c.getCourseName().length()) {
			this.message = "课程名不能为空";
			return false;
		}
		
		if (0 == c.getCourseDescription().length()) {
			this.message = "课程介绍不能为空";
			return false;
		}
		
		this.message  = c.getCourseName() + " 保存成功";
		return true;
	}

	/**
	 * 显示添加章节页面，将所有课程List放入Model中
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/backstage/chapter", method = RequestMethod.GET)
	public String addChapter(Model model) {
		List<Course> courses = courseService.courseList();
		model.addAttribute("courseList", courses);
		
		return "/backstage/console-chapter";
	}
	
	/**
	 * 响应保存章节的ajax请求。
	 * @param jsonMap
	 * @return
	 */
	@RequestMapping(value = "/backstage/chapter/save", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	public @ResponseBody String saveChapter(@RequestBody Map<String, Object> jsonMap) {
		// 取出参数
		Integer courseId = Integer.valueOf((String)jsonMap.get("courseId"));
		String chapterName = (String)jsonMap.get("chapterName");
		
		CourseChapter chapter = new CourseChapter();
		chapter.setChapterName(chapterName);
		chapterService.saveChapter(chapter, courseId);
		
		JsonObject json = Json.createObjectBuilder()
				.add("result", true)
				.add("message", "保存 " + chapterName + " 成功")
				.build();
		
		return json.toString();
	}
	

	/**
	 * 显示添加小节页面，将所有的Course, ruleType放入模型中
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/backstage/section")
	public String addSection(Model model) {
		List<Course> courses = courseService.courseList();
		model.addAttribute("courseList", courses);
		
		// 遍历所有 RuleType Enum类型，封装成List对象
		List<String> types = new ArrayList<String>();
		for (RuleType t : RuleType.values()) {
			types.add(t.toString());
		}
		model.addAttribute("ruleTypeList", types);

		return "/backstage/console-section";
	}
	
	/**
	 * 响应保存小节的表单提交请求.
	 * @param reqMap
	 * @return
	 */
	@RequestMapping(value  ="/backstage/section/save", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	public @ResponseBody String saveSection(@RequestBody Map<String, Object> reqMap) {
		logger.info("收到json:{}", reqMap.toString());
		
		// 取出课程参数
		Integer chapterId = Integer.valueOf((String)reqMap.get("chapterId"));
		String sectionName = (String)reqMap.get("sectionName");
		String sectionContent = (String)reqMap.get("sectionContent");
		
		// 取出验证参数
		RuleType type = RuleType.valueOf((String)reqMap.get("ruleType"));
		String tagName = (String)reqMap.get("tagName");
		String attrName = (String)reqMap.get("attrName");
		String attrValue = (String)reqMap.get("attrValue");
		
		ValidationRule valRule = new ValidationRule();
		valRule.setRuleType(type.toString());
		// 需要包含规则
		if (type == RuleType.CONTAIN) {
			logger.info("需要包含规则");
			valRule.setTagName(tagName);
		// 需要属性	
		} else if (type == RuleType.ATTRIBUTE) {
			logger.info("需要属性规则");
			valRule.setTagName(tagName);
			valRule.setAttrName(attrName);
			valRule.setAttrValue(attrValue);
		} else {
			logger.error("不支持的规则类型: {}", type.toString());
		}
		
		// 持久化
		logger.info("开始保存Section");
		CourseSection section = new CourseSection();
		section.setSectionName(sectionName);
		section.setCourseContent(sectionContent);
		sectionService.saveSection(section, valRule, chapterId);
		logger.info("Section保存完毕");
		
		JsonObject json = Json.createObjectBuilder()
				.add("result", true)
				.add("message", "保存 " + sectionName + " 成功")
				.build();
		
		return json.toString();
	}
	
	/**
	 * 用户在下拉列表中选择一个课程时，响应该ajax请求并返回课程所有的章节
	 * @return
	 */
	@RequestMapping(value = "/backstage/section/fetchChapter", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	public @ResponseBody String refreshChapter(@RequestBody Map<String, Object> reqMap) {
		Integer courseId = Integer.valueOf((String)reqMap.get("courseId"));
		
		JsonArrayBuilder jArray = Json.createArrayBuilder();
		
		List<CourseChapter> chapters = chapterService.chapterList(courseId);
		for (CourseChapter cc : chapters) {
			jArray.add(Json.createObjectBuilder()
					.add("id", cc.getId())
					.add("chapterName", cc.getChapterName())
					.build());
		}

		return jArray.build().toString();
	}
}

