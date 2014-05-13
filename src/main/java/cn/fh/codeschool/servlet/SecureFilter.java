package cn.fh.codeschool.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.fh.codeschool.model.Member;
import cn.fh.codeschool.model.Role;

public class SecureFilter implements Filter {

	@Override
	public void destroy() {

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {

		HttpServletRequest req = (HttpServletRequest)request;
		String path = req.getRequestURI();
		
		// 访问后台管理页面,需验证权限
		if (path.startsWith("/codeschool/backstage/")) {
			HttpSession session = req.getSession(false);
			if (null == session) {
				forbid((HttpServletResponse)response);
				return;
			}
			
			Member m = (Member)session.getAttribute("currentUser");
			if (null == m || false == validateUser(m)) {
				forbid((HttpServletResponse)response);
				return;
			}
			
		}


		chain.doFilter(request, response);
	}
	
	/**
	 * 返回无权访问页面
	 * @param response
	 * @throws IOException
	 */
	private void forbid(HttpServletResponse response) throws IOException {
		System.out.println("访问被禁");
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		
		PrintWriter pw = new PrintWriter(response.getOutputStream());
		pw.print("<h1>访问被禁止</h1>");
		pw.close();
	}
	
	/**
	 * 验证是否是admin
	 * @param m
	 * @return
	 */
	private boolean validateUser(Member m) {
		for (Role r : m.getRoles()) {
				if (r.getRoleName().equals("admin")) {
					return true;
			}
		}
		
		return false;
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {

	}

}
