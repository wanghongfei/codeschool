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
import cn.fh.codeschool.service.AccountService;
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
	
	@Autowired
	private AccountService accountService;
	
	@RequestMapping(value = "/backstage/course", method = RequestMethod.GET)
	public String addCourse(Model model) {
		List<Course> courses = courseService.courseList();
		model.addAttribute("courseList", courses);
		
		return "/backstage/console-course";
	}
	
	/**
	 * Manipulate Chapter modification AJAX request.
	 * @param reqMap Containing request parameter `chapterId`
	 * @param model
	 * @return JSON string
	 */
	@RequestMapping(value = "/backstage/updateChapter/update", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	public @ResponseBody String updateChapter(@RequestBody Map<String, Object> reqMap, Model model) {
		Integer chapterId = Integer.valueOf( (String)reqMap.get("chapterId") );
		String chapterName = (String)reqMap.get("chapterName");
		
		// update entity
		JsonObject json = null;
		CourseChapter cc = chapterService.findChapter(chapterId);
		if (null == cc) {
			json = Json.createObjectBuilder()
					.add("result", false)
					.add("message", "not found")
					.build();
		} else {
			cc.setChapterName(chapterName);
			chapterService.updateChapter(cc);
		
			json = Json.createObjectBuilder()
					.add("result", true)
					.add("message", "更新成功")
					.build();
		}
		
		return json.toString();
	}
	
	/**
	 * Display 'update chapter' page.
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/backstage/updateChapter", method = RequestMethod.GET)
	public String showUpdateChapterPage(Model model) {
		List<Course> courses = courseService.courseList();
		model.addAttribute("courseList", courses);
		
		return "/backstage/console-update-chapter";
	}
	
	/**
	 * Manipulate Chapter deletion AJAX request.
	 * @param reqMap
	 * @return
	 */
	@RequestMapping(value = "/backstage/updateChapter/delete", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	public @ResponseBody String deleteChapter(@RequestBody Map<String, Object> reqMap) {
		Integer chapterId = Integer.valueOf( (String)reqMap.get("chapterId") );
		
		JsonObject json = null;
		// deletion failed
		if (false == chapterService.deleteChapter(chapterId)) {
			json = Json.createObjectBuilder()
					.add("result", false)
					.add("message", "删除失败")
					.build();
		} else {
			json = Json.createObjectBuilder()
					.add("result", true)
					.add("message", "success")
					.build();
		}
		
		return json.toString();
	}
	
	/**
	 * 删除一个课程 
	 * @return
	 */
	@RequestMapping(value = "/backstage/course/delete", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	public @ResponseBody String deleteCourse(@RequestBody Map<String, Object> reqMap) {
		Integer courseId = Integer.valueOf((String)reqMap.get("courseId"));
		
		JsonObject json = null;
		try {
			courseService.delete(courseId);
		} catch (Exception ex) {
			ex.printStackTrace();
			json = Json.createObjectBuilder()
					.add("result", false)
					.add("message", "删除出错")
					.build();
			
			return json.toString();
		}
		
		json = Json.createObjectBuilder()
				.add("result", true)
				.add("message", "删除成功")
				.build();
		
		return json.toString();
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
		
		
		String jsonString = json.toString();

		if (logger.isDebugEnabled()) {
			logger.debug("## {}", jsonString);
		}

		return jsonString;
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
	 * 显示统计信息页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/backstage/statistics", method = RequestMethod.GET)
	public String statistics(Model model) {
		Long memberAmount = accountService.fetchUserAmount();
		model.addAttribute("memberAmount", memberAmount);
		
		return "/backstage/console-statistics";
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
	 * 显示修改小节页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/backstage/updateSection")
	public String updateSection(Model model) {
		List<Course> courses = courseService.courseList();
		model.addAttribute("courseList", courses);
		
		// 遍历所有 RuleType Enum类型，封装成List对象
		List<String> types = new ArrayList<String>();
		for (RuleType t : RuleType.values()) {
			types.add(t.toString());
		}
		model.addAttribute("ruleTypeList", types);

		return "/backstage/console-update-section";
	}
	
	/**
	 * Delete a section.
	 * @param reqMap Containing request parameter 'sectionId'
	 * @return JSON string
	 */
	@RequestMapping(value = "/backstage/section/delete", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	public @ResponseBody String deleteSection(@RequestBody Map<String, Object> reqMap) {
		Integer sectionId = Integer.parseInt((String)reqMap.get("sectionId"));
		
		JsonObject json = null;
		// deletion failed
		if (false == sectionService.deleteSection(sectionId)) {
			json = Json.createObjectBuilder()
					.add("result", false)
					.add("message", "删除失败")
					.build();
		} else {
			json = Json.createObjectBuilder()
					.add("result", true)
					.add("message", "success")
					.build();
		}
		
		
		return json.toString();
	}
	
	/**
	 * 响应更新小节的表单提交请求.
	 * @param reqMap
	 * @return
	 */
	@RequestMapping(value  ="/backstage/section/update", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	public @ResponseBody String updateSection(@RequestBody Map<String, Object> reqMap) {
		Integer sectionId = Integer.valueOf((String)reqMap.get("sectionId"));
		String name = (String)reqMap.get("sectionName");
		String content = (String)reqMap.get("sectionContent");
		String initialCode = (String)reqMap.get("initialCode");
		
		CourseSection cs = sectionService.findSection(sectionId);
		cs.setSectionName(name);
		cs.setCourseContent(content);
		cs.setInitialCode(initialCode);
		
		sectionService.updateSection(cs);
		
		JsonObject json = Json.createObjectBuilder()
				.add("result", true)
				.add("message", "更新 " + name + " 成功")
				.build();
		
		return json.toString();
	}
	
	/**
	 * 响应保存小节的表单提交请求.
	 * @param reqMap
	 * @return
	 */
	@RequestMapping(value  ="/backstage/section/save", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	public @ResponseBody String saveSection(@RequestBody Map<String, Object> reqMap) {
		
		// 取出课程参数
		Integer chapterId = Integer.valueOf((String)reqMap.get("chapterId"));
		String sectionName = (String)reqMap.get("sectionName");
		String sectionDescription = (String)reqMap.get("sectionDescription");
		String sectionContent = (String)reqMap.get("sectionContent");
		String code = (String)reqMap.get("initialCode");
		
		// 取出验证参数
		RuleType type = RuleType.valueOf((String)reqMap.get("ruleType"));
		String tagName = (String)reqMap.get("tagName");
		String attrName = (String)reqMap.get("attrName");
		String attrValue = (String)reqMap.get("attrValue");
		String output = (String)reqMap.get("output");
		

/*		String[] tags = tagName.split(",");
		List<ValidationRule> ruleList = new ArrayList<ValidationRule>(tags.length);
		ValidationRule rule = null;
		for (String tag : tags) {
			
		}*/
		
		//ValidationRule valRule = new ValidationRule();
		//valRule.setRuleType(type.toString());
		
		//ValidationRule valRule = null;
		List<ValidationRule> ruleList = new ArrayList<ValidationRule>();
		// 需要包含规则
		// 可能有多条
		if (type == RuleType.CONTAIN) {
			//valRule.setTagName(tagName);
			
			String[] tags = tagName.split(",");
			for (String tag : tags) {
				ValidationRule rule = new ValidationRule();
				rule.setRuleType(type.toString());
				rule.setTagName(tag);
				ruleList.add(rule);
			}
			
			
		// 需要属性	
		} else if (type == RuleType.ATTRIBUTE) {
			String[] tags = tagName.split(",");
			String[] attrs = attrName.split(",");
			String[] values = attrValue.split(",");
			
			for (int ix = 0 ; ix < tags.length ; ++ix) {
				ValidationRule rule = new ValidationRule();
				rule.setRuleType(type.toString());
				rule.setTagName(tags[ix]);
				rule.setAttrName(attrs[ix]);
				rule.setAttrValue(values[ix]);
			}

			//valRule.setTagName(tagName);
			//valRule.setAttrName(attrName);
			//valRule.setAttrValue(attrValue);
		} else if (type == RuleType.OUTPUT) {
			ValidationRule rule = new ValidationRule();
			rule.setRuleType(type.toString());
			rule.setOutput(output);

			//valRule.setOutput(output);
		} else {
			logger.error("不支持的规则类型: {}", type.toString());
		}
		
		// 持久化
		CourseSection section = new CourseSection();
		section.setSectionName(sectionName);
		section.setSectionDescription(sectionDescription);
		section.setCourseContent(sectionContent);
		section.setInitialCode(code);
		//sectionService.saveSection(section, valRule, chapterId);
		sectionService.saveSection(section, ruleList, chapterId);
		
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

	/**
	 * 用户选择章节后，显示该章节的所有小节
	 * @param reqMap
	 * @return
	 */
	@RequestMapping(value = "/backstage/section/fetchSection", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	public @ResponseBody String refreshSection(@RequestBody Map<String, Object> reqMap) {
		Integer chapterId = Integer.valueOf((String)reqMap.get("chapterId"));
		
		if (logger.isDebugEnabled()) {
			logger.debug("## 章节id:{}", chapterId);
		}
		
		JsonArrayBuilder jArray = Json.createArrayBuilder();
		
		List<CourseSection> sections = sectionService.sectionList(chapterId);

		if (logger.isDebugEnabled()) {
			logger.debug("## 小节:{}", sections);
		}

		//List<CourseChapter> chapters = chapterService.chapterList(courseId);
		for (CourseSection section : sections) {
			jArray.add(Json.createObjectBuilder()
					.add("id", section.getId())
					.add("sectionName", section.getSectionName())
					.add("sectionDescription", section.getSectionDescription())
					.add("sectionContent", section.getCourseContent())
					.add("initialCode", section.getInitialCode())
					.build());
		}

		return jArray.build().toString();
	}
}

