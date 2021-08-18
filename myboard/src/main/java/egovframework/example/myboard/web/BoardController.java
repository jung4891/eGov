package egovframework.example.myboard.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

// @Controller 어노테이션을 써줘야 스프링 프레임웍에서  이 클래스가 컨트롤러 라는걸 인식하게 된다.
@Controller
public class BoardController {
	
	@RequestMapping(value = "/main.do")
	public String list(ModelMap model) throws Exception {
		System.out.println("myboard에서 컨트롤러 작동해서 main 호출");
		return "myboard/main";
	}
	
	@RequestMapping(value = "/enroll.do")
	public String enroll(ModelMap model) throws Exception {
		System.out.println("myboard 컨트롤러 -> enroll 호출");
		return "myboard/enroll";
	}
	
	@RequestMapping(value = "/detail.do")
	public String detail(ModelMap model) throws Exception {
		System.out.println("myboard 컨트롤러 -> detail 호출");
		return "myboard/detail";
	}
	
	// http://localhost:8787/login.do?user_id=admin&password=manager
	@RequestMapping(value = "/login.do")
	public String login(@RequestParam("user_id") String user_id,
			          	@RequestParam("password") String password, 
			          	HttpServletRequest request, ModelMap model) throws Exception {
		// String id = request.getParameter("user_id");
		// @RequestParam과 위는 같다. 스프링 프레임웍은 @RequestParam를 주로 쓴다.
		System.out.println("myboard 컨트롤러 > login으로 main 호출");
		System.out.println("user_id:" + user_id);
		System.out.println("password:" + password);
		return "myboard/main";
	}
	
}
