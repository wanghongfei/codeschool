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
	private static int PAGE_SIZE = 3;

	@PersistenceContext
	private EntityManager em;
	
	/**
	 * 保存一条回复
	 * @param targetCommentId
	 * @param reply
	 */
	public void saveReply(Integer targetCommentId, Comment reply) {
		Comment target = findComment(targetCommentId);
		em.persist(reply);
		target.setHasReply(1);
		target.getReplyList().add(reply);
	}
	
	/**
	 * 保存对一个小节的评论
	 * @param m
	 * @param cs
	 * @param cm
	 */
	public void save(Member m, CourseSection cs, Comment cm) {
		cm.setMember(m);
		cm.setCourseSection(cs);
		em.persist(cm);
	}
	
	/**
	 * 根据id查找Comment实体
	 * @param id
	 * @return
	 */
	@Transactional(readOnly = true)
	public Comment findComment(Integer id) {
		return em.find(Comment.class, id);
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
	
	/**
	 * 判断是否存在下一页
	 * @param cs 课程小节
	 * @param curPage 当前页数
	 * @return
	 */
	public boolean isNextPageAvailable(CourseSection cs, int curPage) {
		long tot = queryCommentAmount(cs);
		long remnant = tot % PAGE_SIZE;
		
		if (0 == remnant) {
			return curPage < tot / PAGE_SIZE;
		} else {
			return curPage <= tot / PAGE_SIZE;
		}
	}
	
	/**
	 * 判断是否存在上一页
	 * @param cs
	 * @param curPage
	 * @return
	 */
	public boolean isPreviousPageAvailable(int curPage) {
		return curPage > 1;
	}
	
	/**
	 * 得到一个小节评论的数量
	 * @param cs
	 * @return
	 */
	public Long queryCommentAmount(CourseSection cs) {
		return em.createQuery("SELECT COUNT(c) FROM Comment c WHERE c.courseSection = :section", Long.class)
				.setParameter("section", cs)
				.getSingleResult();
	}
	
	/**
	 * 得到第 page 页的评论
	 * @param cs
	 * @param page 页数
	 * @return
	 */
	public List<Comment> queryComentsByPage(CourseSection cs, int page) {
		List<Comment> comList = em.createQuery("SELECT c FROM Comment c WHERE c.courseSection = :section", Comment.class)
				.setParameter("section", cs)
				.setMaxResults(PAGE_SIZE)
				.setFirstResult(PAGE_SIZE * (page - 1))
				.getResultList();

		// trigger eager fetching
		for (Comment com : comList) {
			com.getMember().getUsername();
			com.getCourseSection().getSectionName();
			
			// 如果有回复则加载回复
			if (1 == com.getHasReply()) {
				List<Comment> repList = com.getReplyList();
				for (Comment rep : repList) {
					rep.getMsgTime();
				}
			}
		}
		
		
		return comList;
	}
}
