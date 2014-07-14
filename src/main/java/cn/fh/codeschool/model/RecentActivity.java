package cn.fh.codeschool.model;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;


@Entity
@Table(name = "recent_activity")
public class RecentActivity {
	@Transient
	public static SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-M-dd hh:mm:ss");
	
	
	@Id @GeneratedValue
	private Long id;
	
	@Column(name = "content", columnDefinition = "TEXT")
	private String content;
	private Date occurTime;
	
	public RecentActivity() {}

	public RecentActivity(String content, Date occurTime, Member member) {
		this.content = content;
		this.occurTime = occurTime;
		this.member = member;
	}


	@ManyToOne
	private Member member;


	public String getTime() {
		return dateFormat.format(this.occurTime);
	}

	public Long getId() {
		return id;
	}


	public void setId(Long id) {
		this.id = id;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public Date getOccurTime() {
		return occurTime;
	}


	public void setOccurTime(Date occurTime) {
		this.occurTime = occurTime;
	}


	public Member getMember() {
		return member;
	}


	public void setMember(Member member) {
		this.member = member;
	}
}
