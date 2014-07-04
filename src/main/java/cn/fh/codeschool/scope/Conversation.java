package cn.fh.codeschool.scope;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

/**
 * 一个对话上下文
 * @author whf
 *
 */
public class Conversation {
	private Long cid;
	private Date lastUpdateTime; // 最近一次操作该对话的时间
	
	
	/**
	 * 存放bean的map
	 */
	private Map<String, Object> beanMap = new HashMap<String, Object>();
	
	/**
	 * 创建一个新的Conversation上下文，并分配cid
	 */
	public Conversation() {
		this.cid = ConversationManager.nextId();
		this.lastUpdateTime = new Date();
		
	}

	public Object getBean(String name) {
		updateTime();
		return beanMap.get(name);
	}
	
	public void addBean(String name, Object bean) {
		updateTime();
		beanMap.put(name, bean);
	}
	
	public void removeBean(String name) {
		updateTime();
		beanMap.remove(name);
	}
	
	/**
	 * 更新最近一次操作该对话的时间
	 */
	private void updateTime() {
		this.lastUpdateTime = new Date();
	}

	/**
	 * 重写equals方法，当cid相同时认为两个Conversation相同。
	 */
	@Override
	public boolean equals(Object obj) {
		if (obj == this) {
			return true;
		}
		
		if (false == obj instanceof Conversation) {
			return false;
		}
		
		Conversation c = (Conversation)obj;
		return c.cid.equals(this.cid);
	}

	
	public Long getCid() {
		return cid;
	}

	public void setCid(Long cid) {
		this.cid = cid;
	}


	public Date getLastUpdateTime() {
		return lastUpdateTime;
	}
	
}
