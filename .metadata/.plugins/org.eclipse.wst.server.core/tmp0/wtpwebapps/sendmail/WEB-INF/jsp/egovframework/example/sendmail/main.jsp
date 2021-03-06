<%@ page contentType="text/html; charset=utf-8" %>
<!-- charset=utf-8를 지우면 백색창이 뜬다. 그러다가 다시 잘 띄어지기도 한다.  -->
<!-- pageEncoding="utf-8" 지워도 우선 애러는 안나서 일단 지움. -->
<!-- 윗 부분 넣어줘야 한글 안깨짐. 설정 안할시 '메인페이지' -> 'ë©ì¸íì´ì§'이렇게 뜸  --> 

<%@ include file ="../sendmail/layout/header.jsp" %> 

<title>두리안 메일서버 메인</title>		<!-- 이 위치에 있긴하지만 <head>로 자동 들어감 -->

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

          <!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
          
            <h1 class="h3 mb-0 text-gray-800">메인페이지</h1> 
            
          </div> 
          
        </div>
        <!-- /.container-fluid -->

      </div>
      <!-- End of Main Content -->

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

  <!-- Page level plugins -->
  <script src="<%=request.getContextPath()%>/css/bootstrap/vendor/chart.js/Chart.min.js"></script>

<%--   <!-- Page level custom scripts -->
  <script src="<%=request.getContextPath()%>/css/bootstrap/js/demo/chart-area-demo.js"></script>
  <script src="<%=request.getContextPath()%>/css/bootstrap/js/demo/chart-pie-demo.js"></script> --%>

</body>

</html>
