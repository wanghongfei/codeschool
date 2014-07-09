package cn.fh.codeschool.service;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import cn.fh.codeschool.model.Course;
import cn.fh.codeschool.model.CourseChapter;
import cn.fh.codeschool.model.CourseSection;
import cn.fh.codeschool.model.ValidationRule;

@Repository
@Transactional(readOnly = true)
public class SectionService {
	private static final Logger logger = LoggerFactory.getLogger(SectionService.class);

	@PersistenceContext
	private EntityManager em;
	
	@Autowired
	private ChapterService chapterService;
	
	/**
	 * Delete section
	 * @param id
	 * @return Return true if deletion succeeded, otherwise return false.
	 */
	@Transactional(readOnly = false)
	public boolean deleteSection(Integer id) {
		if (null == id) {
			return false;
		}
		
		CourseSection cs = em.find(CourseSection.class, id);
		if (null == cs) {
			return false;
		}

		em.remove(cs);
		return true;
	}
	
	/**
	 * 与数据库同步
	 * @param cs
	 */
	@Transactional(readOnly = false)
	public void updateSection(CourseSection cs) {
		em.merge(cs);
	}
	
	/**
	 * 通过ID查找section，并触发eager加载
	 * @param id
	 * @return
	 */
	public CourseSection findSectionEager(Integer id) {
		CourseSection cs = em.find(CourseSection.class, id);
		
		// eager 加载章节
		for (CourseSection c : cs.getCourseChapter().getCourseSections()) {
			c.getId();
		}
		
		return cs;
	}
	
	/**
	 * 通过id查找section
	 * @param id
	 * @return
	 */
	public CourseSection findSection(Integer id) {
		return em.find(CourseSection.class, id);
	}
	
	/**
	 * 持久化 CourseSection entity. 需传入章节实体id, 和本节的验证规则
	 * @param section
	 * @param chapterId
	 */
	@Transactional(readOnly = false)
	public void saveSection(CourseSection section, ValidationRule rule, Integer chapterId) {
		em.persist(rule);

		CourseChapter chapter = em.find(CourseChapter.class, chapterId);
		section.setCourseChapter(chapter);
		section.getRules().add(rule);
		
		// 将课程实体中section数量 +1
		Course course = chapter.getCourse();
		course.setSectionAmount(course.getSectionAmount() + 1);

		em.persist(section);
	}
	
	/**
	 * 根据查找某章节的所有小节
	 * @param chapterId 章节id
	 * @return
	 */
	public List<CourseSection> sectionList(Integer chapterId) {
		CourseChapter c = chapterService.findChapter(chapterId);
		
		return em.createNamedQuery("CourseSection.findCourseSections", CourseSection.class)
				.setParameter("courseChapter", c)
				.getResultList();
	}
}
