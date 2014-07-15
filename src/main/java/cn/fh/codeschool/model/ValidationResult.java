package cn.fh.codeschool.model;

public class ValidationResult {
	public String message;
	public boolean result;
	
	public ValidationResult(String message, boolean result) {
		this.message = message;
		this.result = result;
	}
}
