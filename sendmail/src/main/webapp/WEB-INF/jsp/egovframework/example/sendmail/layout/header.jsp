
<!-- 
	text/html을 지우면 생기는 애러 : 다른 값들을 가지는 'contentType'이 여러 번 나타나는 것은 불허됩니다. (이전 값: [text/html; charset=utf-8], 신규 값: [charset=utf-8])]을(를) 발생시켰습니다
	 (+ "text/html;charset=utf-8" 요렇게 붙여쓰면 애러가 -> 신규 값: [text/html;charset=utf-8]~ 로 난다.)
	 (+ charset=utf-8을 지우면 애러가 -> 신규 값: [text/html]~~ 로 난다.)
	그냥 아얘 아래 JSP태그를 지우면 '로그아웃 하시겠습니까?'라는 알림창 한글이 깨진다. 즉, 아래 태그는 jsp에서 이벤트창으로 아래 logout()과 같은 함수 호출시 UTF-8을 적용시키는 것 같다.
	pageEncoding="utf-8" 지워도 우선 애러는 안나서 일단 지움. 
	--> 
<%@ page contentType="text/html; charset=utf-8" %>   

<!-- jstl을 쓰기위해서 넣어준다. 아래 설정 주석시 뭔가 웹페이지 모양이 이상해진다. 적용이 된다는 것. 
          하지만  taglib의 경우 웹페이지 f12의 Elements에서 보이진 않는다.  -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="en"> 

<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <!-- Custom fonts for this template--> 
  <!-- href="<c:url value='/css/bootstrap/vendor/fontawesome-free/css/all.min.css'/>" 이렇게도 된다. 기본이 webapp에서 출발 -->
  <link href="<%=request.getContextPath()%>/css/bootstrap/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link
      href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
      rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="<%=request.getContextPath()%>/css/bootstrap/css/sb-admin-2.min.css" rel="stylesheet">
	<script src="<c:url value='/js/jquery-3.5.1.min.js'/>"></script>  
	
	<script type="text/javascript" defer="defer" >
	 
	function logout() {
		if( !confirm("로그아웃 하시겠습니까?") ){
			return;				
		}
		location.href = "<c:url value='/logout.do'/>";
	}
	
	// 전체 체크 구현
	function selectAll(This)  {
		
			// 상단 체크박스 체크되어 있을때만 삭제버튼 활성화 시킴
			if (This.checked) {				
				$("#delBtn, #delBtn2").attr("disabled", false);  // 활성화	
			} else {
				$("#delBtn, #delBtn2").attr("disabled", true);   // 비활성화							
			}
			// document.getElementById('delBtn').setAttribute("disabled", false);	자바스크립트로는 왜 안되지??
			
			// 상단 체크박스에 따라서 아래 체크박스들 전체 컨트롤 됨
		  const checkboxes = document.getElementsByName('select_each');	// 메일 체크박스들
		  checkboxes.forEach((checkbox) => { 
			    checkbox.checked = This.checked;
		  }); 
	}

	// 모든 메일 체크박스 체크시 상단체크박스 체크되게함
	function selectEach()  {
		  const checkAll = document.getElementById('select_all');	// 전체 체크해주는 상단체크박스
		  const checkboxes = document.getElementsByName('select_each');	// 메일 체크박스들
		  
		  let cntChecked = 0;									// 체크된 메일수
		  checkboxes.forEach((checkbox) => {
			    if(checkbox.checked) {
			    	cntChecked = cntChecked + 1;
			    };
		  });
		  
		  // 모든 메일의 체크박스 갯수가 체크된 체크박스의 수가 같으면, 즉 모든 체크박스 선택시 상단 체크박스 체크됨.
		  if (cntChecked == checkboxes.length) {
				checkAll.checked = true;
		  } else {
			  checkAll.checked = false;
		  }
			
		  // 하나 이상의 메일의 체크박스가 체크되어 있다면 삭제버튼 활성화 시킴 
		  if (cntChecked >= 1) {
			  $("#delBtn, #delBtn2").attr("disabled", false); 
		  } else {
			  $("#delBtn, #delBtn2").attr("disabled", true); 
		  }
	}

	// 선택한 메일들 임시삭제 구현(VO의 checkedIdxs로 들어감)
	function deleteTmp() {
			// confirm("a");
			
	    var checkedIdxs = [];    							 // 배열 초기화
	    $("input[name='select_each']:checked").each(function() {
	    	checkedIdxs.push($(this).val());     // 체크된 것만 값을 뽑아서 배열에 push
	    });
	    
	    document.location.href="<c:url value='/deleteTmp.do?checkedIdxs='/>" + checkedIdxs;		// document빼도 잘 작동함
	 		// http://localhost/sendmail/deleteTmp.do?checkedIdxs=20,21
	 				
	 		
	    // 배열로 전달함
	/*     $.ajax({
	        url: 'deleteTmp2.do'
	        , type: 'post'
	        , dataType: 'text'				// dataType과 data는 넘겨주는 값이 있는 경우에만 작성하면 됨.
	        , data: {
	        	valueArr: checkArr
	        }
	    }); 
	*/
	}
	
	// 휴지통에서 완전삭제
	function deleteMail() {
			
	    var checkedIdxs = [];    							 
	    $("input[name='select_each']:checked").each(function() {
	    	checkedIdxs.push($(this).val());     
	    });
	    
	    document.location.href="<c:url value='/delete.do?checkedIdxs='/>" + checkedIdxs;		
	}
	
	// 휴지통에서 메일함으로 복원
	function restoreMail() {
			
	    var checkedIdxs = [];    							 
	    $("input[name='select_each']:checked").each(function() {
	    	checkedIdxs.push($(this).val());     
	    });
	    
	    document.location.href="<c:url value='/restore.do?checkedIdxs='/>" + checkedIdxs;		
	}

	</script>
</head>
	