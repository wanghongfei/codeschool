package cn.fh.codeschool.servlet;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import cn.fh.codeschool.util.Security;

/**
 * 检查用户是否登陆
 * <p>如果访问受保护页面，检查是否有指定role
 * <p>如果未登陆情况下访问主页，则返回事先生成好的静态页面
 * @author whf
 *
 */
public class SecureFilter implements Filter {
	private static final Logger logger = LoggerFactory.getLogger(SecureFilter.class);
	private ServletContext ctx;

	@Override
	public void destroy() {

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {

		if (logger.isDebugEnabled()) {
			logger.debug("SecureFilter调用！");
		}

		// 防止中文乱码
		request.setCharacterEncoding("UTF-8");

		HttpServletRequest req = (HttpServletRequest) request;
		String path = req.getRequestURI();

		// 请求的是资源，跳过
		if (true == path.startsWith("/codeschool/resources")) {
			chain.doFilter(request, response);
			return;
		}

		// 如果用户已经登陆，则把Member对象放进request中
		// 这样就可以在不开session的情况下在JSP页面中访问Member
		if (true == Security.isLoggedIn(req)) {
			req.setAttribute(Security.CURRENT_USER, req.getSession()
					.getAttribute(Security.CURRENT_USER));

			// 访问后台管理页面,需验证权限
			if (path.startsWith("/codeschool/backstage/")) {
				if (false == Security.hasRole(req, "admin")) {
					forbid((HttpServletResponse) response);
					return;
				}
			}
		} else {
			// 用户未登陆
			// 用户访问主页
			// 返回静态页面
			if (path.equals("/codeschool/") || path.equals("/")) {
				writeStaticHomePage(req, (HttpServletResponse) response);
				return;
			}
		}


		chain.doFilter(request, response);
	}

	/**
	 * 返回无权访问页面
	 * 
	 * @param response
	 * @throws IOException
	 */
	private void forbid(HttpServletResponse response) throws IOException {
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");

		PrintWriter pw = new PrintWriter(response.getOutputStream());
		pw.print("<h1>访问被禁止</h1>");
		pw.close();
	}

	/**
	 * 将静态主页返回给客户端
	 * @param req
	 * @param resp
	 * @throws IOException
	 */
	private void writeStaticHomePage(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		// 返回静态化页面
		// 得到home.html路径
		String pagePath = (String) ctx.getInitParameter("HOME_PAGE_PATH");

		if (logger.isDebugEnabled()) {
			logger.debug("主页静态页面路径:{}", pagePath);
		}

		// 将homt.html返回给客户端
		ServletOutputStream out = resp.getOutputStream();

		FileInputStream pageInStream = new FileInputStream(pagePath);
		BufferedInputStream bufInStream = new BufferedInputStream(pageInStream);
		byte[] buf = new byte[2048];
		int len = 0;
		while ((len = bufInStream.read(buf)) != -1) {
			out.write(buf, 0, len);
		}
		bufInStream.close();

		out.close();
	}

	@Override
	public void init(FilterConfig cfg) throws ServletException {
		this.ctx = cfg.getServletContext();
	}

}
