package cn.fh.codeschool.servlet;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import cn.fh.codeschool.model.Member;

public class LoggedInUserCollection implements HttpSessionListener {
	private static Map<String, HttpSession> sessionMap = new HashMap<String, HttpSession>();

	@Override
	public void sessionCreated(HttpSessionEvent arg0) {

	}

	/**
	 * session销毁时，从sessionMap中去掉被销毁的用户
	 */
	@Override
	public void sessionDestroyed(HttpSessionEvent event) {
		HttpSession session = event.getSession();
		Member m = (Member)session.getAttribute("currentUser");
		
		if (null != m) {
			sessionMap.remove(m.getUsername());
		}
	}
	

	public static Map<String, HttpSession> getSessionMap() {
		return sessionMap;
	}
}
