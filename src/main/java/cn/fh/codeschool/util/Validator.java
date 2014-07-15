package cn.fh.codeschool.util;

import cn.fh.codeschool.model.ValidationResult;

public class Validator {
	/**
	 * 验证用户注册信息.
	 * <p> 密码长度8 ~ 20
	 * <p> 用户名长度4~15
	 * @param username
	 * @param p1
	 * @param p2
	 * @return
	 */
	public static ValidationResult validateUser(String username, String p1, String p2, String email) {
		if (username.isEmpty()) {
			return new ValidationResult("用户名不能为空", false);
		}
		
		int len = username.length();
		if (len < 4 || len > 15 ) {
			return new ValidationResult("用户名长度必须在4~15之间", false);
		}
		
		if (p1.isEmpty()) {
			return new ValidationResult("密码能为空", false);
		}
		
		len = p1.length();
		if (len < 8 || len > 20) {
			return new ValidationResult("密码长度必须在8~20之间", false);
		}
		
		if (false == p1.equals(p2)) {
			return new ValidationResult("两次输入密码不一致", false);
		}
		
		if ( false == email.isEmpty()) {
			if (false == email.contains("@")) {
				return new ValidationResult("邮箱格式有误", false);
			}
		}

		return new ValidationResult("", true);
	}
}
