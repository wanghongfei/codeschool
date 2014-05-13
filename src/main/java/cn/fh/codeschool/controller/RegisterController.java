package cn.fh.codeschool.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import cn.fh.codeschool.model.Member;
import cn.fh.codeschool.model.User;
import cn.fh.codeschool.service.AccountService;

@Controller
public class RegisterController {
	private static final Logger logger = LoggerFactory.getLogger(RegisterController.class);
	
	@Autowired
	private AccountService aService;
	
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String showPage() {
		return "/register";
	}

	/**
	 * 响应用户注册表单POST请求
	 * @return
	 */
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String registerUser(@ModelAttribute User user) {
		logger.info("用户注册请求 u: {}, p: {}", user.getUsername(), user.getPassword());
		
		Member m = new Member();
		m.setUsername(user.getUsername());
		m.setPassword(user.getPassword());
		
		// 在这里注册的都是普通用户..
		
		aService.saveMember(m);

		return "/register";
	}
}

