package cn.fh.codeschool.controller;

import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import cn.fh.codeschool.model.Member;
import cn.fh.codeschool.model.Role;
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
		
		// 用户名重复性查检
		if (true == repeatCheck(aService.findMemberName(), user.getUsername())) {
			logger.info("用户名 {} 已存在", user.getUsername());
			return "/register";
		}
		
		Member m = new Member();
		m.setUsername(user.getUsername());
		m.setPassword(user.getPassword());
		m.setRegisterDate(new Date());
		
		// 在这里注册的都是普通用户..
		Role userRole = aService.fetchUserRole();
		m.getRoles().add(userRole);
		
		aService.saveMember(m);

		return "/register";
	}
	
	/**
	 * 检查用户名是否重复
	 * @param names
	 * @param username
	 * @return 重复返回true
	 */
	private boolean repeatCheck(List<String> names, String username) {
		for (String name : names) {
			if (name.equals(username)) {
				return true;
			}
		}
		
		return false;
	}
}

