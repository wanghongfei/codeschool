package cn.fh.codeschool.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class UserController {
	@RequestMapping(value = "/user/profile", method = RequestMethod.GET)
	public String showPage() {
		return "/user/profile";
	}
}
