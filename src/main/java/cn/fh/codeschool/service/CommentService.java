package cn.fh.codeschool.service;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import cn.fh.codeschool.model.Comment;
import cn.fh.codeschool.model.CourseSection;
import cn.fh.codeschool.model.Member;

@Repository
@Transactional
public class CommentService {
	private Logger logger = LoggerFactory.getLogger(CommentService.class);

	@PersistenceContext
	private EntityManager em;
	
	public void save(Member m, CourseSection cs, Comment cm) {
		cm.setMember(m);
		cm.setCourseSection(cs);
		em.persist(cm);
	}
	
	/**
	 * Obtain all Comments belonging to the specified Section
	 * @param cs
	 * @return
	 */
	@Transactional(readOnly = true)
	public List<Comment> queryComments(CourseSection cs) {
		List<Comment> comList =  em.createQuery("SELECT c FROM Comment c WHERE c.courseSection = :section", Comment.class)
			.setParameter("section", cs)
			.getResultList();
		
		// trigger eager fetching
		for (Comment com : comList) {
			com.getMember().getUsername();
			com.getCourseSection().getSectionName();
		}
		
		return comList;
	}
}
