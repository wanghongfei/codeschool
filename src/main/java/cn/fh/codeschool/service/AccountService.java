package cn.fh.codeschool.service;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import cn.fh.codeschool.model.Member;
import cn.fh.codeschool.model.Role;

@Repository
@Transactional(readOnly = true)
public class AccountService {
	private static final Logger logger = LoggerFactory.getLogger(AccountService.class);
	
	@PersistenceContext
	private EntityManager em;
	
	@Autowired
	private CourseService courseService;
	
	private String message;
	
	/**
	 * 返回用户完成某一课程百分比
	 * @param m
	 * @param courseId
	 * @return
	 */
	public int fetchPercentageByCourse(Member m, Integer courseId) {
		// 得到某课程所有的小节id
		List<Integer> allSectionIds = courseService.fetchSectionIdsByCourse(courseId);
		List<Integer> finishedIds = m.getFinishedSectionIdList();

		// 用户一个小节也没完成
		if (null == finishedIds) {
			return 0;
		}
		
		int sum = 0;
		for (Integer id : allSectionIds) {
			if (m.getFinishedSectionIdList().contains(id)) {
				++sum;
			}
		}
		
		double percentage = sum / (double)allSectionIds.size();
		//System.out.println("百分比:" + percentage + ", sum = " + sum);
		
		return (int)(percentage * 100);
	}
	
	/**
	 * 更新Member到数据库
	 * @param m
	 */
	@Transactional(readOnly = false)
	public void saveMember(Member m) {
		em.merge(m);
	}
	
	/**
	 * 返回普通用户的 role
	 * @return
	 */
	public Role fetchUserRole() {
		return em.createQuery("select r from Role r where r.roleName='user'", Role.class)
				.getSingleResult();
	}
	
	/**
	 * 返回所有可用的 role
	 * @return
	 */
	public List<Role> roleList() {
		return em.createNamedQuery("Role.fecthAllRoles", Role.class)
				.getResultList();
	}
	
	/**
	 * 查询数据库得到当前比用户分高的用户数量
	 * @param m
	 */
	@Transactional(readOnly = false)
	public void updateRank(Member m) {
		Long rank = em.createQuery("select count(m.id) from Member m where m.point>:point", Long.class)
			.setParameter("point", m.getPoint())
			.getSingleResult();
		
		m.setRank(rank + 1);
		this.saveMember(m);
		
		logger.info("用户排名:{}", m.getRank());
	}
	
	/**
	 * 返回数据库中所有的用户名
	 * @return
	 */
	public List<String> findMemberName() {
		return em.createQuery("select m.username from Member m", String.class)
				.getResultList();
	}
	
	/**
	 * 根据用户名查找用户
	 * @param username
	 * @return 用户不存在返回 null
	 */
	public Member findMember(String username) {
		List<Member> ms = em.createQuery("select m from Member m where m.username=:username", Member.class)
				.setParameter("username", username)
				.getResultList();
		
		if (0 == ms.size()) {
			return null;
		}
		
		return ms.get(0);
	}
	
	/**
	 * 从数据库中查找用户，并判断用户名密码是否正确
	 * @param username
	 * @param pwd
	 * @return 验证通过返回 Member 实体，否则返回null.错误信息保存在 message 成员变量中
	 */
	public Member findMember(String username, String pwd) {
		List<Member> ms = em.createNamedQuery("Member.findMember", Member.class)
				.setParameter("username", username)
				.getResultList();
		
		if (0 == ms.size()) {
			this.message = "该用户不存在!";
			System.out.println(this.message);
			return null;
		}
		
		Member m = ms.get(0);
		if (!m.getPassword().equals(pwd)) {
			this.message = "密码错误";
			System.out.println(this.message);
			return null;
		}
		
		logger.info("用户 {} 验证成功", username);
		return m;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

}
