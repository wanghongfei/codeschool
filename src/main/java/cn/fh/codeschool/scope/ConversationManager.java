package cn.fh.codeschool.scope;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

public class ConversationManager {
	private static Long nextId = 1L;
	public static Long expireTime = 1000 * 60 * 10L; // 超时时间, 10分钟
	
	private HttpSession session;
	
	// All conversations are stored here
	private List<Conversation> conversationList = new ArrayList<Conversation>();
	
	public ConversationManager(HttpSession session) {
		this.session = session;
	}
	
	/**
	 * Create a new Conversation object
	 * @return The new Conversation instance.
	 */
	public Conversation createConversation() {
		Conversation c = new Conversation();
		conversationList.add(c);
		
		return c;
	}
	
	/**
	 * Fetch Conversation by cid
	 * @param cid Conversatin id
	 * @return null if not found
	 */
	public Conversation findConversation(Long cid) {
		for (Conversation c : conversationList) {
			if (c.getCid().equals(cid)) {
				return c;
			}
		}
		
		return null;
	}
	
	
	/**
	 * 生成下一个对话id
	 * @return
	 */
	public static Long nextId() {
		return nextId++;
	}



	public List<Conversation> getConversationList() {
		return conversationList;
	}

	public HttpSession getSession() {
		return session;
	}

}
