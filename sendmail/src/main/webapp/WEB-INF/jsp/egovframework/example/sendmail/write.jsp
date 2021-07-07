<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 윗 부분 넣어줘야 한글 안깨짐 --> 

<%@ include file ="../sendmail/layout/header.jsp" %> 


 <script type="text/javaScript" language="javascript" defer="defer">
	    function send(){
		   	if( $("#receiverAddress").val()==''){
	    		alert("받는 사람을 입력해주세요.");
            	$("#receiver").focus();
            	return;
	    	}
		   	if( $("#title").val()==''){
	    		alert("제목을 입력해주세요.");
            	$("#title").focus();
            	return;
	    	}
		   	if( $("#contents").val()==''){
	    		alert("내용을 입력해주세요.");
            	$("#contents").focus();
            	return;
	    	}
       	if (!confirm("이메일을 보내시겠습니까?")){
           	return;
           	}
 	    	//document.boardRegForm.action = "<c:url value='write_action.do'/>";
	    	document.boardRegForm.submit();
	    	}
	</script>

<title>메일쓰기</title>

<body id="page-top">

  <!-- Page Wrapper -->
  <div id="wrapper">
  
  	<%@ include file ="../sendmail/layout/sidebar.jsp" %>

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">

        <!-- Topbar -->
        <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

          <!-- Topbar Navbar -->
          <ul class="navbar-nav ml-auto"  >
            <div class="topbar-divider d-none d-sm-block "></div>           
              
          </ul>

        </nav>
        <!-- End of Topbar -->

          <!-- Begin Page Content -->
          <div class="container-fluid">
              <form class="form-horizontal" id="boardRegForm" name="boardRegForm" method="post" action="<c:url value='write.do'/>">
	              <div class="d-sm-flex align-items-center justify-content-between mb-4" >
	                  <h1 class="h3 mb-0 text-gray-800">메일쓰기</h1>
	              </div>
			  				<div>
									받는 사람 <input type="text" class="form-control" id="receiverAddress" name="receiverAddress" placeholder="받는 사람">
								</div> <br>
								<div>
									제목 <input type="text" class="form-control" id="title" name="title" placeholder="제목">
								</div> <br>
								<div>
									내용 <br>
									<textarea cols="30" rows="10" class="form-control" id="contents" name="contents" placeholder="내용"></textarea>					
			   				</div> <br>
								<!-- <input type="submit" id="" value="전송"></input> -->
								<button class="btn btn-primary btn-user btn-block" type="button" id="" onclick="send();">보내기</button>
							</form> <br>
						<button class="btn btn-primary btn-user btn-block" onclick="location.href='/sendmail/main.do'">메인으로</button>
          </div>

          <%@ include file ="../sendmail/layout/footer.jsp" %>

		    </div>
		    <!-- End of Content Wrapper -->
		
		  </div>
		  <!-- End of Page Wrapper -->
		  
  <!-- Bootstrap core JavaScript-->
  <script src="<%=request.getContextPath()%>/css/bootstrap/vendor/jquery/jquery.min.js"></script>
  <script src="<%=request.getContextPath()%>/css/bootstrap/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="<%=request.getContextPath()%>/css/bootstrap/vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="<%=request.getContextPath()%>/css/bootstrap/js/sb-admin-2.min.js"></script>

  <!-- Page level custom scripts -->
  <script src="<%=request.getContextPath()%>/css/bootstrap/js/demo/chart-area-demo.js"></script>
  <script src="<%=request.getContextPath()%>/css/bootstrap/js/demo/chart-pie-demo.js"></script>

</body>

</html>