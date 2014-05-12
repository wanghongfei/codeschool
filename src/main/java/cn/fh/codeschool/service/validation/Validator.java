package cn.fh.codeschool.service.validation;

import java.util.List;

import cn.fh.codeschool.model.ValidationRule;

/**
 * 规定验证用户代码是否正确的业务逻辑接口
 * @author whf
 *
 */
public interface Validator {
	/**
	 * 调用此方法进行验证，返回结果
	 * @param rule
	 * @return
	 */
	boolean validate(List<ValidationRule> rules);
	
	/**
	 * 调用此方法返回验证结果的描述信息
	 * @return
	 */
	String getResultMessage();
	
	/**
	 * 调用此方法设置需要验证的代码
	 * @param code
	 */
	void setCode(String code);
}
