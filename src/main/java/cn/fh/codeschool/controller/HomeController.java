package cn.fh.codeschool.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import cn.fh.codeschool.model.Course;
import cn.fh.codeschool.model.Member;
import cn.fh.codeschool.scope.Conversation;
import cn.fh.codeschool.scope.ConversationManager;
import cn.fh.codeschool.service.AccountService;
import cn.fh.codeschool.service.CourseService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private AccountService accountService;
	
	@Autowired
	private CourseService courseService;
	
	
	/**
	 * 显示主面，同时显示出所有课程
	 * @param req
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "/", "/home" }, method = RequestMethod.GET)
	public String home(HttpServletRequest req, Model model) {
		// 把课程放入model中
		List<Course> courses = courseService.courseList();
		model.addAttribute("courseList", courses);
		
		
		// Conversation test
		ConversationManager cm = (ConversationManager)req.getSession().getAttribute("cm");
		Conversation c = cm.createConversation();
		logger.info(">>>>>>>>>> create Conversation:" + c.getCid());
		logger.debug(">>>debug:{1}", "hello");
		ConversationManager.expireTime = 1000 * 10L; // 10s
		Member m = new Member();
		m.setId(100);
		c.addBean("m", m);
		
		return "home";
	}
	
	
}
