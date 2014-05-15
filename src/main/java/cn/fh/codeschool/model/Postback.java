package cn.fh.codeschool.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * 回帖
 * @author whf
 *
 */
@Entity
@Table(name = "postback")
public class Postback {
	@Id @GeneratedValue
	private Long id;
	
	@ManyToOne
	@JoinColumn(name = "original_post_id")
	private Post originalPost;
	
	@Column(name = "post_time")
	private Date time;
	
	@Column(name = "post_content", columnDefinition = "TEXT")
	private String content;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Post getOriginalPost() {
		return originalPost;
	}

	public void setOriginalPost(Post originalPost) {
		this.originalPost = originalPost;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
}
