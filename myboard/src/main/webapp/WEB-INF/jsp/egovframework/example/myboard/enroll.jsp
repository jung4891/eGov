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
<title>등록페이지</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="<c:url value='/css/bootstrap/css/bootstrap.min.css'/>">
<script src="<c:url value='/js/jquery-3.5.1.min.js'/>"></script>
<script src="<c:url value='/css/bootstrap/js/bootstrap.min.js'/>"></script>
<!-- jstl태그의 c:url을 사용하면 위 경로앞에 /board/~~ 로 루트가 잡혀서 제대로 작동한다. -->
<script type="text/javascript">
	function cancel() {
		location.href = "<c:url value='/main.do'/>";
		// c:url 태그는 화면의 전체경로(http://localhost:8787/board/)를 가져와서 붙여주는 태그다.
	}
</script>
</head>
<body>
	<div class="container">
		<h1>등록/수정페이지</h1>
		<div class="panel panel-default">
			<div class="panel-heading">
				<label for="">안녕하세요~! 등록/수정페이지 입니다.</label>
			</div>
			<div class="panel-body">
<!-- 등록 -->
				<form class="form-horizontal" method="post" action="">
					<div class="form-group">
						<label class="control-label col-sm-2" for="idx">게시물 아이디:</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="idx" name="idx" placeholder="자동생성됨">
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2" for="title">제목:</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="title" name="title" placeholder="제목을 입력하세요."
								maxlength="100">
							<!-- 한글은 UTF-8로 바뀌어져 넘어갈때 3바이트로 되는데. 
									 가령 초기 sql에서 title의 길이를 100으로 잡았다면 대략 30자 입력시 90바이트가 되서
									 30자 정도가 들어가는 거다. 100자정도 들어간다고 했을때 300으로 해주면 된다.
							-->
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2" for="writer">작성자/등록일:</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="writer" name="writer" 
							  placeholder="작성자를 입력하세요." maxlength="15" style="width:40%; float: left"> 
							<!-- float: left는 등록일 옆에 붙게 하기 위해서 -->
							<input type="text" class="form-control" id="indate" name="indate"
								placeholder="등록일을 입력하세요." maxlength="10" style="width:40%">
							<!-- 2021-06-29 -까지 해서 maxlength가 10 근데 나중에 db들어갈때 바꾼다고 함 -->
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2" for="contents">내용:</label>
						<div class="col-sm-10"> 
  							<textarea class="form-control" rows="5" id="contents" name="contents" maxlength="1000"></textarea>
						</div>
						<!-- 웹에디터를 사용할수 있다. 나중에 한다. 네이버의 스마트에디터 같은. -->
					</div>
				</form>
			</div>
			<div class="panel-footer">
			  <button type="button" class="btn btn-default" onclick="">등록</button>
			  <button type="button" class="btn btn-default" onclick="">수정</button>
			  <button type="button" class="btn btn-default" onclick="cancel();">취소</button>
			</div>
		</div>
	</div>
</body>
</html>