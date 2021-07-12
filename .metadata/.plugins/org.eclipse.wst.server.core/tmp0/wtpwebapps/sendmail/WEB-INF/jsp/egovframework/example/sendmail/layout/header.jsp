<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- jstl을 쓰기위해서 넣어줌 -->


<!DOCTYPE html>
<html lang="en"> 

<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <!-- Custom fonts for this template--> 
  <!-- href="<c:url value='/css/bootstrap/vendor/fontawesome-free/css/all.min.css'/>" 이렇게도 된다. 기본이 webapp에서 출발 -->
  <link href="<%=request.getContextPath()%>/css/bootstrap/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link
      href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
      rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="<%=request.getContextPath()%>/css/bootstrap/css/sb-admin-2.min.css" rel="stylesheet">
	<script src="<c:url value='/js/jquery-3.5.1.min.js'/>"></script>  
	<script type="text/javascript" defer="defer" >
	function logout() {
		if( !confirm("로그아웃 하시겠습니까?") ){
			return;				
		}
		location.href = "<c:url value='/logout.do'/>";
	}
	</script>
</head>
	