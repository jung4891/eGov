package com.home.test;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		return "home";
	}
	
	@RequestMapping(value = "/ajax", method = RequestMethod.GET)
	public String ajax() {
		return "ajax";
	}
	
	@RequestMapping(value="/requestObject", method=RequestMethod.POST)
    @ResponseBody
    public String simpleWithObject(Person person, @RequestParam("test") String test) {
        //필요한 로직 처리
        return person.getName() + " " + person.getAge() + " / test: " + test ;
    }
/*	@RequestMapping과 @ResponseBody	
	@RequestMapping으로 String type을 반환해주면, ViewResolver에서 정의한 prefix와 suffix가 return값에 추가되어 view로 이동이 된다.
	@ResponseBody를 사용해주면 view를 생성해주는것이 아니라, JSON 혹은 Object 형태 또는 String 그대로 데이터를 넘겨준다. */
	
	@RequestMapping(value="/serialize", method=RequestMethod.POST)
    @ResponseBody
    public String serialize(Person person) {
        //필요한 로직 처리   
        return person.getName() + " -> " + person.getAge();
    }
	
	
}
