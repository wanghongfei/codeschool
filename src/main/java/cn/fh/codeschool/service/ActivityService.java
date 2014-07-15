package cn.fh.codeschool.service;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import cn.fh.codeschool.model.RecentActivity;

@Repository
@Transactional
public class ActivityService {
	@PersistenceContext
	private EntityManager em;

	/**
	 * 查询某用户的前amount条活动
	 * @param username
	 * @param amount
	 * @return
	 */
	public List<RecentActivity> queryActivities(String username, int amount) {
		return em.createQuery("SELECT ac FROM RecentActivity ac WHERE ac.member.username = :username", RecentActivity.class)
			.setParameter("username", username)
			.setMaxResults(amount)
			.getResultList();
	}
}
