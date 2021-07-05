<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 윗 부분 넣어줘야 한글 안깨짐 --> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- jstl을 쓰기위해서 넣어줌 -->

<!DOCTYPE html>
<html lang="ko">
<head>
<title>부트스트랩 게시판 시작!</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="<c:url value='/css/bootstrap/css/bootstrap.min.css'/>">
<script src="<c:url value='/js/jquery-3.5.1.min.js'/>"></script>
<script src="<c:url value='/css/bootstrap/js/bootstrap.min.js'/>"></script>
<!-- jstl태그의 c:url을 사용하면 위 경로앞에 /board/~~ 로 루트가 잡혀서 제대로 작동한다. -->
<script type="text/javascript" defer="defer" >
	$( document ).ready(function() {
		<c:if test="${!empty msg}">  
	    	alert("${msg}"); 
	  </c:if> 
	});
	// 본 다큐먼트가 로딩될때 이벤트를 걸어주는 제이쿼리 문법. 윈도우의 javascript 맹키로.
	// 로그인시 아이디와 비번이 틀렸을때 이벤트창 띄워주는 역할을 함.
	
	function enroll() {
		location.href = "<c:url value='/mgmt.do'/>";
		// c:url 태그는 화면의 전체경로(http://localhost:8787/board/)를 가져와서 붙여주는 태그다.
	}
	function view(idx) {
		location.href = "<c:url value='/view.do'/>?idx="+idx;
	}
	function setPwd(user_id) {
		if( user_id == "admin" ){
			$('#password').val('manager');
		}else if( user_id == "guest" ){
			$('#password').val('guest');
		}else if( user_id == "guest2" ){
			$('#password').val('guest2');
		}else{
			$('#password').val('');			
		}
	}
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
	function logout() {
		location.href = "<c:url value='/logout.do'/>";
	}
	</script>

</head>
<body>
	<div class="container">
		<h1>메인</h1>
		<div class="panel panel-default">
			<div class="panel-heading">
				<!-- 비로그인 상태라면 로그인 창이 보이게 하고 -->
				<c:if test="${sessionScope.userId == null || sessionScope.userId == ''}">
					${sessionScope.userName}님 비로그인 상태임. 
					<form class="form-inline" method="post" action="<c:url value='/login.do'/>">
						<div class="form-group">
							<label for="user_id">ID:</label>
							<select class="form-control" id="user_id" name="user_id" onchange="setPwd(this.value);">
								<option value="">선택해주세요</option>
								<option value="admin">관리자</option>
								<option value="guest">사용자</option>
								<option value="guest2">사용자2</option>
							</select>
						</div>
						<div class="form-group">
							<label for="password">Password:</label>
							<input type="password" class="form-control" id="password" name="password">
						</div>
						<button type="submit" class="btn btn-default" onclick="return check();">로그인</button>
						<!-- 실제로 onclick="return false"일때는 form의 action을 타지 않는다. -->
					</form>
				</c:if>
				<!-- 로그인 상태라면 로그인 창이 안보이게 하고 환영합니다 문구와 로그아웃 버튼 삽입 -->
				<c:if test="${sessionScope.userId != null && sessionScope.userId != ''}">
					${sessionScope.userName}님 환영합니다.
					<button type="button" class="btn btn-default" onclick="logout();">로그아웃</button>
				</c:if>
			</div>
			<div class="panel-body">
				<!-- 검색 -->
				<form class="form-inline" action="<c:url value='/list.do'/>">
					<div class="form-group">
						<label for="searhName">제목(내용):</label>
						<!-- label의 for는 특별한 의미는 없고 가리키는 부분의 id를 적으면 된다. -->
						<input type="text" class="form-control" id="searhName">
					</div>
					<button type="submit" class="btn btn-default">검색</button>
				</form>
				<div class="table-responsive">
					<table class="table table-hover">
						<thead>
							<tr>
								<th>게시물번호</th>
								<th>제목</th>
								<th>조회수</th>
								<th>작성자</th>
								<th>작성일</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach var="result" items="${resultList}" varStatus="status">
							<tr>
								<td><a href="javascript:view('${result.idx}');"><c:out value="${result.idx}"/></a></td>
								<td><a href="javascript:view('${result.idx}');"><c:out value="${result.title}"/></a></td>
								<td><c:out value="${result.count}"/></td>
								<td><c:out value="${result.writerNm}"/></td>
								<td><c:out value="${result.indate}"/></td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<div class="panel-footer">
			<c:if test="${!empty sessionScope.userId}">		<!-- 로그인시에만 보이게 -->
				<button type="button" class="btn btn-default" onclick="enroll();">등록</button>
			</c:if>
			</div>
		</div>
	</div>
</body>
</html>