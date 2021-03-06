<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 윗 부분 넣어줘야 한글 안깨짐 --> 

<%@ include file ="../../sendmail/layout/header.jsp" %> 
	    

<title>메일 상세화면</title>

<body id="page-top">

  <!-- Page Wrapper -->
  <div id="wrapper">
  
  	<%@ include file ="../../sendmail/layout/sidebar.jsp" %>

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
              <form class="form-horizontal" id="boardRegForm" name="boardRegForm">
	              <div class="d-sm-flex align-items-center justify-content-between mb-4" >
	                  <h1 class="h3 mb-0 text-gray-800">메일 상세화면</h1>
	              </div>
	              <div>
									보낸 사람 <input type="text" class="form-control" id="senderAddress" name="senderAddress" value="${sender }" readonly="readonly" >
								</div> <br>
			  				<div>
									받는 사람 <input type="text" class="form-control" id="receiverAddress" name="receiverAddress" value="${receiver }" readonly="readonly">
								</div> <br>
								<div>
									제목 <input type="text" class="form-control" id="title" name="title" value="${title }" readonly="readonly">
								</div> <br>
								<div>
									내용 <br>
									<div id="contents" style="display: none;">${contents } </div>
							  	<%-- <textarea rows="7" cols="70" class="form-control" id="contents" readonly="readonly">${contents }</textarea>  --%>
							  	<div id="editable" class="form-control" style="height: 200px; overflow-y: auto; background-color: #eaecf4" ></div>
			   				</div> <br>
							</form> <br>
						<button class="btn btn-primary btn-user btn-block" onclick="location.href='/sendmail/main.do'">메인으로</button>
          </div>

          <%@ include file ="../../sendmail/layout/footer.jsp" %>

		    </div> 
		    <!-- End of Content Wrapper -->
		
		  </div> 
		  <!-- End of Page Wrapper -->
		  
	</body>
	
	<script>
	
		// textarea 내부에선 <b>와 같은 HTML Tag가 적용이 되지 않는다. 이때 <div>태그를 사용해 꼼수로 적용을 시킬 수 있다.
		// contenteditable 이라는 값을 이용하면 다른 태그에도 편집 기능을 추가할 수 있다. (<div class="editable" contenteditable="true"></div> )
		$("#editable").html($("#contents").text());
		// alert($("#contents").text());			// &lt;p&gt;&lt;strong&gt;과아연~~~&lt;/strong&gt;&lt;/p&gt;  요렇게 되어야 html로 볼 수 있다.

	</script>
	
	  
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
  

</html>