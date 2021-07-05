package egovframework.example.board.web;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.example.board.service.BoardService;
import egovframework.example.board.service.BoardVO;
import egovframework.rte.fdl.property.EgovPropertyService;

// @Controller 어노테이션을 써줘야 스프링 프레임웍에서  이 클래스가 컨트롤러 라는걸 인식하게 된다.
@Controller 
public class BoardController {
	 
	/** BoardService */
	@Resource(name = "boardService")
	private BoardService boardService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	// PropertyService는 resources > spring의 여러 .xml파일들의 값들을 가지고 올 수 있게 한다.
	
	@RequestMapping(value = "/list.do")
	public String list(@ModelAttribute("boardVO") BoardVO boardVO, 
						ModelMap model) throws Exception {
		
		/** EgovPropertyService.sample */
//		boardVO.setPageUnit(propertiesService.getInt("pageUnit"));
//		boardVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
//		PaginationInfo paginationInfo = new PaginationInfo();
//		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
//		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
//		paginationInfo.setPageSize(boardVO.getPageSize());
//
//		boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
//		boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
//		boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<?> list = boardService.selectBoardList(boardVO);
		model.addAttribute("resultList", list);
		// #ModelAttribute는 클라이언트에서 서버로 전달하는것. model은 반대로 전달하는 것.
 
		int totCnt = boardService.selectBoardListTotCnt(boardVO);
//		paginationInfo.setTotalRecordCount(totCnt);
//		model.addAttribute("paginationInfo", paginationInfo);
		
		System.out.println("board의 list 호출");
		return "board/list"; 
	}
	
	// 등록화면 호출
	@RequestMapping(value = "/mgmt.do", method = RequestMethod.GET)
	public String mgmt(ModelMap model, HttpServletRequest request) throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Calendar c = Calendar.getInstance();
		String strToday = sdf.format(c.getTime());
		
		BoardVO boardVO = new BoardVO();
		boardVO.setWriter(request.getSession().getAttribute("userId").toString());
		boardVO.setWriterNm(request.getSession().getAttribute("userName").toString());
		boardVO.setIndate(strToday);
		
		model.addAttribute("boardVO", boardVO);
		return "board/mgmt";
	}
	
	// 등록 처리
	@RequestMapping(value = "/mgmt.do", method = RequestMethod.POST)
	public String mgmtAct(@ModelAttribute("boardVO") BoardVO boardVO, ModelMap model) throws Exception {
		boardService.insertBoard(boardVO);
		return "redirect:/list.do";
	}

	@RequestMapping(value = "/view.do")
	public String view(@ModelAttribute("boardVO") BoardVO boardVO, ModelMap model) throws Exception {
		boardVO =  boardService.selectBoard(boardVO);
		model.addAttribute("boardVO", boardVO);
		return "board/view";
	}
	
	// http://localhost:8787/login.do?user_id=admin&password=manager
	@RequestMapping(value = "/login.do")
	public String login(@RequestParam("user_id") String user_id,
			          	@RequestParam("password") String password, 
			          	HttpServletRequest request,
			          	RedirectAttributes r, ModelMap model) throws Exception {
		// String id = request.getParameter("user_id");
		// @RequestParam과 위는 같다. 스프링 프레임웍은 @RequestParam를 주로 쓴다.
//		System.out.println("user_id:" + user_id);
//		System.out.println("password:" + password);
		
		BoardVO boardVO = new BoardVO();
		boardVO.setUserId(user_id);
		boardVO.setPassword(password);
		String user_name = boardService.selectLoginCheck(boardVO);
//		System.out.println("user_name:" + user_name);
		
		if( user_name != null && !"".equals(user_name)) {
			request.getSession().setAttribute("userId", user_id);
			request.getSession().setAttribute("userName", user_name);  // Board_SQL에서 name 가져오게끔 설정.
		}else {
			request.getSession().setAttribute("userId", "");
			request.getSession().setAttribute("userName", "");
			r.addFlashAttribute("msg", "사용자 정보가 올바르지 않습니다.");
//			model.addAttribute("msg", "사용자 정보가 올바르지 않습니다.");
			// redirect로 보낼시 model을 쓰면 redirect후 호출되는  jsp에서  msg가 인식이 안됨. 이때는 RedirectAttributes를 써야함
		}
//		return "board/list";		
		// 비번 틀릴시 : msg 이벤트창이 정상 동작함.
		// 정상 로그인후 게시판 : 컨트롤러에서 list.do가 실행이 안되었으니 게시물들이 업로드 안되어있음. 
		return "redirect:/list.do";
	}
	
	@RequestMapping(value = "/logout.do")
	public String logout(ModelMap model, HttpServletRequest request) throws Exception {
		request.getSession().invalidate();
//		return "board/list";
		return "redirect:/list.do";
	}
	
}
