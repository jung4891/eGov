<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 
		pageEncoding : JSP소스코드의 캐릭터셋 - jsp페이지 자체의 캐릭터셋을 의미함 (즉, 위에서는 이 JSP 파일이 UTF-8로 인코딩 되어 있다는 것)
		contentType의 charset : HTTP 응답 캐릭터셋 - 웹브라우저(HTTP client)가 받아볼 페이지의 캐릭터셋(Http 헤더에 기록되어 있음) (즉, 서버가 UTF-8로 인코딩하여 웹브라우저에 전송)

		pageEncoding의 속성값으로 JSP 페이지를 읽어오고, charset의 속성값으로 응답결과를 생성한다.
		pageEncoding을 찾으면 해당 속성을 사용하고, 없으면 contentType을 검색한다
		
		예를들어,
		<%-- <%@ page contentType="text/html; charset=EUC-KR" pageEncoding="UTF-8" %>  --%>
    -> jsp파일은 UTF-8로 인코딩되어 있고,  웹브라우저가 받을때는 EUC-KR로 받아봄 
 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<html>
<head>
	<title>Home</title>
	
</head>
<body> 
	<h1>
		Homesss1233
	</h1> <br>
	
	@ onclick에 링크걸기 <br><br>
	<button onclick="location.href='http://www.google.com'">현재창에서 구글열기</button>
	<button onclick="window.open('http://www.google.com')">새창으로 구글열기</button> <br><br><br>
	
	<input type="button" value="ajax" style="font-size: x-large;"  onclick="location.href='ajax'"> <!-- http://localhost:8080/test/ajax -->
</body>																								<!--  /ajax   ->   http://localhost:8080/ajax  -->
</html>																						  	<!--  /       ->   http://localhost:8080  -->

