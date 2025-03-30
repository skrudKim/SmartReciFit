<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="modal login-modal">
	<div class="modal-content">
		<button class="btn-close login-close">&times;</button>
		<h2 style="text-align: center; margin: 20px 0; font-weight: bold;">
			<img alt="logo" src="${ctx}/img/SmartRecifit Logo.png"
				style="width: 300px;"> 
		</h2>
		<!-- 제목 추가 -->
		<form id="loginForm" style="margin-top: 20px;">
			<label for="id">아이디</label> <input type="text" id="id" name="id"
				required placeholder="아이디를 입력하세요."> <label for="pw">비밀번호</label>
			<input type="password" id="pw" name="pw" required
				placeholder="비밀번호를 입력하세요.">
			<button type="submit" style=" font-family: 'ChosunGu'">로그인</button>
		</form>


		<div class="icon-container">

			<!-- 카카오 로그인 버튼 노출 영역 -->
			<a href="javascript:kakaoLogin()"><img
				src="<c:url value='/img/kakaoIcon.png'/>" class="login-icon"></a>
			<!-- 카카오 로그인 버튼 노출 영역 -->

			<!-- 네이버 로그인 버튼 노출 영역 -->
			<img class="naver_login_connection login-icon"
				src="${ctx}/img/btnG_아이콘원형.png">
			<div id="naver_id_login"></div>
			<!-- //네이버 로그인 버튼 노출 영역 -->

			<!-- 구글 로그인 버튼 노출 영역 -->
			<div id="g_id_onload"
				data-client_id="231194762579-nbasfr2j9k5nrb2nu78t6r6ou03c3btk.apps.googleusercontent.com"
				data-login_uri="http://localhost:8084/SmartReciFit/main.do"
				data-auto_prompt="false"></div>
			<div class="g_id_signin" data-type="icon" data-size="large"
				data-theme="filled_blue" data-shape="circle"
				data-logo_alignment="left"></div>
			<!-- 구글 로그인 버튼 노출 영역 -->

		</div>

		<div class="find-account"
			style="text-align: center; margin-top: 10px; font-size: 12px;">
			<!-- 작게 표시 -->
			<a href="${ctx}/userFind.do" class="find-account button">아이디 또는
				비밀번호 찾기</a>
		</div>


	</div>
</div>

<div class="overlay"></div>
<!------------------------ 카카오 script ------------------------>
<script type="text/javascript"
	src="https://developers.kakao.com/sdk/js/kakao.js"></script>


<!------------------------ 네이버 script ------------------------>
<script type="text/javascript"
	src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js"
	charset="utf-8"></script>


<!------------------------ 구글 script loginOut.js 에 있음 ------------------------>

<script src="${ctx}/js/user/userSocialLogin.js"></script>
<script type="text/javascript">
	document.querySelector('.naver_login_connection').addEventListener(
			'click',
			function() {
				document.querySelector('#naver_id_login').querySelector('a')
						.click();
			});
</script>
