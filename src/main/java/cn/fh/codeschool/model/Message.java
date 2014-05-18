package cn.fh.codeschool.model;

import java.util.Date;

/**
 * 用户发送的一条聊天消息
 * @author whf
 *
 */
public class Message {
	private String content;
	private Date time;
	
	private String toUser; // 目标用户
	private String fromUser; // 来源用户
	
	private boolean isPosted; // 是否已经发送给目标用户

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public String getToUser() {
		return toUser;
	}

	public void setToUser(String toUser) {
		this.toUser = toUser;
	}

	public String getFromUser() {
		return fromUser;
	}

	public void setFromUser(String fromUser) {
		this.fromUser = fromUser;
	}

	public boolean isPosted() {
		return isPosted;
	}

	public void setPosted(boolean isPosted) {
		this.isPosted = isPosted;
	}


}
