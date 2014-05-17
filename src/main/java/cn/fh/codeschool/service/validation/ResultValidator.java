package cn.fh.codeschool.service.validation;

import java.util.List;

import org.springframework.stereotype.Service;

import cn.fh.codeschool.model.ValidationRule;

/**
 * 仅验证输出结果
 * @author whf
 *
 */
@Service("result")
public class ResultValidator implements Validator {
	private String message;
	private String code;

	@Override
	public boolean validate(List<ValidationRule> rules) {
		ValidationRule rule = rules.get(0);
		boolean result = code.equals(rule.getOutput());
		
		if (true == result) {
			this.message = "恭喜通过！请继续学习下一节！";
		} else {
			this.message = "ERROR";
		}
		
		return code.equals(rule.getOutput());
	}

	@Override
	public String getResultMessage() {
		return this.message;
	}

	@Override
	public void setCode(String code) {
		this.code = code;
	}

}
