package cn.fh.codeschool.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 执行与 课程 有关页面的逻辑
 * @author whf
 *
 */
@Controller
public class LessonController {
	private static final Logger logger = LoggerFactory.getLogger(LessonController.class);
	
	@RequestMapping(value = "/courses/start")
	public String startCourse() {
		return "/courses/course-content";
	}
	
	@RequestMapping(value = "/courses/list")
	public String showCourseList() {
		return "/courses/course-list";
	}
}
