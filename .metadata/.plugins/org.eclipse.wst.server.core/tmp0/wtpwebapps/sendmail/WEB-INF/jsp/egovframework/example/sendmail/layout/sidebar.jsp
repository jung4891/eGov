<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%
	String userName = request.getSession().getAttribute("userName").toString();
%>
    <!-- Sidebar -->
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

      <!-- Sidebar - Brand -->
      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="<c:url value='/main.do'/>">
        <div class="sidebar-brand-icon rotate-n-15">
            <i class="fas fa-laugh-wink"></i>
        </div>
        <div class="sidebar-brand-text mx-3">Durian<!-- <sup>2</sup> --></div>
      </a>

      <!-- Divider -->
      <hr class="sidebar-divider my-0">

      <!-- Nav Item - Dashboard -->
      <li class="nav-item active">
        <a class="nav-link" href="<c:url value='/wholebox.do?userName=${userName }'/>">
        <i class="far fa-envelope-open"></i>
            <span>전체메일</span></a>
      </li>
      <li class="nav-item active">
        <a class="nav-link" href="<c:url value='/inbox.do?userName=${userName }'/>">
        <i class="far fa-envelope-open"></i>
            <span>받은메일함</span></a>
      </li>
      <li class="nav-item active">
        <a class="nav-link" href="<c:url value='/outbox.do?userName=${userName }'/>">
        <i class="	far fa-envelope-open"></i> 
            <span>보낸메일함</span></a>
      </li>            

      <!-- Divider -->
      <hr class="sidebar-divider">
      
      <li class="nav-item active">
        <a class="nav-link" href="<c:url value='/main.do'/>">
        <i class="fas fa-poo"></i> 
          <span>스팸메일함</span></a>
      </li>            
      <li class="nav-item active">
        <a class="nav-link" href="<c:url value='/main.do'/>">
        <i class="fas fa-trash"></i>
          <span>휴지통</span></a>
      </li>      
      <!-- Divider -->
      <hr class="sidebar-divider"> 
      
      <c:if test="${sessionScope.userId == null || sessionScope.userId == ''}">
         <a style="margin: 0px 40px; background-color: darkseagreen; font-weight: bold;" 
         		class="btn btn-primary" href="<c:url value='/loginPage.do'/>">로그인</a>
			</c:if>
			
			<c:if test="${sessionScope.userId != null && sessionScope.userId != ''}">
				<div style="padding: 10px 10px; text-align: center; color: white;">
						${sessionScope.userName}님 환영합니다.</div>  
         <a style="margin: 0px 40px; background-color: darkseagreen; font-weight: bold;"  
         		class="btn btn-primary" href="<c:url value='/writePage.do'/>">메일쓰기</a> <br/> 
			</c:if>
			
   		<c:if test="${sessionScope.userId != null && sessionScope.userId != ''}">

				<button style="margin: 0px 40px; background-color: darkseagreen; font-weight: bold; 
								type="button" class="btn btn-primary" onclick="logout();">로그아웃</button>
			</c:if> <br/>
			


    </ul>
    <!-- End of Sidebar -->