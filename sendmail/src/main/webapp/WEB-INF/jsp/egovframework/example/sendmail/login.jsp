<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 윗 부분 넣어줘야 한글 안깨짐 --> 
<%@ include file ="../sendmail/layout/header.jsp" %>

<script type="text/javascript">

$( document ).ready(function() {
	<c:if test="${!empty msg}">  
    	alert("${msg}"); 
  </c:if> 
});

function check() {
	// alert('1');
	if( $('#user_id').val() == '') {
		alert("아이디를 입력하세요!");
		return false;
	}
	if( $('#password').val() == '') {
		alert("비밀번호를 입력하세요!");
		return false;
	}
	return true;
}
</script>


<body class="bg-gradient-primary">

    <div class="container">

        <!-- Outer Row -->
        <div class="row justify-content-center">

            <div class="col-xl-10 col-lg-12 col-md-9">

                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body -->
                        <div class="row">
                            <div class="col-lg-6 d-none d-lg-block bg-login3-image"></div>
                            <div class="col-lg-6">
                                <div class="p-5">
                                    <div class="text-center">

                                    </div>
                                    <form class="user" method="post" action="<c:url value='/login.do'/>">
                                        <div class="form-group">						
                                            <input type="text" class="form-control form-control-user"
                                                id="user_id" name="user_id" 
                                                placeholder="ID"> 
                                        </div>
                                        <div class="form-group">
                                            <input type="password" class="form-control form-control-user"
                                                id="password" name="password" placeholder="Password">
                                        </div>
                                        <button type="submit" onclick="return check();" class="btn btn-primary btn-user btn-block">
                                            Login
                                        </button>
                                        <hr>
																		</form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="<%=request.getContextPath()%>/css/bootstrap/vendor/jquery/jquery.min.js"></script>
    <script src="<%=request.getContextPath()%>/css/bootstrap/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="<%=request.getContextPath()%>/css/bootstrap/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="<%=request.getContextPath()%>/css/bootstrap/js/sb-admin-2.min.js"></script>

</body>

</html>