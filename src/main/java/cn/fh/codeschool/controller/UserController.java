package cn.fh.codeschool.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import cn.fh.codeschool.model.Member;
import cn.fh.codeschool.service.AccountService;

@Controller
public class UserController {
	@Autowired
	private AccountService accountService;
	
	
	@RequestMapping(value = "/user/{username}/profile", method = RequestMethod.GET)
	public String showPage(@PathVariable String username, Model model) {
		Member m = accountService.findMember(username);
		
		// 用户名不存在,返回错误页面
		if (null == m) {
			return "redirect:/error/not-exist";
		}

		// 将member放入model中
		model.addAttribute("member", m);

		return "/user/profile";
	}
}
