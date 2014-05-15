package cn.fh.codeschool.service;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NamedQuery;
import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;
import javax.persistence.PersistenceContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import cn.fh.codeschool.model.Course;
import cn.fh.codeschool.model.CourseChapter;
import cn.fh.codeschool.model.CourseSection;

/**
 * Encapsulate Course entity CRUD operation.
 * @author whf
 *
 */

@NamedQuery(
		name = "Course.findCourseByName",
		query = "select c from Course c where " +
				"c.courseName = :name"
		)

@Repository
@Transactional
public class CourseService {
	private static final Logger logger = LoggerFactory.getLogger(CourseService.class);
	
	@PersistenceContext
	private EntityManager em;
	
	/**
	 * 仅返回课程名称
	 * @param courseId
	 * @return
	 */
	public String fetchCourseName(Integer courseId) {
		System.out.println("传入courseId : " + courseId);
		return em.createQuery("select c.courseName from Course c where c.id=:id", String.class)
				.setParameter("id", courseId)
				.getSingleResult();
	}
	
	/**
	 * 查询所有课程的id
	 * @return
	 */
	public List<Integer> fetchCourseIds() {
		return em.createQuery("select c.id from Course c", Integer.class)
				.getResultList();
	}
	
	/**
	 * 返回某课程所有小节的id
	 * @param courseId 课程实体id
	 * @return
	 */
	public List<Integer> fetchSectionIdsByCourse(Integer courseId) {
		Course course = this.findCourse(courseId);
		List<CourseChapter> chapters = course.getCourseChapters();
		
		// 遍历所有小节,把id放入ids中
		List<Integer> ids = new ArrayList<Integer>();
		for (CourseChapter chapter : chapters) {
			for (CourseSection section : chapter.getCourseSections()) {
				ids.add(section.getId());
			}
		}
		
		return ids;
	}
	
	/**
	 * 删除一个课程
	 * @param c
	 */
	public void delete(Integer id) {
		Course c = em.find(Course.class, id);
		em.remove(c);
	}
	
	/**
	 * 查询所有 Course 实体
	 * @return
	 */
	public List<Course> courseList() {
		return em.createNamedQuery("Course.findAllCourses", Course.class).getResultList();
	}
	
	
	/**
	 * 根据课程名查找课程，课程名必须是唯一的
	 * @param name 课程名
	 * @return
	 */
	public Course findCourseByName(String name) {
		Course c = null;
		
		try {
			c = em.createNamedQuery("Course.findCourseByName", Course.class)
					.setParameter("name", name)
					.getSingleResult();
		} catch (NonUniqueResultException ex) {
			logger.error("有重名的课程!");
		} catch (NoResultException ex) {
			logger.error("没有找到名为 {} 的课程", name);
		}
		
		return c;
	}
	
	/**
	 * 通过 id 查找Course实体
	 * @param id
	 * @return
	 */
	public Course findCourse(Integer id) {
		if (null == id) {
			logger.info("course id 不能为空");

			return null;
		}
		
		return em.find(Course.class, id);
	}
	
	/**
	 * 持久化一个 Course
	 * @param c
	 */
	public void saveCourse(Course c) {
		em.persist(c);
	}
	
	
}
