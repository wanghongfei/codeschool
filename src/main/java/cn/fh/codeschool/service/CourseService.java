package cn.fh.codeschool.service;

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
			logger.error("没有找到名为 " + name + " 的课程");
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
