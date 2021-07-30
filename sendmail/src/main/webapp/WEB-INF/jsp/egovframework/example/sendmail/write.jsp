<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 윗 부분 넣어줘야 한글 안깨짐 --> 

<%@ include file ="../sendmail/layout/header.jsp" %> 

<!-- 글쓰기 에디터 적용 (ckeditor5 Classic) -->
<script src="https://cdn.ckeditor.com/ckeditor5/29.0.0/classic/ckeditor.js"></script>
<!-- 아래는 Document 버전으로 플러그인이 더 괜찮은거 같은데 textarea가 아닌 p태그 안에서만 적용이 되서 일단 보류..(form으로 묶어서 post보내야 되는데 p태그는 그게 안됨) -->
<!-- <script src="https://cdn.ckeditor.com/ckeditor5/29.0.0/decoupled-document/ckeditor.js"></script> -->

 <script type="text/javaScript" language="javascript" defer="defer">
	    function send(){
	    	console.log($(".test").text);
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
		   	if( $(".ck-content").attr("value") ==''){ 		// 에디터 적용된 div의 내용을 가져옴
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
									보내는 사람 <input type="text" class="form-control" id="senderAddress" name="senderAddress" value="${senderAddress }" readonly="readonly" >
								</div> <br>
								<div class="test" type="text">
									testtt
								</div>
			  				<div>
									받는 사람 <input type="text" class="form-control" id="receiverAddress" name="receiverAddress" placeholder="받는 사람">
								</div> <br>
								<div>
									제목 <input type="text" class="form-control" id="title" name="title" placeholder="제목">
								</div> <br>
								<div>
									내용 <br>
							  	<div id="editor"> 
   								</div>
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
		  
	</body>
		  
  <!-- Bootstrap core JavaScript-->
  <script src="<%=request.getContextPath()%>/css/bootstrap/vendor/jquery/jquery.min.js"></script>
  <script src="<%=request.getContextPath()%>/css/bootstrap/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="<%=request.getContextPath()%>/css/bootstrap/vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="<%=request.getContextPath()%>/css/bootstrap/js/sb-admin-2.min.js"></script>

  <!-- Page level custom scripts -->
<%--   <script src="<%=request.getContextPath()%>/css/bootstrap/js/demo/chart-area-demo.js"></script>
  <script src="<%=request.getContextPath()%>/css/bootstrap/js/demo/chart-pie-demo.js"></script> --%>
  
  <!-- 글쓰기 에디터 자바스크립트 파일 호출(ID가 editor인 textarea에 적용되는 파일임.) 
  		  근데 이게 적용되면 아래처럼 display: none으로 속성값이 자동으로 들어가고 아래부분에 웹에디터 관련 태그들이 생성됨 
  		 <div id="editor" style="display: none;"> 
        	<p>This is some sample content.</p>
   		 </div>
   		 <div class="ck ck-reset ck-editor ck-rounded-corners" role="application" ~~~  
  		 <div class="ck ck-editor__main" role="presentation"><div class="ck ck-content ~~> 이부분이 내용부분임.  -->       
  <script src="<%=request.getContextPath()%>/js/ckeditor.js"></script>

	<!-- textarea 높이 조절. 아래 클래스는 ckeditor에서 사용하는 클래스임  -->
	<style>
			.ck-content {
			    min-height: 200px;
			}
	</style> 



</html>