package cn.fh.codeschool.service;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.fh.codeschool.model.CourseSection;
import cn.fh.codeschool.model.Member;
import cn.fh.codeschool.model.Post;

@Service
@Transactional(readOnly = true)
public class PostService {
	@PersistenceContext
	private EntityManager em;
	
	private TypedQuery<Post> fetchPostByMemberQuery;
	private TypedQuery<Post> fetchPostBySectionQuery;
	
	/**
	 * 创建所需要的Query对象，以提高性能
	 */
	@PostConstruct
	public void initQuery() {
		this.fetchPostByMemberQuery = em.createNamedQuery("Post.findRecentPost", Post.class);
		this.fetchPostBySectionQuery = em.createQuery("SELECT p FROM Post p WHERE p.section=:section ORDER BY p.time DESC", Post.class);
	}
	
	/**
	 * 查询某个用户最近发的 tot 篇帖子
	 * @param m
	 * @param tot
	 * @return
	 */
	public List<Post> fetchRecentPost(Member m, int tot) {
		return fetchPostByMemberQuery.setParameter("author", m)
				.setMaxResults(tot)
				.getResultList();
	}
	
	public List<Post> fetchRecentPost(CourseSection section, int tot) {
		return null;
	}
}
