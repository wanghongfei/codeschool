package cn.fh.codeschool.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import cn.fh.codeschool.model.Member;

public class Security {
	public static final String CURRENT_USER = "currentUser";

	
	/**
	 * 得到SHA-1 hash码
	 * @param psd
	 * @return
	 */
	public static String sha(String psd) {
		try {
			MessageDigest md = MessageDigest.getInstance("SHA-1");
			md.update(psd.getBytes());
			byte[] bytes = md.digest();
			
			StringBuilder sb = new StringBuilder();
            for(int i = 0 ; i < bytes.length ; i++) {
                sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
            }
            
            return sb.toString();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			return null;
		}
		
	}

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
		
		if (null == session.getAttribute(CURRENT_USER) ) {
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
		
		Member m = (Member)req.getSession().getAttribute(CURRENT_USER);
		return m.hasRole(roleName);
	}
	
	/**
	 * 从session中得到Member对象
	 * @param req
	 * @return
	 */
	public static Member getLoggedInUser(HttpServletRequest req) {
		return (Member)req.getSession().getAttribute(CURRENT_USER);
	}
}
