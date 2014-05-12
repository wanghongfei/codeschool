package cn.fh.codeschool.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import cn.fh.codeschool.model.Member;
import cn.fh.codeschool.service.AccountService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private AccountService accountService;
	
	
	@RequestMapping(value = { "/", "/home" }, method = RequestMethod.GET)
	public String home(HttpServletRequest req, Model model) {
		Member m = (Member)req.getSession().getAttribute("currentUser");

		// 已经登陆
		if (null != m) {
			logger.info("用户 {} 已经登陆", m.getUsername());
			model.addAttribute("currentUser", m);
		} else {
			logger.info("未登陆");
		}
		
		return "home";
	}
	
	
}
