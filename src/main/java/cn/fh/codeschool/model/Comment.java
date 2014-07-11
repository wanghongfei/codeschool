package cn.fh.codeschool.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;


/**
 * The persistent class for the comment database table.
 * 
 */
@Entity
@Table(name="comment")
@NamedQuery(name="Comment.findAll", query="SELECT c FROM Comment c")
public class Comment implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int id;

	@Column(name="msg_content")
	private String msgContent;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="msg_time")
	private Date msgTime;

	//bi-directional many-to-one association to Member
	@ManyToOne
	private Member member;

	//bi-directional many-to-one association to CourseSection
	@ManyToOne
	@JoinColumn(name="course_section_id")
	private CourseSection courseSection;

	public Comment() {
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getMsgContent() {
		return this.msgContent;
	}

	public void setMsgContent(String msgContent) {
		this.msgContent = msgContent;
	}

	public Date getMsgTime() {
		return this.msgTime;
	}

	public void setMsgTime(Date msgTime) {
		this.msgTime = msgTime;
	}

	public Member getMember() {
		return this.member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public CourseSection getCourseSection() {
		return this.courseSection;
	}

	public void setCourseSection(CourseSection courseSection) {
		this.courseSection = courseSection;
	}

}