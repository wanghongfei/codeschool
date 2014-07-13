package cn.fh.codeschool.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import cn.fh.codeschool.model.Member;

public class Security {
	/**
	 * 查询用户是否登陆
	 * @param req
	 * @return
	 */
	public static boolean isLoggedIn(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		
		// no session found
		if (null == session) {
			return false;
		}
		
		if (null == session.getAttribute("currentUser") ) {
			return false;
		}
		
		return true;
	}
	
	/**
	 * 查询登陆用户中是否有指定role.
	 * <p>如果用户未登陆或session不存在，返回false
	 * @param req
	 * @param roleName
	 * @return
	 */
	public static boolean hasRole(HttpServletRequest req, String roleName) {
		if (false == isLoggedIn(req)) {
			return false;
		}
		
		Member m = (Member)req.getSession().getAttribute("currentUser");
		return m.hasRole(roleName);
	}
}
