package egovframework.example.sendmail.web;

import java.io.PrintWriter;
import java.net.InetAddress;
import java.net.URLEncoder;
import java.net.UnknownHostException;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.annotation.Resource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.example.sendmail.service.MailService;
import egovframework.example.sendmail.service.MailVO;
import egovframework.rte.fdl.property.EgovPropertyService;

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
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	// PropertyService는 resources > spring의 여러 .xml파일들의 값들을 가지고 올 수 있게 한다.
	
	@RequestMapping(value = "/main.do")
	public String main(ModelMap model) throws Exception {
//		System.out.println("sendmail의 main 호출");
		return "sendmail/main"; 
	}
	
	@RequestMapping(value = "/loginPage.do")
	public String loginPage(ModelMap model) throws Exception {
//		System.out.println("sendmail의 login 호출");  
	    InetAddress inetAddress = InetAddress.getLocalHost();
	    String hostName = inetAddress.getHostName();
	    String host = inetAddress.getHostAddress();
	    System.out.println("hostAddress: " + host);
	    System.out.println("hostName: " + hostName);
		return "sendmail/login";        
	}

	@RequestMapping(value = "/login.do")
	public String login(@RequestParam("user_id") String user_id,
			          	@RequestParam("password") String password, 
			          	HttpServletRequest request,
			          	RedirectAttributes r, ModelMap model) throws Exception {
		
		System.out.println("컨트롤러 /login.do");
		MailVO mailVO = new MailVO();
		mailVO.setUserId(user_id);		// guest
		mailVO.setPassword(password);	// 1234
		
		String user_name = mailService.selectLoginCheck(mailVO);
//		System.out.println("user_name:" + user_name);
		
		if ( user_name != null && !"".equals(user_name)) {
			request.getSession().setAttribute("userId", user_id);
			request.getSession().setAttribute("userName", user_name);  // Mail_SQL에서 name 가져오게끔 설정.
			user_name = URLEncoder.encode(user_name, "UTF-8");	// ★ 한글을 파라미터로 보낼시 ??? 인코딩 애러처리
			
			return "sendmail/main";
//			 return "redirect:/inbox.do?userName=" + user_name;  // 로그인한 사용자의 수신함을 출력하기 위해서 파라미터 사용.
			// 이때 MailVO에서 userName을 변수로 선언하고 getter와 setter를 만들어줘야 정상작동한다. 파라미터로 가는데도 VO가 필요한듯?
		} else {
			request.getSession().setAttribute("userId", "");
			request.getSession().setAttribute("userName", "");
			model.addAttribute("msg", "사용자 정보가 올바르지 않습니다.");
//			r.addFlashAttribute("msg", "사용자 정보가 올바르지 않습니다.");
			System.out.println("여기는 오나??");
			return "sendmail/login";
		}
	}
	
	@RequestMapping(value = "/logout.do")
	public String logout(ModelMap model, HttpServletRequest request) throws Exception {
		request.getSession().invalidate();
//		return "board/list";
		return "redirect:/loginPage.do";
	}
	
	@RequestMapping(value = "/wholebox.do")
	public String wholebox(@ModelAttribute("mailVO") MailVO mailVO, 
							ModelMap model) throws Exception {
		List<?> list = mailService.selectMailList(mailVO);
		// System.out.println("전체메일함 조회시 가져오는 list: " + list);
		model.addAttribute("resultList", list);
		return "sendmail/wholebox";        
	}
	
	@RequestMapping(value = "/inbox.do")
	public String inbox(@ModelAttribute("mailVO") MailVO mailVO, 	
							ModelMap model) throws Exception {
		System.out.println("inbox()");
		List<?> list = mailService.selectInboxList(mailVO);		// mailVO는 여기서 안쓰임 userName으로 조회됨
		model.addAttribute("resultList", list);
		return "sendmail/inbox";        
	}
	
	@RequestMapping(value = "/outbox.do")
	public String outbox(@ModelAttribute("mailVO") MailVO mailVO, 
							ModelMap model) throws Exception {
		List<?> list = mailService.selectOutboxList(mailVO);
		model.addAttribute("resultList", list);
		return "sendmail/outbox";        
	}
	
	@RequestMapping(value = "/deletePage.do")
	public String deletePage(@ModelAttribute("mailVO") MailVO mailVO, 
							 ModelMap model) throws Exception {
		List<?> list = mailService.selectDeleteList(mailVO);
		model.addAttribute("resultList", list);
		return "sendmail/delete";        
	}
	
	// 메일 우측에 삭제 a태그 넣어 클릭시 휴지통으로 임시 삭제
	@RequestMapping(value = "/deleteTmp.do")
	public String deleteTmp(
			HttpServletRequest request,
            RedirectAttributes redirectAttributes,
			@ModelAttribute("mailVO") MailVO mailVO) throws Exception { 
			// 요청이 /deleteTmp.do?idx=5 이런식으로 들어오는데 이게 참 신기하게 따로 설정 안하고
		 	// 그냥 @MedelAttribute("mailVO")로 받아서 보내면 
			// 값이 VO에 들어가서 SQL에서 파라미터로 적용이 되는거 같다.
			// System.out.println("mailVO의 int값: " + mailVO.getIdx());
		mailService.deleteTmpMail(mailVO);
			
		// 이전 페이지에 추가적인 데이터를 보낼때 사용
	    // redirectAttributes.addFlashAttribute("okList", "AA BB CC");
	    
		// 이전페이지로 redirect하는건 request의 referer를 이용
		String referer = request.getHeader("Referer");
	    return "redirect:"+ referer;
	}

	// 체크박스 배열 받아와 휴지통으로 메일 임시 삭제
	// , method = RequestMethod.POST  // 이놈을 붙이면 무조건 post로만 요청을 보내야한다. 
									  // 근데 post방식으로 받으면 아니 RequestMethod~~ 를 뒤에 붙이게 되면 redirect가 제대로 작동을 안한다. 
									  // select로 조회는 되는데 변경된 페이지가 로드가 안된다.... 
	@RequestMapping(value = "/deleteTmp2.do")
	public String deleteTmp2(
			HttpServletRequest request,
            RedirectAttributes redirectAttributes,
            @ModelAttribute("mailVO") MailVO mailVO) throws Exception { 
		
		// 배열로 전달 받았을 경우
		// @RequestParam(value = "valueArr[]") List<String> valueArr   
		// System.out.println("List:" + valueArr);
		
		// VO로 전달 받았을 경우
		// "체크한숫자, 체크한숫자" 이런식으로 문자열에 담겨서 VO의 checkedIdxs로 문자열 값이 들어감.
		// System.out.println(mailVO.getCheckedIdxs());
		
		mailService.deleteTmpMail(mailVO);
	    
		String referer = request.getHeader("Referer");
		//System.out.println(referer); // http://localhost/sendmail/outbox.do?userName=%EC%86%A1%ED%98%81%EC%A4%91
		return "redirect:"+ referer;
	}
	
	// 휴지통에서 완전삭제하기
	@RequestMapping(value = "/delete.do")
	public String delete(
			HttpServletRequest request,
            RedirectAttributes redirectAttributes,
			@ModelAttribute("mailVO") MailVO mailVO) throws Exception { 
		mailService.deleteMail(mailVO);
		String referer = request.getHeader("Referer");
	    return "redirect:"+ referer;
	}
	
	@RequestMapping(value = "/writePage.do")
	public String writePage(HttpServletRequest request, ModelMap model) throws Exception {
		String userId = request.getSession().getAttribute("userId").toString();
		String senderAddr = userId + "@durianict.co.kr";
		model.addAttribute("senderAddress", senderAddr);
		return "sendmail/write";       
	}
	
	
	@RequestMapping(value = "/write.do")
	public String write(
						HttpServletRequest request, HttpServletResponse response,
						@RequestParam("receiverAddress") String receiverAddress,
			          	@RequestParam("title") String title, 
			          	@RequestParam("contents") String contents, 
						ModelMap model) throws Exception {
		String userId = request.getSession().getAttribute("userId").toString();
		String senderAddress = userId + "@durianict.co.kr";
		String userName = request.getSession().getAttribute("userName").toString();
		
		MailVO mailVO = new MailVO();
		mailVO.setTitle(title);
		mailVO.setContents(contents);
		mailVO.setSender(userName);
		mailVO.setReceiver(receiverAddress);
	    connectSMTP();
	    createMail(senderAddress, receiverAddress, title, contents);
	    
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
	    if (sendMail()) {
	    	mailService.insertMail(mailVO);
			out.println("<script>alert('메일 발송 성공!'); </script>");
			out.flush();
			return "sendmail/outbox";
	    } else {
	    	out.println("<script>alert('메일 발송 실패..'); </script>");
			out.flush();
	    	return "sendmail/outbox";
	    }
	    
	}
	
	
	// 메일쓰기
	final static String port = "25";
	
	public static void connectSMTP() throws UnknownHostException{
	    InetAddress inetAddress = InetAddress.getLocalHost();
	    String host = inetAddress.getHostAddress();
	    System.out.println("ipAddress: " + host);
	    Properties prop = new Properties();

	    //사내 메일 망일 경우 smtp host 만 설정해도 됨 (특정 포트가 아닐경우)
	    prop.put("mail.smtp.host", host);  	// host는 SMTP서버 ip이다. 이 ip주소는
	    prop.put("mail.smtp.port", port);				//   NAT일 경우 내 localhost이고
	    prop.put("mail.smtp.starttls.enable","true");	//   어댑터에 브릿지일경우는 해당 리눅스 ip주소다.
//	    prop.put("mail.smtp.auth", "true");	    		// 따라서 NAT인경우 리눅스 게이트웨이를 RELAY하고
//	    prop.put("mail.smtp.ssl.enable", "true");		// 어댑터브릿지인경우 내 localhost를 RELAY하면 된다.
//	    prop.put("mail.smtp.ssl.trust", host);			//   그 이유는 NAT는 중간에 문이 하나 있지만 
	    												//   어댑터 브릿지는 해당 리눅스ip로 바로 접근가능하니까

	    Session session = Session.getDefaultInstance(prop, null);
	    try{
	     message = new MimeMessage(session);
	    } catch (Exception e) {
	     e.printStackTrace();
	    }
	}
	
	public static Message message = null;
	
	public static void createMail(String senderAddress, String receiverAddress, String title, String contents){
	   
	    MimeBodyPart mbp = new MimeBodyPart();

	    try{
	    	
		     // 보내는 메일 주소
		     message.setFrom(new InternetAddress(senderAddress));
		     
		     // 받는 사람 메일주소
		     InternetAddress[] receive_address = {new InternetAddress(receiverAddress)};
		     message.setRecipients(RecipientType.TO, receive_address);

		     // 메일 제목 넣기
		     message.setSubject(title);
		     
		     // 메일 본문을 넣기
		     message.setContent(contents, "text/html;charset=utf-8"); // charset 안넣으면 ????로 내용 전달됨.

		     // 보내는 날짜
		     message.setSentDate(new Date());
		     
	   } catch (Exception e){
		    	e.printStackTrace();
	   }
	}
	
	
	public static boolean sendMail(){

	    try {
	     Transport.send(message);
	     System.out.println("메일전송 성공 !!");
	     return true;

	    } catch (MessagingException e) {
	     System.out.println("메일전송 실패 !!");
	     e.printStackTrace();
	     return false;
	    }
	}
	   
	
	   

	
	 
}
