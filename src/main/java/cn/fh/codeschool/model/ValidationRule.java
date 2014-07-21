package cn.fh.codeschool.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;


/**
 * 封装一条规则
 * @author whf
 *
 */
@Entity
@Table(name = "validation_rule")
public class ValidationRule {
	@Id @GeneratedValue
	private int id;
	
	@Column(name = "output")
	private String output;
	
	@Column(name = "rule_type")
	private String ruleType; // 规则类型. CONTAIN or ATTRIBUTE
	
	@Column(name = "tag_name")
	private String tagName;
	
	@Column(name = "parent_tag")
	private String parentTag;
	
	@Column(name = "attr_name")
	private String attrName;
	
	@Column(name = "attr_value")
	private String attrValue;
	
	@Transient
	public String toString() {
		StringBuilder str = new StringBuilder();
		str.append(this.ruleType);
		str.append(", ");
		str.append(this.tagName);
		str.append(", ");
		str.append(this.attrName);
		str.append(", ");
		str.append(this.attrValue);
		
		return str.toString();
	}
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getRuleType() {
		return ruleType;
	}
	public void setRuleType(String ruleType) {
		this.ruleType = ruleType;
	}
	public String getTagName() {
		return tagName;
	}
	public void setTagName(String tagName) {
		this.tagName = tagName;
	}
	public String getAttrName() {
		return attrName;
	}
	public void setAttrName(String attrName) {
		this.attrName = attrName;
	}
	public String getAttrValue() {
		return attrValue;
	}
	public void setAttrValue(String attrValue) {
		this.attrValue = attrValue;
	}


	public String getOutput() {
		return output;
	}


	public void setOutput(String output) {
		this.output = output;
	}


	public String getParentTag() {
		return parentTag;
	}


	public void setParentTag(String parentTag) {
		this.parentTag = parentTag;
	}
	
}
