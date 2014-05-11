package cn.fh.codeschool.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LessonController {
	private static final Logger logger = Logger.getLogger(LessonController.class);
	
	@RequestMapping(value = "/courses/start")
	public String startCourse() {
		return "/courses/course-content";
	}
	
	@RequestMapping(value = "/courses/list")
	public String showCourseList() {
		return "/courses/course-list";
	}
}
