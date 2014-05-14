package cn.fh.codeschool.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * 处理错误页面的访问请求
 * @author whf
 *
 */
@Controller
public class ErrorController {
	
	@RequestMapping(value = "/error/not-exist", method = RequestMethod.GET)
	public String showPage() {
		return "/error/not-exist";
	}
}
