package cn.fh.codeschool.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class BackstageController {
	@RequestMapping(value = "backstage/course")
	public String addCourse(Model model) {
		return "/backstage/console-course";
	}

	@RequestMapping(value = "backstage/chapter")
	public String addChapter(Model model) {
		return "/backstage/console-chapter";
	}

	@RequestMapping(value = "backstage/section")
	public String addSection(Model model) {
		return "/backstage/console-section";
	}
}
