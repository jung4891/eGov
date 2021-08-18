
// 쿠키관련 애러 처리 
// (Indicate whether to send a cookie in a cross-site request by specifying its SameSite attribute) 
// 추가하면 아래 1 request는 사라짐. 그리고 크롬 쿠키 전체삭제 하면 애러는 다 사라짐
// 하지만 메일전송 성공시 여전히 이벤트창은 안뜸
document.cookie = "safeCookie1=foo; SameSite=Lax"; 
document.cookie = "safeCookie2=foo"; 
document.cookie = "crossCookie=bar; SameSite=None; Secure"; 

	ClassicEditor
        .create( document.querySelector( '#editor' ) )
        .then( editor => { 
        	console.log( editor ); 
        } ) 
        .catch( error => {
            console.error( error );
        } );