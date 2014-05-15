package cn.fh.codeschool.model;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * 用户发的帖子
 * @author whf
 *
 */

@Entity
@Table(name = "post")
public class Post {
	@Id @GeneratedValue
	private Long id;
	
	private Member author;

	@Column(name = "post_time")
	private Date time;
	
	@Column(name = "post_content", columnDefinition = "TEXT")
	private String content;
	
	@OneToMany(mappedBy = "originalPost", fetch = FetchType.EAGER)
	private List<Postback> postback;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Member getAuthor() {
		return author;
	}

	public void setAuthor(Member author) {
		this.author = author;
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
