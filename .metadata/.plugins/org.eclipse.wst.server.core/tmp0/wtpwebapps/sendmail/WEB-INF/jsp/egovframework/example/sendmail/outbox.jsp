<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 윗 부분 넣어줘야 한글 안깨짐 --> 
<%@ include file ="../sendmail/layout/header.jsp" %>

<title>보낸메일함</title>
<!-- Custom styles for this page -->
<link href="<%=request.getContextPath()%>/css/bootstrap/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">


<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

			<!-- 사이드바-->
			<%@ include file ="../sendmail/layout/sidebar.jsp" %>

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
                        <h6 class="m-0 font-weight-bold text-primary">보낸 메일함</h6>
                    </div>
                    <div class="card-body">
                      <div class="table-responsive">
                        <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                          <thead>
                            <tr>
                              <th>No</th>
                              <th>제목</th>
                              <th>받는이</th>
                              <th>일자</th>
                              <th></th>
                            </tr>
                          </thead>
                          <tbody>
                          
														<c:forEach var="result" items="${resultList}" varStatus="status">
															<tr>
																<td><a href="javascript:view();"><c:out value="${result.idx}"/></a></td>
																<td><a href="javascript:view();"><c:out value="${result.title}"/></a></td>
																<td><c:out value="${result.receiver}"/></td>
																<td><c:out value="${result.indate}"/></td>
																<td>삭제</td>
																
															</tr>
														</c:forEach>                             
<!--                           
                            <tr>
                              <td>1</td>
                              <td>test1</td>
                              <td>kopo</td>
                              <td>2021/07/25 21:16</td>
                            </tr>
                             -->
                          </tbody>                       
                        </table>
                      </div>
                    </div>
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