<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 윗 부분 넣어줘야 한글 안깨짐 -->
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- jstl을 쓰기위해서 넣어줌 -->

<!DOCTYPE html>
<html lang="ko">
<head>
<title>부트스트랩 마이게시판 시작!</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="<c:url value='/css/bootstrap/css/bootstrap.min.css'/>">
<script src="<c:url value='/js/jquery-3.5.1.min.js'/>"></script>
<script src="<c:url value='/css/bootstrap/js/bootstrap.min.js'/>"></script>
<!-- jstl태그의 c:url을 사용하면 위 경로앞에 /board/~~ 로 루트가 잡혀서 제대로 작동한다. -->
<script type="text/javascript">

	$( document ).ready(function() {
		// $('#h1').text('test');		
	});
	
	function enroll() {
		location.href = "<c:url value='/enroll.do'/>";
		// c:url 태그는 화면의 전체경로(http://localhost:8787/myboard/)를 가져와서 붙여주는 태그다.
	}
	function detail() {
		location.href = "<c:url value='/detail.do'/>";
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
</script>
</head>
<body>
	<div class="container">
		<h1>메인</h1>
		<h1 id="h1"></h1>
		<div class="panel panel-default">
			<div class="panel-heading">
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
				</form>
			</div>
			<div class="panel-body">
				<!-- 검색 -->
				<form class="form-inline" action="/list.do">
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
							<tr>
								<td><a href="javascript:detail();">1</a></td>
								<td><a href="javascript:detail();">1번게시물</a></td>
								<td>1</td>
								<td>관리자</td>
								<td>2021-06-29</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="panel-footer">
			  <button type="button" class="btn btn-default" onclick="enroll();">등록</button>
			</div>
		</div>
	</div>
</body>
</html>