package cn.fh.codeschool.service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import cn.fh.codeschool.model.Course;

@Repository
@Transactional
public class CourseService {
	private static final Logger logger = Logger.getLogger(CourseService.class);
	
	@PersistenceContext
	private EntityManager em;
	
	public Course findCourse(Integer id) {
		if (null == em) {
			logger.info("entity Manager为空");
			return null;
		}
		return em.find(Course.class, id);
	}
}
