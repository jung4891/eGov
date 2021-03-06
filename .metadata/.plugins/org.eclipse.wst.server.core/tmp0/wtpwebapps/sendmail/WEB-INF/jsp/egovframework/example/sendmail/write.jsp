<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 윗 부분 넣어줘야 한글 안깨짐 --> 

<%@ include file ="layout/header.jsp" %> 

<!-- 글쓰기 에디터 적용 (ckeditor5 Classic) -->
<!-- CDN 방식 -->
<script src="https://cdn.ckeditor.com/ckeditor5/29.0.0/classic/ckeditor.js"></script>
<!-- Zip 방식 -->
<!-- <script type="text/javascript" src="/sendmail/src/main/resources/ckeditor5/ckeditor.js"></script> -->
<!-- CDN방식으로는 자꾸 쿠키 애러나서 자바스크립트 이벤트창이 안떠서 Zip방식으로 하려고 했는데... 이게 골아프게 resources안에 넣어야 애러가 안나는데  
     resources안에는 일단 db관련된거만 있고 보통 다 WEB-INF에 있어서... 잠정포기... -->

<!-- 아래는 Document 버전으로 플러그인이 더 괜찮은거 같은데 textarea가 아닌 p태그 안에서만 적용이 되서 일단 보류..(form으로 묶어서 post보내야 되는데 p태그는 그게 안됨) -->
<!-- <script src="https://cdn.ckeditor.com/ckeditor5/29.0.0/decoupled-document/ckeditor.js"></script> -->

<!-- 네이버 스마트에디터2 라이브러리 -> 안되서 우선 보류. 부트스트랩 때문에  뭔가가 안맞는듯. 편집창에 클릭해도 먹통일 때가 있고 편집창 내용써도 value가 불러와지질 않음...  -->
<!-- http://naver.github.io/smarteditor2/user_guide/2_install/setting.html -->
<%-- <script type="text/javascript" src="<%=request.getContextPath()%>/se2/js/HuskyEZCreator.js" charset="utf-8"></script> --%>

 <script type="text/javaScript"  defer="defer">
 
 	// 그룹발송 버튼 클릭시 그룹명 선택창 뜨게함
 	function groupSelect() {
 		var spanGroup = document.getElementById("group");
		$.ajax({
            url: "selectGroups.do",
            type: "GET",									
            success: function(res){				
            	spanGroup.innerHTML = res;
            },
            error: function(){
                alert("애러");
            }
    });
 	}
 	
 	// 그룹명 선택창에서 그룹 선택시 해당 그룹에 있는 유저들의 emailAddress가 받는사람에 입력되게함
 	function selectGroup() {
 		var selectTag = document.getElementById("test");
 		var selectedGroup = selectTag.options[selectTag.selectedIndex].text;
		$.ajax({
            url: "selectEmails.do",
            type: "POST",			
            data: {
        	    groupName: selectedGroup  																
        	    },
            success: function(res){				
            	document.getElementById("receiverAddress").value = res;
            	// $("#receiverAddress").val() = res;
            },
            error: function(){
                alert("애러");
            }
    });
 		
 		
 		
 	}
 
 	function send(){
	    	
		if( $("#receiverAddress").val()==''){
	  	alert("받는 사람을 입력해주세요.");
      $("#receiver").focus();
      return;
	  }
		
		if( $("#title").val()==''){
	    alert("제목을 입력해주세요.");
      $("#title").focus();
      return;
		}
		
		// ck에디터 사용
		const element = document.getElementsByClassName('ck-content');		// 글쓰기 에디터 적용한 '내용' 부분 가져오기
		// console.log(element[0].innerText);															// 내용만 가져옴	-> test											 	
		// console.log(element[0].innerHTML);	 														// HTML요소까지 몽땅 가져옴	-> <p><strong>test</strong></p>	
		// id는 없으므로 부득이하게 해당 class명을 가진 요소 목록의 HTMLCollection을 가지고 와서 element[0]으로 할경우 해당 내용 가져올 수 있게된다. 

 		if( element[0].textContent.length == 0){ 													// 에디터 적용된 내용 부분. 
	   alert("내용을 입력해주세요.");
	   element[0].focus();
     return;
	  }		    	
		// console.log(element[0].innerText.length);											// 골때리게 아무 입력을 안해도 길이가 1이 나옴 ㅡㅡㅋ
	  // console.log(element[0].textContent.length);										// textContent는 여러 공백 입력시 다 출력해주는데 미입력시 길이가 0이 나옴!
	    	
    if (!confirm("이메일을 보내시겠습니까?")){
      return;
    }
       	
 	  $.ajax({																													// 내용의 경우는 에디터를 사용하므로 form안에 포함이 안되어 submit이 사용이 안됨. 그래서 ajax를 사용함.
	   url: 'write.do'
	   , type: 'post'
	   , dataType: 'text'																								// dataType과 data는 넘겨주는 값이 있는 경우에만 작성하면 됨.
	   , data: {
	   	senderAddress: $("#senderAddress").val(),
	    receiverAddress: $("#receiverAddress").val(),
	    title: $("#title").val(),
	    contents: element[0].innerHTML  																// 컨트롤러에서 contents 값: &lt;p&gt;&lt;strong&gt;test&lt;/strong&gt;&lt;/p&gt;
	    }
	 	})     
	  
	 	// ajax 사용 안할때(내용이 form안에 포함되어 있는 경우)는 아래처럼 기존 form의 내용을 그대로 보내면 됨.
	  // document.boardRegForm.action = "<c:url value='write_action.do'/>";
	  // document.boardRegForm.submit();		
	  
	  // 네이버 에디터 적용
 		// oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);			// 네이버 에디터에서 편집내용을 textarea의 value에 적용함
 		// console.log(document.getElementById("contents").value)								// 에디터에 내용에 대한 값 검증 */
 	}
	    
	</script>

<title>메일쓰기</title>

<body id="page-top">

  <!-- Page Wrapper -->
  <div id="wrapper">
  
  	<%@ include file ="layout/sidebar.jsp" %>

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">

        <!-- Topbar -->
        <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
        </nav>
        <!-- End of Topbar -->

          <!-- Begin Page Content -->
          <div class="container-fluid">
              <div class="form-horizontal" id="boardRegForm" name="boardRegForm" > <!-- method="post" action="<c:url value='write.do'/>" -->
              <!-- form태그 였는데 form태그이면 아래 button눌렀을때 자바스크립트에서 로직수행하고 다시 새로고침이 됨. 그래서 div로 바꿈 -->
	              <div class="d-sm-flex align-items-center justify-content-between mb-4" >
	                  <h1 class="h3 mb-0 text-gray-800">메일쓰기</h1>
	              </div> <br>
	              <div>
									보내는 사람 <input type="text" class="form-control" id="senderAddress" name="senderAddress" value="${senderAddress }" readonly="readonly" >
								</div> <br>
			  				<div>
									받는 사람 &nbsp
									<c:if test="${sessionScope.userId == 'admin'}">
										<button class="btn btn-primary" id="" onclick="groupSelect();" style="margin: 0px 5px; 
                          background-color: #96a8ba; border-color: white; font-weight: bold; font-size: 12px;">그룹발송</button>
                   	<span id="group"></span>		
									</c:if>
			
									<input type="text" class="form-control" id="receiverAddress" name="receiverAddress" placeholder="받는 사람">
								</div> <br>
								<div>
									제목 <input type="text" class="form-control" id="title" name="title" placeholder="제목">
								</div> <br>
								<div>
									내용 <br> 
										<div id="editor"> </div>

   								<!--  네이버 스마트 에디터2 
   								<textarea class="form-control" name="contents" id="contents" rows="10" cols="100"> </textarea>  -->
   								
			   				</div> <br>
								<!-- <input type="submit" id="" value="전송"></input> -->
								<button class="btn btn-primary btn-user btn-block" type="button" onclick="send();">보내기</button>
							</div> <br>
						<button class="btn btn-primary btn-user btn-block" onclick="location.href='/sendmail/main.do'">메인으로</button>  
																													<!-- onclick= "<c:url value='main.do'/> "는 왜 안되지? -->
          </div>
        </div>
        <%@ include file ="layout/footer.jsp" %>

		  </div>
		  <!-- End of Content Wrapper -->
		
		</div>
		<!-- End of Page Wrapper -->
		  
	</body>
  		     
  <script src="/sendmail/js/ckeditor.js"></script> 
  <!-- ck 에디터 자바스크립트 파일 호출(ID가 editor인 textarea에 적용되는 파일임.) 
  		  근데 이게 적용되면 아래처럼 display: none으로 속성값이 자동으로 들어가고 아래부분에 웹에디터 관련 태그들이 생성됨 
  		 <div id="editor" style="display: none;"> 
        	<p>This is some sample content.</p>
   		 </div>
   		 <div class="ck ck-reset ck-editor ck-rounded-corners" role="application" ~~~  
  		 <div class="ck ck-editor__main" role="presentation"><div class="ck ck-content ~~> 이부분이 내용부분임.  -->   

	<%-- 네이버 에디터 설정 (textarea-에디터간 연결)
	<script type="text/javascript">
		var oEditors = [];
		nhn.husky.EZCreator.createInIFrame({
		 oAppRef: oEditors,
		 elPlaceHolder: "contents",
		 sSkinURI: "<%=request.getContextPath()%>/se2/SmartEditor2Skin.html",
		 fCreator: "createSEditor2"
		});
	</script>
	 --%>

	<!-- textarea 높이 조절. 아래 클래스는 ckeditor에서 사용하는 클래스임  -->
	<style>
			.ck-content {
			    min-height: 200px;
			}
	</style> 

</html>