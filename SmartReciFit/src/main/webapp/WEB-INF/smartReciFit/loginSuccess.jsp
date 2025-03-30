<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">

<title>Smart ReciFit</title>
<link rel="stylesheet" type="text/css" href="${ctx}/css/style.css">
<script type="text/javascript"
	src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
</head>

<main>
	<div class="inner"></div>
</main>

<script type="text/javascript">
  var naver_id_login = new naver_id_login("Kc4oajEGWigub1aElsL9", "http://localhost:8084/SmartReciFit/loginSuccess.do");
  // 접근 토큰 값 출력
/*   alert(naver_id_login.oauthParams.access_token);
 */  // 네이버 사용자 프로필 조회
  naver_id_login.get_naver_userprofile("naverSignInCallback()");
  // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
  
  
  function naverSignInCallback() {
	    const nickname = naver_id_login.getProfileData('nickname'); // 사용자 닉네임
	    const email = naver_id_login.getProfileData('email'); // 사용자 이메일
	    
	    sendUserInfoToServer('naver', nickname, email);
	    function sendUserInfoToServer(platform, nickname, email) {
	        $.ajax({
	            type: 'POST',
	            url: `${ctx}/saveSocialLoginInfo.do`,
	            data: { platform, nickname, email },
	            success: function () {
	                location.href = `${ctx}/main.do`; // 메인 페이지로 이동
	            },
	            error: function (error) {
	                console.error('Error sending user info:', error);
	            },
	        });
	    }
    // 부모 창으로 데이터 전달
    if (window.opener) {
        window.opener.postMessage({
            type: 'naverLoginSuccess',
            nickname: naver_id_login.getProfileData('nickname')
        }, "http://localhost:8084"); // 부모 창의 도메인
        alert('로그인 성공')
        // 부모 창으로 리다이렉트
        
        $.ajax({
   	        type: 'POST',
   	        url: `${ctx}/saveSocialLoginInfo.do`,
   	        data: { platform: 'naver', nickname: nickname, email: email },
   	        success: function (data) {
   	            if (data === '닉네임 중복') {
   	                // 닉네임 입력 폼으로 이동
   	                window.opener.location.href = `${ctx}/nicknameInputForm.do?platform=${platform}&email=${email}&nickname=${nickname}`;
   	            } else {
   	                // 메인 페이지로 이동
   	                window.opener.location.reload();
   	            }
   	        	window.close();
   	        },
   	        error: function (error) {
   	            console.error('Error sending user info:', error);
   	        }
   	    });
    } else {
    }
  }
  
</script>


<%@ include file="../../part/footer.jsp"%>