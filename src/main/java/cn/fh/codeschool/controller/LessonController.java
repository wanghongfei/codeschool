package cn.fh.codeschool.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import cn.fh.codeschool.model.CourseChapter;
import cn.fh.codeschool.model.CourseSection;
import cn.fh.codeschool.service.ChapterService;
import cn.fh.codeschool.service.SectionService;

/**
 * 执行与 课程 有关页面的逻辑
 * @author whf
 *
 */
@Controller
public class LessonController {
	private static final Logger logger = LoggerFactory.getLogger(LessonController.class);
	
	@Autowired
	private ChapterService chapterService;

	@Autowired
	private SectionService sectionService;
	
	/**
	 * 用户请求课程学习页面，将小节放到model中
	 * @return
	 */
	@RequestMapping(value = "/courses/start")
	public String startCourse(@RequestParam Integer sectionId, Model model) {
		CourseSection cs = sectionService.findSectionEager(sectionId);
		model.addAttribute("section", cs);

		return "/courses/course-content";
	}
	
	/**
	 * 显示某一课程的所有章节，小节
	 * @return
	 */
	@RequestMapping(value = "/courses/list")
	public String showCourseList(@RequestParam Integer courseId, Model model, HttpServletRequest req) {
		List<CourseChapter> chapters = chapterService.chapterListEager(courseId);
		model.addAttribute("chapterList", chapters);
		
		return "/courses/course-list";
	}
}
