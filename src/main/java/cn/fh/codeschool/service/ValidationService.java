package cn.fh.codeschool.service;

import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import cn.fh.codeschool.model.CourseSection;
import cn.fh.codeschool.model.Member;
import cn.fh.codeschool.model.RecentActivity;
import cn.fh.codeschool.service.validation.Validator;

/**
 * @author whf
 *
 */
@Service
public class ValidationService {
	
	@Autowired
	@Qualifier("html")
	private Validator htmlValidator;

	@Autowired
	@Qualifier("result")
	private Validator resultValidator;
	
	@Autowired
	private AccountService accountService;
	
	@Autowired
	private SectionService sectionService;
	
	private String message;
	
	
	private static final Logger log = LoggerFactory.getLogger(ValidationService.class);
	
	
	/**
	 * 执行验证.反馈信息保存到 this.message 中
	 * @param cs 当前是小节实体
	 * @param m 登陆用户实体
	 * @param code 用户代码
	 * @return 验证结果
	 */
	public boolean process(CourseSection cs, Member m, String code, String lan) {
		boolean result = false;
		
		
		// 得到当前小节实体
		//CourseSection cs = courseBean.findSection();
				
		// 执行验证
		if ("html".equals(lan)) {
			htmlValidator.setCode(code);
			result = htmlValidator.validate(cs.getRules());
			this.message = htmlValidator.getResultMessage();
		} else if ("javascript".equals(lan)) {
			resultValidator.setCode(code);
			result = resultValidator.validate(cs.getRules());
			this.message = resultValidator.getResultMessage();
		}
		
		
		if (true == result ) {
			if (false == isCurrentSectionHasFinished(cs, m)) {
				// 将当前课程标记已经通过
				m.addSectionId(cs.getId());
				log.info("用户 {} 通过的课程数量:{}", m.getUsername(), m.getFinishedSectionIds().split(";").length);

				// 用户分数加1
				m.increasePoint();

				// 完成人数加1
				cs.increaseFinishedAmount();
				sectionService.updateSection(cs);
				log.info("用户 {} 分数 + 1, 当前分数：{}", m.getUsername(), m.getPoint());
				
				
				// 更新用户最近活动
				m.getRecentActivity().add(new RecentActivity("完成了{" + cs.getSectionName() + "}小节", new Date(), m));
				
				// 更新数据库
				accountService.saveMember(m);
			} else {
				log.info("用户重复学习此课程，不加分");
			}
		}
		
		return result;
	}
	
	
	/**
	 * 判断当前的小节是否此前已经被学习过了
	 * @return
	 */
	private boolean isCurrentSectionHasFinished(CourseSection cs, Member m) {
		if (null == m.getFinishedSectionIds()) {
			return false;
		}
		
		String[] ids = m.getFinishedSectionIds().split(";");
		for (String strId : ids) {
			if (strId.equals(cs.getId().toString()))
				return true;
		}
		
/*		for( CourseSection c : sections) {
			if (c.getId() == cs.getId()) {
				return true;
			}
		}
*/		
		
		return false;
	}


	public String getMessage() {
		return message;
	}
	

}
