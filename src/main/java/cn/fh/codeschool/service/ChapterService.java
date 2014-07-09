package cn.fh.codeschool.service;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import cn.fh.codeschool.model.Course;
import cn.fh.codeschool.model.CourseChapter;
import cn.fh.codeschool.model.CourseSection;

@Repository
@Transactional
public class ChapterService {
	@PersistenceContext
	private EntityManager em;
	
	@Autowired
	private CourseService courseService;
	
	/**
	 * Delete a Chapter
	 * @param id
	 */
	public boolean deleteChapter(Integer id) {
		if (null == id) {
			return false;
		}

		CourseChapter cc = findChapter(id);
		if (null == cc) {
			return false;
		}

		em.remove(cc);
		return true;
	}
	
	/**
	 * Merge a detached CourseChapter entity.
	 * @param chapter
	 */
	public void updateChapter(CourseChapter chapter) {
		em.merge(chapter);
	}
	
	/**
	 * 保存一个 CourseChapter 实体。但首先要传入该章节所属于的课程的id
	 * @param chapter 要保存的CourseChapter entity
	 * @param courseId 该章节所属于的课程的id
	 */
	public void saveChapter(CourseChapter chapter, Integer courseId) {
		Course c = courseService.findCourse(courseId);
		chapter.setCourse(c);
		em.persist(chapter);
		
	}
	

	/**
	 * 查询指定课程的所有章节, Eager 加载
	 * @param courseId 课程实体id
	 * @return
	 */
	@Transactional(readOnly = true)
	public List<CourseChapter> chapterListEager(Integer courseId) {
		Course c = courseService.findCourse(courseId);
		List<CourseChapter> chapters = em.createNamedQuery("CourseChapter.findCourseChapters", CourseChapter.class)
				.setParameter("course", c)
				.getResultList(); 
		
		// 触发eager加载
		for (CourseChapter cc : chapters) {
			for (CourseSection cs : cc.getCourseSections()) {
				cs.getId();
			}
		}
		
		return chapters;
	}
	
	/**
	 * 查询指定课程的所有章节
	 * @param courseId 课程实体id
	 * @return
	 */
	@Transactional(readOnly = true)
	public List<CourseChapter> chapterList(Integer courseId) {
		Course c = courseService.findCourse(courseId);
		
		return em.createNamedQuery("CourseChapter.findCourseChapters", CourseChapter.class)
				.setParameter("course", c)
				.getResultList();
	}
	
	/**
	 * 根据id查找章节
	 * @param id
	 * @return
	 */
	@Transactional(readOnly = true)
	public CourseChapter findChapter(Integer id) {
		return em.find(CourseChapter.class, id);
	}
}
