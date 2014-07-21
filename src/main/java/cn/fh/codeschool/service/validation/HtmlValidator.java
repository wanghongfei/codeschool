package cn.fh.codeschool.service.validation;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.util.AbstractMap.SimpleEntry;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import cn.fh.codeschool.model.ValidationRule;
import cn.fh.codeschool.util.MutableInteger;

/**
 * 用于验证HTML代码是否符合要求的类
 * @author whf
 *
 */
@Service("html")
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
	 * 
	 * <p>对于必须要包含指定数量标签的验证规则(如代码中必须有3个p标签),处理方法是先遍历
	 * 一遍ruleList，得到一个统计标签数量的Map对象(Key:标签名, Val:数量),然后再遍历
	 * 一遍用户HTML代码，对代码中所有的标签进行数量统计，最后跟上一个Map进行对比，以判断
	 * 标签数量是否达到要求
	 * 
	 * <p>对于INCLUDE规则，先判断ValidationRule的parentTag成员是否为null,如果不为null
	 * 说明这个标签的父标签必须为parentTag指定的值;如果为null说明该标签不需要有父标签，即
	 * 可以在任意位置出现
	 * 
	 * @param rule ValidationRule对象，用来定义规则
	 * @return 合格返回true,反之返回false
	 */
	//public boolean validate(ValidationRule rule) {
	public boolean validate(List<ValidationRule> rules) {
		dumpAllRules(rules);
		
		if (rules.size() == 0) {
			resultMessage = "未定义验证规则，默认为验证失败";
			logger.info(resultMessage);
			return false;
		}
		
		// 无条件通过
		if (rules.get(0).getRuleType().equals(RuleType.NONE.toString())) {
			this.resultMessage = "恭喜通过！请继续学习下一节！";
			return true;
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
			
			// 首先验证标签数量是否足够
			boolean isTagAmountAdequate = validateTagAmount(root.getChildNodes(), rules);
			if (false == isTagAmountAdequate) {
				logger.info(this.resultMessage);
				return false;
			}
			
			// 遍历每一条rule,依次验证
			for (ValidationRule rule : rules) {
				// 验证是否包含某一标签
				// 上一个if语句已经判断过了，这里直接skip
				if (rule.getRuleType().equals(RuleType.CONTAIN.toString())) {
					continue;
					
					/*String shouldIncludedTag = rule.getTagName();
					logger.info("验证是否包含 {} 标签", shouldIncludedTag);
					
					if (false == containsTag(root.getChildNodes(), shouldIncludedTag, null)) {
						this.resultMessage = "缺少<" + shouldIncludedTag + ">标签";
						logger.info(this.resultMessage);
						
						return false;
					}*/
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
						String targetAttr = elem.getAttribute(attr.getKey()).replaceAll("\\s",""); // 去掉所有space字符
						if (null == targetAttr) {
							result = false; // 没有该属性
						} else {
							// 有该属性，判断属性值是否正确
							result = targetAttr.toLowerCase().equals(attr.getValue().replaceAll("\\s","")); // 去掉所有space字符
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
	
	/**
	 * 验证用户代码的标签数量是否足够
	 * @param nodes
	 * @param ruleList
	 * @return
	 */
	private boolean validateTagAmount(NodeList nodes, List<ValidationRule> ruleList) {
		// 得到两个counter
		Map<TagWithParent, MutableInteger> ruleTags = tagCounterForRules(ruleList);
		Map<TagWithParent, MutableInteger> userTags = new HashMap<TagWithParent, MutableInteger>();
		
		// 由于在遍历用户HTML代码时没有保存ROOT结点(即HTML标签)
		// 所以这里要手动添加进去
		userTags.put(new TagWithParent("html"), new MutableInteger(1));
		
		tagCounterForHTML(nodes, userTags);
		
		// 进行对比
		Set<Map.Entry<TagWithParent, MutableInteger>> entrySet = ruleTags.entrySet();
		for (Map.Entry<TagWithParent, MutableInteger> pair : entrySet) {
			MutableInteger ruleVal = pair.getValue();
			String ruleTag = pair.getKey().tagName;
			
			//MutableInteger realVal = userTags.get(ruleTag);
			MutableInteger realVal = userTags.get(pair.getKey());
			if (null == realVal) {
				this.resultMessage = "缺少<" + ruleTag + ">标签";
				return false;
			}
			if (realVal.compareTo(ruleVal) < 0) {
				this.resultMessage = "标签<" + ruleTag + ">数量不足";
				return false;
			}
		}
		
		return true;
	}
	
	/**
	 * 统计用户HTML代码中每个标签出现的次数
	 * @param nodes
	 * @param map 回传参数，存放统计结果
	 */
	private void tagCounterForHTML(NodeList nodes, Map<TagWithParent, MutableInteger> map) {
		int LEN = nodes.getLength();
		for (int ix = 0 ; ix < LEN ; ++ix) {
			Node node = nodes.item(ix);
			
			if (node instanceof Element) {
				Element elem = (Element)node;

				MutableInteger newVal = new MutableInteger(1);
				//MutableInteger oldVal = map.put(elem.getTagName().toLowerCase(), newVal);
				MutableInteger oldVal = map.put(new TagWithParent(elem.getTagName().toLowerCase()), newVal);
				
				if (null != oldVal) {
					newVal.setValue(oldVal.getValue() + 1);
				}
				
				if (elem.hasChildNodes()) {
					tagCounterForHTML(elem.getChildNodes(), map);
				}
			}
		}
	}
	
	/**
	 * 统计List中一个标签出现了多少次
	 * @param ruleList
	 * @return K:标签名; Value: 次数
	 */
	private Map<TagWithParent, MutableInteger> tagCounterForRules(List<ValidationRule> ruleList) {
		Map<TagWithParent, MutableInteger> map = new HashMap<TagWithParent, MutableInteger>();
		
		for (ValidationRule r : ruleList) {
			MutableInteger newVal = new MutableInteger(1);
			//MutableInteger oldVal = map.put(r.getTagName(), newVal);
			MutableInteger oldVal = map.put(new TagWithParent(r.getTagName(), r.getParentTag()), newVal);
			
			if (null != oldVal) {
				newVal.setValue(oldVal.getValue() + 1);
			}
		}
		
		return map;
	}
	
	/**
	 * For test only.
	 * @param ruleList
	 */
	private void dumpAllRules(List<ValidationRule> ruleList) {
		for (ValidationRule r : ruleList) {
			logger.debug(r.toString());
		}
	}
	
	/**
	 * 仅用来封装标签名和父标签
	 * @author whf
	 *
	 */
	private class TagWithParent {
		public String tagName;
		public String parentTag;
		
		public TagWithParent(String tagName) {
			this.tagName = tagName;
		}
		
		public TagWithParent(String tagName, String parentTag) {
			this.tagName = tagName;
			this.parentTag = parentTag;
		}
		
		/**
		 * tagName值相等就认为两个对象相同
		 */
		@Override
		public boolean equals(Object o) {
			if (this == o) {
				return true;
			}
			if (false == o instanceof TagWithParent) {
				return false;
			}
			
			TagWithParent other = (TagWithParent)o;
			return this.tagName.equals(other.tagName);
		}
		
		@Override
		public int hashCode() {
			return tagName.hashCode();
		}
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
