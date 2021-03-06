<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 윗 부분 넣어줘야 한글 안깨짐 --> 
<%@ include file ="../../sendmail/layout/header.jsp" %>

<title>전체메일함</title>
<!-- Custom styles for this page -->
<link href="<%=request.getContextPath()%>/css/bootstrap/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">


<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

			<!-- 사이드바-->
			<%@ include file ="../../sendmail/layout/sidebar.jsp" %>

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

          <!-- Main Content -->
          <div id="content">
          
	          <!-- Topbar -->
			      <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
			
			      </nav>
			      <!-- End of Topbar -->

              <!-- Begin Page Content -->
              <div class="container-fluid">

                <!-- DataTales Example -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">전체 메일함</h6>
                    </div>
                    <div class="card-body">
                      <div class="table-responsive">
                        <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                          <thead>
                            <tr>
                              <th><input type="checkbox" id="select_all" onclick="selectAll(this)"></th>
                              <th>제목</th>
                              <th>보낸이</th>
                              <th>받는이</th>
                              <th>일자</th>
                            </tr>
                          </thead>
                          <tbody>
														<c:forEach var="result" items="${resultList}" varStatus="status">
															<tr>
																<td><input type="checkbox" name="select_each" onclick="selectEach()" value="${result.idx}"/></td>
																<td><a href="<c:url value='/detailPage.do?idx=${result.idx}'/>"><c:out value="${result.title}"/></a></td>
																<td><c:out value="${result.sender}"/></td>
																<td><c:out value="${result.receiver}"/></td>
																<td><c:out value="${result.indate}"/></td>
															</tr>
														</c:forEach>                          
                          </tbody>
                        </table>
                      </div>
                         <button class="btn btn-primary" id="delBtn" disabled="disabled" onclick="deleteTmp();" style="margin: 0px 5px; 
                      				background-color: #96a8ba; border-color: white; font-weight: bold; font-size: small;">
                      				선택삭제</button>		
                    </div>
                </div>
            </div>
            <!-- /.container-fluid -->
          </div>
          <!-- End of Main Content -->

						<%@ include file ="../../sendmail/layout/footer.jsp" %>

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>


    <!-- Bootstrap core JavaScript-->
    <script src="<%=request.getContextPath()%>/css/bootstrap/vendor/jquery/jquery.min.js"></script>
    <script src="<%=request.getContextPath()%>/css/bootstrap/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="<%=request.getContextPath()%>/css/bootstrap/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="<%=request.getContextPath()%>/css/bootstrap/js/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->
    <script src="<%=request.getContextPath()%>/css/bootstrap/vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="<%=request.getContextPath()%>/css/bootstrap/vendor/datatables/dataTables.bootstrap4.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="<%=request.getContextPath()%>/css/bootstrap/js/demo/datatables-demo.js"></script>

</body>

</html>