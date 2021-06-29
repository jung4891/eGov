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
<title>상세페이지</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="<c:url value='/css/bootstrap/css/bootstrap.min.css'/>">
<script src="<c:url value='/js/jquery-3.5.1.min.js'/>"></script>
<script src="<c:url value='/css/bootstrap/js/bootstrap.min.js'/>"></script>
<!-- jstl태그의 c:url을 사용하면 위 경로앞에 /board/~~ 로 루트가 잡혀서 제대로 작동한다. -->
<script type="text/javascript">
	function cancel() {
		location.href = "<c:url value='/list.do'/>";
		// c:url 태그는 화면의 전체경로(http://localhost:8787/board/)를 가져와서 붙여주는 태그다.
	}
</script>
</head>
<body>
	<div class="container">
		<h1>상세화면</h1>
		<div class="panel panel-default">
			<div class="panel-heading">
				<label for="">안녕하세요~! 상세페이지입니다.</label>
				<!-- for = ""는 지시자라 부른다. -->
			</div>
			<div class="panel-body">
				<!-- 등록 -->
				<form class="form-horizontal" method="post" action="">
					<div class="form-group">
						<label class="control-label col-sm-2" for="idx">게시물 아이디:</label>
						<div class="col-sm-10 control-label" style="text-align: left">
						<!-- 색상 진하게 나와서 class에 control-label추가. 근데 오른쪽으로 가서 left 넣음 -->
							게시물 아이디
						</div> 
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2" for="title">제목:</label>
						<div class="col-sm-10 control-label" style="text-align: left">
							제목
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2" for="writer">작성자/등록일:</label>
						<div class="col-sm-10 control-label" style="text-align: left">
							작성자/등록일
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2" for="contents">:</label>
						<div class="col-sm-10 control-label" style="text-align: left">
							내용
						</div>
					</div>
				</form>
			</div>
			<div class="panel-footer">
				<button type="button" class="btn btn-default">수정</button>
				<button type="button" class="btn btn-default">삭제</button>
				<button type="button" class="btn btn-default" onclick="cancel();">목록</button>
			</div>
		</div>
	</div>
</body>
</html>