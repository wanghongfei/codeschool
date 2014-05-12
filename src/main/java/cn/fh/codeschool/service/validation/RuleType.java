package cn.fh.codeschool.service.validation;

public enum RuleType {
	/**
	 * 需要包含一个标签
	 */
	CONTAIN,
	/**
	 * 需要有某个属性
	 */
	ATTRIBUTE,
	
	/**
	 * 语言种类
	 */
	HTML,
	JS,
	CSS
}
