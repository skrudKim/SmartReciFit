<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="kr.smartReciFit.model.user.User"%>
<!DOCTYPE html>
<%@ include file="../../part/header.jsp"%>
<link rel="stylesheet" type="text/css" href="${ctx}/css/CJYstyle.css">
<c:if test="${userContent eq null}">
	<c:redirect url="/userContent.do?num=${sessionScope.log}" />
</c:if>

<div class="inner">
<div class="title"><h2><span>${userContent.userNickName}</span>님의 MYPAGE</h2></div>
<hr>

<div class="contentEvery">
<div class="contentImg">
	<c:choose>
		<c:when test="${not empty userContent.userImg}">
		<img src="${ctx}/img/${userContent.userImg}" class="photo"	id="userImg" />
		</c:when>
		<c:otherwise>
		<img src="${ctx}/img/ProfileBasicImg.png" class="photo" id="default" />
		</c:otherwise>
	</c:choose>
</div>

<c:if test="${not empty userContent.userId}">
<div class="contentTable">
<table>
	<tr><td>아이디</td><td>${userContent.userId}</td></tr>
	<tr><td>비밀번호</td><td>${userContent.userPw}</td></tr>
	<tr><td>이름</td><td>${userContent.userName}</td></tr>
	<tr><td>E-mail</td><td>${userContent.userEmail}</td></tr>
	<tr><td>전화번호</td><td>
	<c:choose>
		<c:when test="${empty userContent.userPhone}">
		전화번호를 입력하지 않으셨습니다
		</c:when>
		<c:otherwise>
		${userContent.userPhone}
		</c:otherwise>
		</c:choose>
	</td></tr>
</table>
</div>
</c:if>

</div>

<button class="btn-yellow" name="btn-fixUser" id="btn-fixUser" onclick="location.href='${ctx}/userFix.do?num=${userContent.userNum}'">회원정보수정</button>
<%-- 
<div class="contentSocialBox">

<script src="${ctx}/js/user/userContent.js"></script>
<!-- ============= 소셜 계정 연동 ================= -->
<%
// 로그인 상태인지 확인
User user = (User) session.getAttribute("user");
// 로그인된 상태일 때만 소셜 계정 연동 버튼 표시
if (user != null) {
	// 세션에서 'linkedAccounts' 가져오고, 없으면 빈 HashMap 생성
	Map<String, Boolean> linkedAccounts = (Map<String, Boolean>) session.getAttribute("linkedAccounts");
	if (linkedAccounts == null) {
		linkedAccounts = new HashMap<>();
	}
%>

<%-- <table border="1">
	<tr>
		<td>카카오 계정 연동</td>
		<td>
			<button onclick="kakaoLogin()"
				<%if (linkedAccounts.getOrDefault("kakao", false)) {%> disabled
				<%}%>>
				<%=linkedAccounts.getOrDefault("kakao", false) ? "연동됨" : "연동"%>
			</button> <a href="javascript:kakaoLogin()"><img
				src="<c:url value='/img/kakaoIcon.png'/>"
				style="width: 40px <%=linkedAccounts.getOrDefault("kakao", false) ? "pointer-events: none; opacity: 0.5;" : ""%>"></a>
		</td>
	</tr>
	<tr>
		<td>네이버 계정 연동</td>
		<td>
			<button class="naver_social_connection"
				<%if (linkedAccounts.getOrDefault("naver", false)) {%> disabled
				<%}%>>
				<%=linkedAccounts.getOrDefault("naver", false) ? "연동됨" : "연동"%>
			</button>
			<div id="naver_id_login"
				<%=linkedAccounts.getOrDefault("naver", false) ? "style='pointer-events: none; opacity: 0.5;'" : ""%>></div>
		</td>
	</tr>
	<tr>
		<td>구글 계정 연동</td>
		<td>
			<button id="googleButton" onclick="googleLogin()"
				<%if (linkedAccounts.getOrDefault("google", false)) {%> disabled<%}%>>
				<%=linkedAccounts.getOrDefault("google", false) ? "연동됨" : "연동"%>
			</button>
			<div id="g_id_onload"
				data-client_id="231194762579-nbasfr2j9k5nrb2nu78t6r6ou03c3btk.apps.googleusercontent.com"
				data-login_uri="http://localhost:8084/SmartReciFit/main.do"
				data-auto_prompt="false"></div>
			<button class="test" >테스트</button>
			<div class="g_id_signin" id="googleSignInButton" data-type="standard"
				data-size="large" data-theme="outline" data-text="sign_in_with"
				data-shape="rectangular" data-logo_alignment="left"
				<%=linkedAccounts.getOrDefault("google", false) ? "style='pointer-events: none; opacity: 0.5;'" : ""%>></div>
		</td>
	</tr>
</table> --%>

<div class="contentSocialBox">
	<table border="1">
		<tr>
			<td colspan="2"
				style="text-align: center; font-weight: bold; color: red;">아이콘을
				눌러 연동하세요.</td>
		</tr>
		<tr>
			<td>카카오 계정 연동</td>
			<td><img id="kakaoIcon" onclick="kakaoLogin()"
				src="<c:url value='/img/kakaoIcon.png'/>"
				style="width: 40px; cursor: pointer;
                <%=linkedAccounts.getOrDefault("kakao", false) ? "pointer-events: none; opacity: 0.5;" : ""%>">
			</td>
			<td>
				<button id="kakaoUnlink"
					style="pointer-events: <%=linkedAccounts.getOrDefault("kakao", false) ? "auto" : "none"%>; opacity: <%=linkedAccounts.getOrDefault("kakao", false) ? "1" : "0.5"%>;"
					onclick="unlinkSocial('kakao')">연동 해제</button>
			</td>
		</tr>
		<tr>
			<td>네이버 계정 연동</td>
			<td><img class="naver_social_connection"
				src="${ctx}/img/btnG_아이콘원형.png"
				style="width: 40px; cursor: pointer;
    <%=linkedAccounts.getOrDefault("naver", false) ? "pointer-events: none; opacity: 0.5;" : ""%>">

				<div id="naver_id_login" style="display: none;"></div></td>
			<td>
				<button id="naverUnlink"
					style="pointer-events: <%=linkedAccounts.getOrDefault("naver", false) ? "auto" : "none"%>; opacity: <%=linkedAccounts.getOrDefault("naver", false) ? "1" : "0.5"%>;"
					onclick="unlinkSocial('naver')">연동 해제</button>
			</td>
		</tr>
		<tr>
			<td>구글 계정 연동</td>
			<td><div id="g_id_onload"
					data-client_id="231194762579-nbasfr2j9k5nrb2nu78t6r6ou03c3btk.apps.googleusercontent.com"
					data-login_uri="http://localhost:8084/SmartReciFit/main.do"
					data-auto_prompt="false"></div>
				<div class="g_id_signin" id="googleSignInButton"
					data-type="standard" data-size="large" data-theme="outline"
					data-text="sign_in_with" data-shape="rectangular"
					data-logo_alignment="left"
					<%=linkedAccounts.getOrDefault("google", false) ? "style='pointer-events: none; opacity: 0.5;'" : ""%>></div>

			</td>
			<td>
				<button id="googleUnlink"
					style="pointer-events: <%=linkedAccounts.getOrDefault("google", false) ? "auto" : "none"%>; opacity: <%=linkedAccounts.getOrDefault("google", false) ? "1" : "0.5"%>;"
					onclick="unlinkSocial('google')">연동 해제</button>
			</td>
		</tr>
	</table>
</div>

<%
// 세션에서 메시지 가져오기
String message = (String) session.getAttribute("message");
if (message != null && !message.isEmpty()) {
%>
<script>
        alert("<%=message%>");
    </script>

<%
session.removeAttribute("message"); // 메시지 삭제 (새로고침 시 alert 안 뜨게)
}
%>
<%
}
%>
<p style="font-size: 12px; color: #555; margin-top: 10px;">⚠️ 회원가입한
	이메일을 사용하는 계정을 연동해주세요. 연동시 기존 로그인으로 접속됩니다.</p>
</div>--%>

	<div class="contentInfoBox">
<c:choose>
	<c:when test="${empty userInfoContent}">
	<p>아직 인포를 저장하지 않았습니다.</p>
	<button name="btn-makeInfo" id="btn-makeInfo" onclick="location.href='${ctx}/userInfo.do'">인포만들기</button>
	</c:when>
	<c:otherwise>
		<table class="infoTable">
			<tr>
				<td>나의 식사량</td>
				<td><span class="mealSize">${userInfoMealSize}</span> 인분의 식사를 해요</td>
			</tr>
			<tr>
				<td>나의 선호 TAG</td>
				<td><c:forEach var="info" items="${totalInfo}"><span class="infoItem">${info}</span></c:forEach>
				</td>
			</tr>
		</table>
			<!-- 이거 이렇게 냅다 연결시키면 냅다 입력이 되니까 이거 막아주는거 하나 장치 마련하기  -->
					<form id="userInfoFixForm" action="${ctx}/userInfoFix.do"
						method="post">
						<input type="hidden" name="num" value="${userContent.userNum}">
						<input type="hidden" name="userMealSize"
							value="${userInfoMealSize}">
						<c:forEach var="item" items="${totalInfo}">
							<input type="hidden" name="list" value="${item}">
						</c:forEach>
						<button type="submit" class="btn-yellow" name="btn-makeInfo" id="btn-makeInfo">인포수정하기</button>
					</form>
						
	</c:otherwise>
</c:choose>
</div>
<button class="btn-grey" name="btn-userDel" id="btn-userDel" onclick="location.href='${ctx}/userDel.do'">회원탈퇴</button>
	
	</div>

<%-- <script src="${ctx}/js/user/userContent.js"></script> --%>
<script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
<script type="text/javascript">
	document.querySelector('.naver_social_connection').addEventListener('click', function() {
	    document.querySelector('#naver_id_login').querySelector('a').click();
	});

</script>

<script>
function unlinkSocial(platform) {
	fetch('unLinkButton.do?platform=' + platform)
        .then(response => {
            if (!response.ok) {
                throw new Error('네트워크 오류가 발생했습니다.');
            }
            return response.text();
        })
        .then(data => {
            if (data === 'success') {
                alert(platform + ' 계정 연동이 해제되었습니다.');
                document.getElementById(platform + 'Unlink').style.pointerEvents = 'none';
                document.getElementById(platform + 'Unlink').style.opacity = '0.5';

                // 연동 버튼 활성화
                if (platform === 'kakao') {
                    document.getElementById('kakaoIcon').style.pointerEvents = 'auto'; // 카카오 연동 버튼 활성화
                    document.getElementById('kakaoIcon').style.opacity = '1';
                } else if (platform === 'naver') {
                    document.querySelector('.naver_social_connection').style.pointerEvents = 'auto'; // 네이버 연동 버튼 활성화
                    document.querySelector('.naver_social_connection').style.opacity = '1';
                } else if (platform === 'google') {
                    document.getElementById('googleSignInButton').style.pointerEvents = 'auto'; // 구글 연동 버튼 활성화
                    document.getElementById('googleSignInButton').style.opacity = '1';
                }

            } else {
                alert('연동 해제에 실패했습니다. 다시 시도해주세요.');
            }
        })
        .catch(error => {
            console.error('연동 해제 오류:', error);
            alert('연동 해제 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
        });
}
</script>

<%@ include file="../../part/footer.jsp"%>