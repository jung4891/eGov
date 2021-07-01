package egovframework.example.sendmail.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.example.sendmail.service.MailService;
import egovframework.example.sendmail.service.MailVO;

/*
< 컨트롤러 수정해도 서버에서 자동 빌드가 안되고 웹페이지는 Not Found 뜰떄... >
	프로젝트 우클릭 > 빌드Path > missing인 부분 remove(이번엔 test 폴더를 지웠는데 여기에 빌드path가 잡혀 있어서 안됬던거임)
	잘 안될때 결과창 아래에 Problems 꼭 보기!!!
*/

@Controller  
public class MailController {
	
	/** MailService */
	@Resource(name = "mailService")
	private MailService mailService;
	
	@RequestMapping(value = "/main.do")
	public String main(ModelMap model) throws Exception {
		System.out.println("sendmail의 main 호출");
		return "sendmail/main"; 
	}
	
	@RequestMapping(value = "/loginPage.do")
	public String loginPage(ModelMap model) throws Exception {
		System.out.println("sendmail의 login 호출");  
		return "sendmail/login";        
	}

	@RequestMapping(value = "/login.do")
	public String login(@RequestParam("user_id") String user_id,
			          	@RequestParam("password") String password, 
			          	HttpServletRequest request,
			          	RedirectAttributes r, ModelMap model) throws Exception {
		
		System.out.println("여기는 오나?");
		MailVO mailVO = new MailVO();
		mailVO.setUserId(user_id);
		mailVO.setPassword(password);
		String user_name = mailService.selectLoginCheck(mailVO);
		System.out.println("user_name:" + user_name);
		
//		if( user_name != null && !"".equals(user_name)) {
//			request.getSession().setAttribute("userId", user_id);
//			request.getSession().setAttribute("userName", user_name);  // Mail_SQL에서 name 가져오게끔 설정.
//		}else {
//			request.getSession().setAttribute("userId", "");
//			request.getSession().setAttribute("userName", "");
//			r.addFlashAttribute("msg", "사용자 정보가 올바르지 않습니다.");
//
//		}
		return "redirect:/main.do";
	}
	 
}
