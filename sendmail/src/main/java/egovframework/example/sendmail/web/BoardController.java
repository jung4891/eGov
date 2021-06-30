package egovframework.example.sendmail.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

// @Controller 어노테이션을 써줘야 스프링 프레임웍에서  이 클래스가 컨트롤러 라는걸 인식하게 된다.
@Controller 
public class BoardController {
	
	@RequestMapping(value = "/main.do")
	public String main(ModelMap model) throws Exception {
		return "sendmail/main"; 
	}
	
	@RequestMapping(value = "/charts.do")
	public String charts(ModelMap model) throws Exception {
		return "sendmail/charts"; 
	}
	
}
