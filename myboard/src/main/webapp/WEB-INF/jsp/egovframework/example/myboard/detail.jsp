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
<script type="text/javascript">
	function cancel() { 
		location.href = "<c:url value='/main.do'/>";
	}
</script>
</head>
<body>
	<div class="container">
		<h1>상세화면</h1>
		<div class="panel panel-default">
			<div class="panel-heading">
				<label for="">안녕하세요~! 상세페이지입니다.</label>
			</div>
			<div class="panel-body">
				<!-- 등록 -->
				<form class="form-horizontal" method="post" action="">
					<div class="form-group">
						<label class="control-label col-sm-2" for="idx">게시물 아이디:</label>
						<div class="col-sm-10 control-label" style="text-align: left">
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
		<div class="well well-sm">작성자/등록일<br/>내용</div>
		<div class="well well-lg">
			<form class="form-horizontal" method="post" action="reply.do">
				<div class="form-group">
					<label class="control-label col-sm-2" for="writer">작성자/등록일:</label>
						<div class="col-sm-10 control-label" style="text-align: left">
								<input type="text" class="form-control" id="writer" name="writer" 
								  placeholder="작성자를 입력하세요." maxlength="15" style="width:40%; float: left"> 
								<input type="text" class="form-control" id="indate" name="indate"
								  placeholder="등록일을 입력하세요." maxlength="10" style="width:40%"> 
					</div>
				</div>
					<div class="form-group">
						<label class="control-label col-sm-2" for="contents">댓글:</label>
						<div class="col-sm-10"> 
  							<textarea class="form-control" rows="3" id="reply" name="reply" maxlength="300"></textarea>
						</div>
					</div>
					<button type="submit" class="btn btn-default">댓글등록</button>
					현재는 댓글은 수정과 삭제를 할 수 없습니다.
					<!-- 댓글 수정 삭제는 별도로 -->
			</form>
		</div>
	</div>
</body>
</html>