package cn.fh.codeschool.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import cn.fh.codeschool.model.Course;
import cn.fh.codeschool.service.AccountService;
import cn.fh.codeschool.service.CourseService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	private static final Logger logger = Logger.getLogger(HomeController.class);
	
	@Autowired
	private AccountService accountService;
	
	@Autowired
	private CourseService courseService;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		System.out.println("System.out logging message");
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		model.addAttribute("name", "Neo");
		
		return "home";
	}
	
	@RequestMapping(value = "/account", method = RequestMethod.GET)
	public String showAccount(Model model) {
		Course c = courseService.findCourse(13);
		if (c != null) {
			model.addAttribute("course", c.getCourseName());
			logger.info("发现课程：" + c.getCourseName());
		}
		
		return "account";
	}
	
}
