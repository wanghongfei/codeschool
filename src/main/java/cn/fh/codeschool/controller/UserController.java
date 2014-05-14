package cn.fh.codeschool.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
	
	/**
	 * 响应添加好友请求
	 * @return
	 */
	@RequestMapping(value = "/user/{username}/addFriend", method = RequestMethod.GET)
	public String addFriend(@PathVariable String username, HttpSession session) {
		Member targetMember = accountService.findMember(username);
		
		// 防止恶意用户自行发送请求
		if (null == targetMember) {
			return "redirect:/error/not-exist";
		}
		
		Member m = (Member)session.getAttribute("currentUser");
		m.getFriendList().add(targetMember);
		targetMember.setParent(m);
		accountService.saveMember(targetMember);
		//accountService.saveMember(m);
		
		

		return "redirect:/user/" + username + "/profile";
	}
	
	@RequestMapping(value = "/user/{username}/profile", method = RequestMethod.GET)
	public String showPage(@PathVariable String username, HttpServletRequest req, Model model) {
		Member m = accountService.findMember(username);
		
		// 用户名不存在,返回错误页面
		if (null == m) {
			return "redirect:/error/not-exist";
		}

		// 更新排名信息
		accountService.updateRank(m);

		// 将member放入model中
		model.addAttribute("member", m);
		
		// 如果用户已登陆,判断页面上的用户是否是当前用户的好友
		boolean isFriend = false;
		HttpSession session = req.getSession(false);
		if (null != session) {
			Member currentUser = (Member)session.getAttribute("currentUser");
			if (null != currentUser) {
				isFriend = currentUser.hasFriend(username);
			}
		}
		model.addAttribute("isFriend", isFriend);
		
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


