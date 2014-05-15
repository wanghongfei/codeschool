package cn.fh.codeschool.model;

/**
 * 封装 (课程名 / 完成百分比)
 * @author whf
 *
 */
public class CourseProgressWrapper {
	private String courseName;
	private Integer progress;
	
	private Integer courseId;
	private Integer sectionId;
	
	
	public String getCourseName() {
		return courseName;
	}
	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}
	public Integer getProgress() {
		return progress;
	}
	public void setProgress(Integer progress) {
		this.progress = progress;
	}
	public Integer getCourseId() {
		return courseId;
	}
	public void setCourseId(Integer courseId) {
		this.courseId = courseId;
	}
	public Integer getSectionId() {
		return sectionId;
	}
	public void setSectionId(Integer sectionId) {
		this.sectionId = sectionId;
	}
}