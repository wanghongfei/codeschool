package cn.fh.codeschool.controller;

import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import cn.fh.codeschool.model.Member;
import cn.fh.codeschool.model.Role;
import cn.fh.codeschool.model.User;
import cn.fh.codeschool.model.ValidationResult;
import cn.fh.codeschool.service.AccountService;
import cn.fh.codeschool.util.Security;
import cn.fh.codeschool.util.Validator;

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
	public String registerUser(@ModelAttribute User user, Model model) {
		logger.info("用户注册请求 u: {}, p: {}", user.getUsername(), user.getPassword());
		
		// 用户名重复性查检
		if (true == repeatCheck(aService.findMemberName(), user.getUsername())) {
			model.addAttribute("message", "该用户已存在!");

			return "/register";
		}
		
		// 验证输入是否合法
		ValidationResult vr = Validator.validateUser(user.getUsername(), user.getPassword(), user.getPasswordConfirm(), user.getEmail());
		if (false == vr.result) {
			model.addAttribute("message", vr.message);
			
			return "/register";
		}
		
		Member m = new Member();
		String pwdHash = Security.sha(user.getPassword());
		m.setUsername(user.getUsername());
		m.setPassword(pwdHash);
		m.setEmailAddress(user.getEmail());
		m.setRegisterDate(new Date());
		
		// 在这里注册的都是普通用户..
		Role userRole = aService.fetchUserRole();
		m.getRoles().add(userRole);
		
		aService.saveMember(m);

		return "redirect:/home";
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

