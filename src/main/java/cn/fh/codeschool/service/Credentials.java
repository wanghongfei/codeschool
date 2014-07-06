package cn.fh.codeschool.service;

import java.util.HashSet;
import java.util.Set;

import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Service;

/**
 * Credentials information for current logged in user.
 * @author whf
 *
 */
@Service
@Scope(value = "session", proxyMode = ScopedProxyMode.TARGET_CLASS)
public class Credentials {
	private String username;
	private String password;
	
	private Set<String> roleSet = new HashSet<String>();
	

	/**
	 * Add role to credentials.
	 * @param name Role name
	 */
	public void addRole(String name) {
		roleSet.add(name);
	}
	
	/**
	 * Check whether this user has specified role.
	 * @param name
	 * @return
	 */
	public boolean hasRole(String name) {
		return roleSet.contains(name);
	}
	

	public String getUsername() {
		return username;
	}

	public String getPassword() {
		return password;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public void setPassword(String password) {
		this.password = password;
	}
}
