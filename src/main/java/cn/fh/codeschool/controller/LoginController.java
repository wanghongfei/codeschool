package cn.fh.codeschool.controller;

import javax.json.Json;
import javax.json.JsonObject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.fh.codeschool.model.Member;
import cn.fh.codeschool.model.User;
import cn.fh.codeschool.service.AccountService;

@Controller
public class LoginController {
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	private String message;
	
	@Autowired
	private AccountService accountService;
	
	/**
	 * 接收用户登陆表单提交的ajax请求，返回验证结果
	 * @param user
	 * @param req
	 * @return JSON字符串。格式：{result: XXX, message: XXX}
	 */
	@RequestMapping(value = "/login", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	public @ResponseBody String login(@RequestBody User user,
			HttpServletRequest req) {
		logger.info("用户 {} 请求登陆", user.getUsername());
		
		JsonObject json = null;
		Member m = accountService.findMember(user.getUsername(), user.getPassword());

		// 验证失败
		if (null == m) {
			json = Json.createObjectBuilder()
					.add("result", false)
					.add("message", accountService.getMessage())
					.build();
			
			return json.toString();
		}
		
		// 验证成功
		json = Json.createObjectBuilder()
				.add("result", true)
				.build();
		
		// 将 member 对象放到session中
		req.getSession().setAttribute("currentUser", m);
		
		
		// test
		//accountService.updateRank(m);
		
		return json.toString();
	}
	
	/**
	 * 退出登陆，关闭session
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		Member m = (Member)session.getAttribute("currentUser");
		
		// 防止用户自行访问 /logout
		if (null != m) {
			logger.info("用户 {} 退出登陆", ((Member)session.getAttribute("currentUser")).getUsername());
			session.invalidate();
		}
		
		return "redirect:/";
	}
	
	private boolean validateUsername(String uname, String pwd) {
		if (uname.length() < 4 || uname.length() > 15) {
			message = "用户名长度必须在 4 ~ 15之间";
			return false;
		}
		
		return true;
	}

}
