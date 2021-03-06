package egovframework.example.sendmail.web;

import java.io.PrintWriter;
import java.net.InetAddress;
import java.net.URLEncoder;
import java.net.UnknownHostException;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.annotation.Resource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringEscapeUtils;
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

@Controller  
public class MailController { 
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	// PropertyService는 resources > spring의 여러 .xml파일들의 값들을 가지고 올 수 있게 한다. 
	// (근데 언제 쓰이지?)
	
	/** MailService */
	@Resource(name = "mailService")
	private MailService mailService;
	
	@RequestMapping(value = "/main.do")
	public String main() throws Exception {
		return "sendmail/main"; 
	}
	
	@RequestMapping(value = "/loginPage.do")
	public String loginPage() throws Exception {
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
		return "sendmail/mailbox/wholebox";        
	}
	
	@RequestMapping(value = "/inbox.do")
	public String inbox(@ModelAttribute("mailVO") MailVO mailVO, 	
							ModelMap model) throws Exception {
		System.out.println("inbox()");
		List<?> list = mailService.selectInboxList(mailVO);		// mailVO의 userName으로 파라미터 전달됨
		model.addAttribute("resultList", list);
		return "sendmail/mailbox/inbox";        
	}
	
	@RequestMapping(value = "/outbox.do")
	public String outbox(@ModelAttribute("mailVO") MailVO mailVO, 
							ModelMap model) throws Exception {
		List<?> list = mailService.selectOutboxList(mailVO);
		model.addAttribute("resultList", list);
		return "sendmail/mailbox/outbox";        
	}
	
	@RequestMapping(value = "/detailPage.do")
	public String detailPage(@ModelAttribute("mailVO") MailVO vo, ModelMap model) throws Exception {
		MailVO mailVO = mailService.selectMail(vo);
		model.addAttribute("title", mailVO.getTitle());
		model.addAttribute("sender", mailVO.getSender());
		model.addAttribute("receiver", mailVO.getReceiver());
		model.addAttribute("indate", mailVO.getIndate());
		
    	String toHtmlTag = StringEscapeUtils.escapeHtml4(mailVO.getContents());	// < -> &lt   (tb_mail의 내용의 <p>과아연~~~<p> -> &lt;p&gt;과아연~~~&lt;/p&gt;)
    																			//            (요렇게 해야 메일상세화면에서 html태그가 적용되게끔 볼수 있다)
		model.addAttribute("contents", toHtmlTag);
		return "sendmail/mailbox/detail";        
	}
	
	@RequestMapping(value = "/deletePage.do")
	public String deletePage(@ModelAttribute("mailVO") MailVO mailVO, 
							 ModelMap model) throws Exception {
		List<?> list = mailService.selectDeleteList(mailVO);
		model.addAttribute("resultList", list);
		return "sendmail/mailbox/delete";        
	}
	
	// 메일 우측에 삭제 a태그 넣어 클릭시 휴지통으로 임시 삭제
/*	@RequestMapping(value = "/deleteTmp.do")
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
	}*/

	
	// VO의 checkedIdxs 값 받아와 휴지통으로 메일 임시 삭제
	// , method = RequestMethod.POST  // 이놈을 붙이면 무조건 post로만 요청을 보내야한다. 
									  // 근데 post방식으로 받으면 아니 RequestMethod~~ 를 뒤에 붙이게 되면 redirect가 제대로 작동을 안한다. 
									  // select로 조회는 되는데 변경된 페이지가 로드가 안된다.... 
	@RequestMapping(value = "/deleteTmp.do")
	public String deleteTmp(
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
	
	// 휴지통에서 복원하기
	@RequestMapping(value = "/restore.do")
	public String restore(
			HttpServletRequest request,
			@ModelAttribute("mailVO") MailVO mailVO) throws Exception { 
		mailService.restoreMail(mailVO);
		String referer = request.getHeader("Referer");
	    return "redirect:"+ referer;
	}
	
	@RequestMapping(value = "/writePage.do")
	public String writePage(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
/*		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script>alert('왜 안뜸???'); </script>");
		out.flush();*/
		String userId = request.getSession().getAttribute("userId").toString();
		String senderAddr = userId + "@durianict.co.kr";
		model.addAttribute("senderAddress", senderAddr);
		return "sendmail/write";       
	}
	
	// 그룹발송 버튼 클릭시 그룹명들 불러오는 역할
	// produces="text/html; charset=UTF-8" -> return시 한글 깨지지 않게함.
	@ResponseBody 
	@RequestMapping(value = "/selectGroups.do", produces="text/html; charset=UTF-8", method = RequestMethod.GET)
	public String selectGroups() throws Exception {
		String[] groupArr = mailService.selectGroups();		// [개발부, 인사부]
		String optionTag = "<select id='test' onchange='selectGroup()'>"
							+ "<option selected disabled>선택</option>"
							+ "<option>전체</option>";
		for(String group : groupArr) {
			optionTag += "<option>" + group + "</option>";
		}
		optionTag += "</select>";
		return optionTag;
	}
	
	// 그룹 선택창에서 그룹 선택시 해당 그룹에 있는 모든 이메일들이 받는 사람에 기입되도록함.
	@ResponseBody 
	@RequestMapping(value = "/selectEmails.do", produces="text/html; charset=UTF-8", method = RequestMethod.POST)
	public String selectEmails(@RequestParam("groupName") String groupName) throws Exception {
		
		String[] groupArr;
		if (groupName.equals("전체")) {
			groupArr = mailService.selectAllEmails();	
		} else {			
			groupArr = mailService.selectEmails(groupName);	
		}
		String groupStr = Arrays.toString(groupArr);				// [go_go_ssing@naver.com, hap-happy@nate.com]
		groupStr = groupStr.substring(1, groupStr.length()-1);		// 앞과 뒤에 있는 대괄호 삭제하고 이메일,이메일 식으로 문자열 자름
		return groupStr;
	}
	
	// 현재 ajax로 사용해서 return이 안되고 스크립트 alert도 안되는 문제가 생김. 해결중...
	@RequestMapping(value = "/write.do", method = RequestMethod.POST)
	public String write(HttpServletRequest request, HttpServletResponse response,
						@RequestParam("receiverAddress") String receiverAddress,
			          	@RequestParam("title") String title, 
			          	@RequestParam("contents") String contents, 
						ModelMap model) throws Exception {
		String userId = request.getSession().getAttribute("userId").toString();
		String senderAddress = userId + "@test.com";				// @durianict.co.kr로 하면 네이버, 네이트로 service unavailable뜨면서 안되고
																	// @test.com 으로 하면 지메일로만 안가짐. 내 자체 웹메일로는 둘다 가짐
		String userName = request.getSession().getAttribute("userName").toString();
		
		MailVO mailVO = new MailVO();
		mailVO.setTitle(title);
		
    	String toHtmlTag = StringEscapeUtils.unescapeHtml4(contents);	// &lt -> <   (tb_mail의 내용에 &lt;p&gt;과아연~~~&lt;/p&gt; 요렇게 들어가지 않게끔)
		mailVO.setContents(toHtmlTag);
		mailVO.setSender(userName);
		mailVO.setReceiver(receiverAddress);
	    connectSMTP();
	    createMail(senderAddress, receiverAddress, title, contents);
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
	    if (sendMail()) {
	    	mailService.insertMail(mailVO);							// 전송성공한 메일은 메일함으로 이동
			out.println("<script>alert('메일 발송 성공!'); </script>");
			out.flush();											// flush 안해주면 위 이벤트창 작동 안함
			return "sendmail/main";  								// redirect 불가능. -> (Error) 응답이 이미 커밋된 후에는, sendRedirect()를 호출할 수 없습니다.
	    } else {
	    	out.println("<script>alert('메일 발송 실패..'); </script>");
			out.flush();
	    	return "sendmail/main";
	    }
	}
	
	
	// 메일쓰기
	public static Message message = null;
	final static String port = "25";
//	public static JavaMailSender  mailSender;
	
	public static void connectSMTP() throws UnknownHostException {
		
	    InetAddress inetAddress = InetAddress.getLocalHost();
	    String hostName = inetAddress.getHostName();
	    String hostAddress = inetAddress.getHostAddress();
	    System.out.println("hostName: " + hostName);			// DESKTOP-L1EANON
	    System.out.println("hostAddress: " + hostAddress);		// 218.152.63.87
	    Properties prop = new Properties();
	    
	    
	    //사내 메일 망일 경우 smtp host 만 설정해도 됨 (특정 포트가 아닐경우)	// "183.96.110.159"
	    prop.put("mail.smtp.host", hostAddress);  		// host는 SMTP서버 ip이다. 이 ip주소는 NAT일 경우 내 localhost이고 어댑터에 브릿지일경우는 해당 리눅스 ip주소다.
	    prop.put("mail.smtp.port", port);				// RELAY(중계허용)은 NAT인경우 리눅스 게이트웨이를 어댑터브릿지인경우 내 localhost를 RELAY하면 된다.
	    prop.put("mail.smtp.starttls.enable","true");	// 그 이유는 NAT는 중간에 문이 하나 있지만 어댑터 브릿지는 해당 리눅스ip로 바로 접근가능하니까!
//	    prop.put("mail.smtp.auth", "true");	    		// 요거 쓰는것도 한번 연습해봐야 할듯.
//	    prop.put("mail.smtp.ssl.enable", "true");		 
//	    prop.put("mail.smtp.ssl.trust", host);			    	    												   

	    Session session = Session.getDefaultInstance(prop, null);
	    try{
	     message = new MimeMessage(session);
	    } catch (Exception e) {
	     e.printStackTrace();
	    }
	}
	
	public static void createMail(String senderAddress, String receiverAddress, String title, String contents){
	   
	    // MimeBodyPart mbp = new MimeBodyPart();   // 안써서 주석처리

	    try{

	    	String[] receiverAddrs = receiverAddress.split(",");	    	
	    	InternetAddress[] receive_address = new InternetAddress[receiverAddrs.length];
	    	
	    	for (int i=0; i<receiverAddrs.length; i++) {						// 다중유저의 메일을 주소배열에 넣음
	    		receive_address[i] = new InternetAddress(receiverAddrs[i]);
	    	}
		    // receive_address = {new InternetAddress(receiverAddress)};		// 받는 사람 메일주소(1명)
		    message.setRecipients(RecipientType.TO, receive_address);		// 받는 메일 주소들   
		    message.setFrom(new InternetAddress(senderAddress));			// 보내는 메일 주소
		    message.setSubject(title);										// 메일 제목 		    		   
		    message.setSentDate(new Date());								// 보내는 날짜
		    
	    	String toHtmlTag = StringEscapeUtils.unescapeHtml4(contents);	// &lt -> <
		    message.setContent(toHtmlTag, "text/html; charset=utf-8"); 		// 메일 내용, charset 안넣으면 ????로 내용 전달됨.
/* 	
	    	# 내용이 html형식인 경우 적용해서 보내기. 
		     html태그를 String으로 변환하여 자바 서블릿으로 보내게 되면 이상한 문자로 치환된다. 
		      (contents: &lt;p&gt;&lt;strong&gt;Hello World&lt;/strong&gt;&lt;/p&gt;)
		  	  이때 replace를 써서 각각 html태그로 변환해줘도 되지만 아파치에서 제공하는 StringEscapeUtils 클래스를 사용하면 보다 쉽게 html태그로 치환이 가능하다. 
		  	  (import org.apache.commons.lang3.StringEscapeUtils;)
	    	  (toHtmlTag:<p><strong>Hello World</strong></p>)
*/	    		    		    	
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
