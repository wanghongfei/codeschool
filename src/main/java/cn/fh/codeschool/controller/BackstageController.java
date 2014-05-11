package cn.fh.codeschool.controller;

import javax.json.Json;
import javax.json.JsonObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.fh.codeschool.model.Course;
import cn.fh.codeschool.service.CourseService;

@Controller
public class BackstageController {
	private String message;
	
	@Autowired
	private CourseService courseService;
	
	
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
		System.out.println("得到课程： " + course.getCourseName());
		
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

	@RequestMapping(value = "/backstage/chapter")
	public String addChapter(Model model) {
		return "/backstage/console-chapter";
	}

	@RequestMapping(value = "/backstage/section")
	public String addSection(Model model) {
		return "/backstage/console-section";
	}
}
