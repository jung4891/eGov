<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>  

<html>
<head>
	<title>Ajax</title>
	<script src="<c:url value='/resources/js/jquery-3.5.1.min.js'/>"></script>  
	<!-- c:url 안쓰고 그냥 하드코딩으로 입력은 어떻게 하지??  -->
</head>
<body>
	<h1>Ajax 연습</h1>
	
	<button onclick="location.href='/test'">메인으로</button> <br><br><br>
	
	<!-- 
			AJAX(Asynchronous JavaScript and XML) 
			AJAX는 단순히 텍스트값만 넘길수도 있고, form을 넘길수도 있고, 파일 업로드와 같이 웹개발에서 중요한 역할을 담당한다.
			AJAX만 잘 알아도 개발하는데 시간단축이 된다.
			AJAX는 비동기식 방법으로 데이터에 접근하는 것이다. 쉽게 말하면 그냥 브라우저에서 새로고침하지 않고도 데이터값을 변경할수 있는 것이다.
			대표적으로 AJAX가 사용된 사례는 각종 포털사이트의 인기검색어 혹은 연관검색어이다.
	 -->
	 
	 1) Ajax의 가장 기본형태:   
	 <button id="btn1">simpleAJAX</button>
	 <div id="result"></div>
	 <div id="testRes"></div> <br><br>
	 
	 2) 입력한 값들로 주고받기:
	 <button id="btn2">serialize</button>
	 <form id="frm">
	    name : <input type="text" name="name" id="name"><br>
	    age : <input type="text" name="age" id="age">
	 </form>
	 <div id="result2"></div>
	 
	 
</body>
</html> 

<script>

	// 1) Ajax의 기본형태
	// data를 전송해서 필요한 로직들을 처리하고 값을 return 받음.
	$('#btn1').on('click', function(){
		var form = {
				name: "hyukjung",
				age: 32,
				test: 1
		}
		$.ajax({
            url: "requestObject",
            type: "POST",
            data: form,											// 위 form을 보내면 컨트롤러에서  person VO가 받아서 name과 age에 들어가게됨.
            success: function(data){				// data는 컨트롤러에서 return된 String값임.
                $('#result').text(data);		// hyukjung 32 / test: 1
                $('#testRes').text("test");
            },
            error: function(){
                alert("simpleWithObject err");
            }
    });
	});
	

	// 2) 입력한 data를 전송해서 필요한 로직들을 처리하고 값을 return 받음.
	// serialize() 메소드는 jquery가 가지고 있는 기본기능중 하나로 form의 객체들을 한번에 받을 수가 있다. 
	$('#btn2').on('click', function(){
			$.ajax({
	        url: "serialize",
	        type: "POST",
	        data: $("#frm").serialize(),		// serialize() 없으면 정상작동이 안된다.
	        success: function(data){
	            $('#result2').text(data);
	        },
	        error: function(){
	            alert("serialize err");
	        }
	    });
			// alert($("#frm").serialize());				// name=jung&age=32
			// alert($("#name").val())							// jung
			// alert($("#frm"));										// [object Object]
	});
	
</script>
