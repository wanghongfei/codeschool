package cn.fh.codeschool.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import cn.fh.codeschool.model.CourseProgressWrapper;
import cn.fh.codeschool.model.Member;
import cn.fh.codeschool.service.AccountService;
import cn.fh.codeschool.service.CourseService;

@Controller
public class UserController {
	@Autowired
	private AccountService accountService;
	
	@Autowired
	private CourseService courseService;
	
	
	@RequestMapping(value = "/user/{username}/profile", method = RequestMethod.GET)
	public String showPage(@PathVariable String username, Model model) {
		Member m = accountService.findMember(username);
		
		// 用户名不存在,返回错误页面
		if (null == m) {
			return "redirect:/error/not-exist";
		}

		// 将member放入model中
		model.addAttribute("member", m);
		
		// 得到用户正在学习的课程
		List<Integer> courseIds = m.getStartedCourseIdList();
		System.out.println("用户正在学习的课程id:" + courseIds);

		// 封装好后放入model中
		List<CourseProgressWrapper> wrapperList = new ArrayList<CourseProgressWrapper>();
		for (Integer id : courseIds) {
			CourseProgressWrapper wrap = new CourseProgressWrapper();
			wrap.setCourseName(courseService.fetchCourseName(id));
			wrap.setProgress(accountService.fetchPercentageByCourse(m, id));
			
			wrapperList.add(wrap);
		}
		model.addAttribute("wrapperList", wrapperList);
		
		return "/user/profile";
	}
}


