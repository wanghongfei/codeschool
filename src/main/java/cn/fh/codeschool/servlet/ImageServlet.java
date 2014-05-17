package cn.fh.codeschool.servlet;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

public class ImageServlet extends HttpServlet {
	private byte[] imgBuf;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String username = (String)req.getParameter("username");
		OutputStream out = resp.getOutputStream();
		if (null == username) {
			out.write("no user specified".getBytes());
			out.close();
			return;
		}
		
		fetchImage(username);
		if (null != imgBuf) {
			resp.setContentType("image/jpeg");
			out.write(imgBuf);
		} else {
			out.write("image not found".getBytes());
		}
		
		out.close();

	}
	
	/**
	 * 从数据库中查出图片数据
	 * @param username
	 */
	private void fetchImage(String username) {
		DataSource ds = null;
		Connection conn = null;
		
		try {
			ds = fetchDataSource();
			conn = ds.getConnection();
			PreparedStatement stmt = conn.prepareStatement("SELECT avatar_image FROM member where username=?");
			stmt.setString(1, username);
			
			ResultSet result = stmt.executeQuery();
			while (result.next()) {
				imgBuf = result.getBytes(1);
				break;
			}

		} catch (SQLException ex) {
			ex.printStackTrace();
			System.out.println("SQL执行失败");
		} catch (NamingException ex) {
			ex.printStackTrace();
			System.out.println("JNDI查询失败");
		} finally {
			if (null != conn) {
				closeConnection(conn);
			}
		}
	}
	
	/**
	 * 通过JNDI查找得到数据源
	 * @return
	 * @throws NamingException
	 */
	private DataSource fetchDataSource() throws NamingException {
		Context ctx = new InitialContext();
		return (DataSource)ctx.lookup("java:jboss/datasources/codeschool");
	}
	
	private void closeConnection(Connection conn) {
		try {
			conn.close();
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
	}

}
