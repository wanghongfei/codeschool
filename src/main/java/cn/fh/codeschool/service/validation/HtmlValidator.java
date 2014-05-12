package cn.fh.codeschool.service.validation;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.util.AbstractMap.SimpleEntry;
import java.util.List;
import java.util.Map.Entry;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import cn.fh.codeschool.model.ValidationRule;

public class HtmlValidator implements Validator, java.io.Serializable {
	/**
	 * 待验证的代码
	 */
	private String code;
	/**
	 * 验证结果的文字描述
	 */
	private String resultMessage;
	
	private static final Logger logger = LoggerFactory.getLogger(HtmlValidator.class);
	
	/**
	 * 根据规则验证用户代码是否合格。
	 * @param rule ValidationRule对象，用来定义规则
	 * @return 合格返回true,反之返回false
	 */
	//public boolean validate(ValidationRule rule) {
	public boolean validate(List<ValidationRule> rules) {
		logger.info("进入validate()方法");
		if (rules.size() == 0) {
			resultMessage = "未定义验证规则，默认为验证失败";
			logger.info(resultMessage);
			return false;
		}

		try {
			Document doc = getDocumentTree();
			Element root = doc.getDocumentElement();
			
			// 如果最上层标签不是html，则报错
			if (false == "html".equals(root.getTagName().toLowerCase())) {
				this.resultMessage = "缺少html标签";
				logger.info(this.resultMessage);

				return false;
			}
			
			// 遍历每一条rule,依次验证
			for (ValidationRule rule : rules) {
				// 验证是否包含某一标签
				if (rule.getRuleType().equals(RuleType.CONTAIN.toString())) {
					String shouldIncludedTag = rule.getTagName();
					logger.info("验证是否包含 {} 标签", shouldIncludedTag);
					
					if (false == containsTag(root.getChildNodes(), shouldIncludedTag, null)) {
						this.resultMessage = "缺少<" + shouldIncludedTag + ">标签";
						logger.info(this.resultMessage);
						
						return false;
					}
				}
				
				// 需要包含指定属性值
				if (rule.getRuleType().equals((RuleType.ATTRIBUTE.toString()))) {
					String tagName = rule.getTagName();
					String attrName = rule.getAttrName();
					String attrValue = rule.getAttrValue();
					
					
					if (false == containsTag(root.getChildNodes(), tagName, new SimpleEntry<String, String>(attrName, attrValue))) {
						this.resultMessage = "缺少<" + tagName + ">标签或属性值不正确";
						logger.info(this.resultMessage);
						
						return false;
					}
				}
			}

			
		} catch (IOException ex) {
			logger.error("IO错误，读取html String失败");
			ex.printStackTrace();
		} catch (SAXException ex) {
			// 文档不正确
			this.resultMessage = "语法错误";
			return false;
		} catch (ParserConfigurationException ex) {
			// never happen
		}
		
		this.resultMessage = "恭喜通过！请继续学习下一节！";
		return true;
	}
	
	/**
	 * 判断文档中是否包含指定标签(名)，指定标签是否具有指定属性
	 * @param nodes
	 * @param tagName 要验证是否存在的标签名
	 * @param attr 指定 key / value 的属性值。如果不需要验证属性，可传入null
	 * @return
	 */
	private boolean containsTag(NodeList nodes, String tagName, Entry<String, String> attr) {
		boolean result = false;

		for (int ix = 0 ; ix < nodes.getLength() ; ++ix) {
			Node node = nodes.item(ix);
			
			if (node instanceof Element) {
				Element elem = (Element)node;
				
				// 判断当前标签是否是要找的标签
				if (tagName.toLowerCase().equals(elem.getTagName().toLowerCase())) {
					// 只找标签，不需要验证属性
					if (null == attr) {
						result = true;
					} else { // 需要验证属性
						String targetAttr = elem.getAttribute(attr.getKey());
						if (null == targetAttr) {
							result = false; // 没有该属性
						} else {
							// 有该属性，判断属性值是否正确
							result = targetAttr.toLowerCase().equals(attr.getValue());
						}
						
					}

				// 当前标签不是要找的标签，继续遍历子节点
				} else if(elem.hasChildNodes()) {
					result = containsTag(elem.getChildNodes(), tagName, attr);
				}
				
			}
		}
		
		logger.info("containsTag()返回 {}", result);
		//FacesContext.getCurrentInstance().addMessage("form", new FacesMessage(this.resultMessage));
		return result;
	}
	
	/**
	 * 解析xml文档，返回Document对象
	 * @return
	 * @throws IOException IO错误
	 * @throws SAXException	xml文档解析出错
	 * @throws ParserConfigurationException
	 */
	private Document getDocumentTree() throws IOException, SAXException, ParserConfigurationException {
		if (null == code) {
			throw new IllegalArgumentException("htmlCode不能为null");
		}
		
		ByteArrayInputStream bufInStream = new ByteArrayInputStream(code.getBytes());
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = factory.newDocumentBuilder();
		
		return builder.parse(bufInStream);
	}
	
	public String getCode() {
		return code;
	}
	public void setCode(String htmlCode) {
		this.code = htmlCode;
	}
	public String getResultMessage() {
		return resultMessage;
	}
	public void setResultMessage(String resultMessage) {
		this.resultMessage = resultMessage;
	}

}
