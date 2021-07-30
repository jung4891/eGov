<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- jstl을 쓰기위해서 넣어줌 -->


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
	