package cn.fh.codeschool.model;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * 用户发的帖子
 * @author whf
 *
 */

@NamedQuery(
		name = "Post.findRecentPost",
		query = "SELECT p FROM Post p WHERE p.author=:author ORDER BY p.time DESC"
		)

@Entity
@Table(name = "post")
public class Post {
	@Id @GeneratedValue
	private Long id;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "author_id")
	private Member author;
	
	/**
	 * 所属于的小节
	 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "section_id")
	private CourseSection section;

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
