package cn.fh.codeschool.service;

import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.fh.codeschool.model.CourseSection;
import cn.fh.codeschool.model.Member;
import cn.fh.codeschool.service.validation.Validator;

/**
 * @author whf
 *
 */
@Service
public class ValidationService {
	
	@Autowired
	private Validator htmlValidator;
	
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
	public boolean process(CourseSection cs, Member m, String code) {
		boolean result = false;
		htmlValidator.setCode(code);
		
		
		// 得到当前小节实体
		//CourseSection cs = courseBean.findSection();
				
		// 执行验证
		result = htmlValidator.validate(cs.getRules());
		if (true == result ) {
			if (false == isCurrentSectionHasFinished(cs, m)) {
				// 将当前课程标记已经通过
				m.getFinishedSections().add(cs);
				log.info("用户 {} 通过的课程数量:{}", m.getUsername(), m.getFinishedSections().size());
				// 用户分数加1
				m.increasePoint();
				// 完成人数加1
				cs.increaseFinishedAmount();
				sectionService.updateSection(cs);
				log.info("用户 {} 分数 + 1, 当前分数：{}", m.getUsername(), m.getPoint());
				// 更新数据库
				accountService.saveMember(m);
			} else {
				log.info("用户重复学习此课程，不加分");
			}
		}
		
		this.message = htmlValidator.getResultMessage();
		return result;
	}
	
	
	/**
	 * 判断当前的小节是否此前已经被学习过了
	 * @return
	 */
	private boolean isCurrentSectionHasFinished(CourseSection cs, Member m) {
		Set<CourseSection> sections = m.getFinishedSections();
		
		for( CourseSection c : sections) {
			if (c.getId() == cs.getId()) {
				return true;
			}
		}
		
		
		return false;
	}


	public String getMessage() {
		return message;
	}
	

}
