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
import cn.fh.codeschool.util.Security;

public class SecureFilter implements Filter {

	@Override
	public void destroy() {

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		
		// 防止中文乱码
		request.setCharacterEncoding("UTF-8");

		HttpServletRequest req = (HttpServletRequest)request;
		String path = req.getRequestURI();
		
		// 如果用户已经登陆，则把Member对象放进request中
		// 这样就可以在不开session的情况下在JSP页面中访问Member
		if (true == Security.isLoggedIn(req)) {
			req.setAttribute(Security.CURRENT_USER, req.getSession().getAttribute(Security.CURRENT_USER));
		}
		

		// 访问后台管理页面,需验证权限
		if (path.startsWith("/codeschool/backstage/")) {
			if (false == Security.hasRole(req, "admin") ) {
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


	@Override
	public void init(FilterConfig arg0) throws ServletException {

	}

}
