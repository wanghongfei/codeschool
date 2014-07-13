package cn.fh.codeschool.servlet;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import cn.fh.codeschool.model.Member;
import cn.fh.codeschool.scope.ConversationManager;

public class LoggedInUserCollection implements HttpSessionListener {
	private static Logger logger = LoggerFactory.getLogger(LoggedInUserCollection.class);

	// 保存已登陆用户的session
	private static Map<String, HttpSession> sessionMap = new HashMap<String, HttpSession>();
	
	// 保存所有session
	private static List<HttpSession> sessionList = new ArrayList<HttpSession>();
	
	

	@Override
	public void sessionCreated(HttpSessionEvent event) {
		sessionList.add(event.getSession());
		event.getSession().setAttribute("cm", new ConversationManager(event.getSession()));
		
		if (logger.isDebugEnabled()) {
			logger.debug("创建session:{}", event.getSession().getId());
		}
	}

	/**
	 * session销毁时，从sessionMap中去掉被销毁的用户
	 */
	@Override
	public void sessionDestroyed(HttpSessionEvent event) {
		HttpSession session = event.getSession(); // This is a copy of the original session????
		
		Member m = (Member)session.getAttribute("currentUser");
		if (logger.isDebugEnabled()) {
			logger.debug("销毁session:{}, uName:{}", session.getId(), m);
		}
		
		if (m != null) {
			sessionMap.remove(m.getUsername());
		}
			
		// Remove this session from all session map.
		Iterator<HttpSession> it = sessionList.iterator();
		while (it.hasNext()) {
			HttpSession curSession = it.next();
			if (curSession.getId().equals(session.getId())) {
				it.remove();
				break;
			}
		}
	}
	

	public static Map<String, HttpSession> getSessionMap() {
		return sessionMap;
	}

	public static List<HttpSession> getSessionList() {
		return sessionList;
	}

}
