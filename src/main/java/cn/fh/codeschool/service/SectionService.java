package cn.fh.codeschool.service;

import java.util.ArrayList;
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
import cn.fh.codeschool.service.validation.RuleType;

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
	 * 保存一个小节
	 * 
	 * @param section 
	 * @param chapterId
	 * @param tagName
	 * @param attrName
	 * @param attrValue
	 * @param output
	 * @param type
	 * @param isUpdate 是否是更新小节操作
	 */
	@Transactional(readOnly = false)
	public void saveSection(CourseSection section,
			Integer chapterId,
			String tagName,
			String attrName,
			String attrValue,
			String output,
			RuleType type,
			boolean isUpdate) {
		
		if (false == isUpdate) {
			em.persist(section);
		} else {
			section = em.merge(section);
		}
		
		List<ValidationRule> ruleList = new ArrayList<ValidationRule>();
		// 需要包含规则
		// 可能有多条
		if (type == RuleType.CONTAIN) {
			//valRule.setTagName(tagName);
			
			String[] tags = tagName.split(",");
			for (String tag : tags) {
				ValidationRule rule = new ValidationRule();
				rule.setRuleType(type.toString());
				rule.setTagName(tag);
				ruleList.add(rule);
			}
			
			
		// 需要属性	
		} else if (type == RuleType.ATTRIBUTE) {
			String[] tags = tagName.split(",");
			String[] attrs = attrName.split(",");
			String[] values = attrValue.split(",");
			
			for (int ix = 0 ; ix < tags.length ; ++ix) {
				ValidationRule rule = new ValidationRule();
				rule.setRuleType(type.toString());
				rule.setTagName(tags[ix]);
				rule.setAttrName(attrs[ix]);
				rule.setAttrValue(values[ix]);
				
				ruleList.add(rule);
			}

			//valRule.setTagName(tagName);
			//valRule.setAttrName(attrName);
			//valRule.setAttrValue(attrValue);
		} else if (type == RuleType.OUTPUT) {
			ValidationRule rule = new ValidationRule();
			rule.setRuleType(type.toString());
			rule.setOutput(output);
			ruleList.add(rule);

			//valRule.setOutput(output);
		} else if (type == RuleType.NONE) {
			ValidationRule rule = new ValidationRule();
			rule.setRuleType(type.toString());
			ruleList.add(rule);
		} else {
			logger.error("不支持的规则类型: {}", type.toString());
		}
		
		
		
		
		CourseChapter chapter = em.find(CourseChapter.class, chapterId);
		section.setCourseChapter(chapter);
		//section.getRules().add(rule);
		
		// 如果是更新小节操作，
		// 则先删除先前保存过的Rule
		if (true == isUpdate) {
			// 调用存储过程进行删除
			int tot = em.createNativeQuery("CALL delete_rules(:sectionId)")
				.setParameter("sectionId", section.getId())
				.executeUpdate();

			System.out.println("@@ FLUSH前, : " + tot);
			em.flush();
			System.out.println("@@ FLUSH后");
			
		}

		// 持久化Rule
		section.getRules().clear();
		for (ValidationRule r : ruleList) {
			em.persist(r);
			section.getRules().add(r);
		}
		for (ValidationRule r : section.getRules()) {
			System.out.println("添加后:" + r.getId() + ", type:" + r.getRuleType() );
 		}

		
		// 将课程实体中section数量 +1
		Course course = chapter.getCourse();
		course.setSectionAmount(course.getSectionAmount() + 1);

		
		
	}
	
	/**
	 * @deprecated
	 * 持久化 CourseSection entity. 需传入章节实体id, 和本节的验证规则
	 * @param section
	 * @param chapterId
	 */
	@Transactional(readOnly = false)
	//public void saveSection(CourseSection section, ValidationRule rule, Integer chapterId) {
	public void saveSection(CourseSection section, List<ValidationRule> ruleList, Integer chapterId) {
		CourseChapter chapter = em.find(CourseChapter.class, chapterId);
		section.setCourseChapter(chapter);
		//section.getRules().add(rule);

		for (ValidationRule r : ruleList) {
			em.persist(r);
			section.getRules().add(r);
		}

		//em.persist(rule);

		
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
