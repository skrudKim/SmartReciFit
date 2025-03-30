<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>


<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">

<title>Smart ReciFit</title>
<link rel="stylesheet" type="text/css" href="${ctx}/css/style.css">
<script type="text/javascript" src="${ctx}/js/user/loginOut.js" defer></script>
<script src="https://accounts.google.com/gsi/client"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.11.3.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/js-base64@3.7.5/base64.min.js"></script>
<!--명보 리뷰 슬릭슬라이더 api-->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.css">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick-theme.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<header>

    <div class="header-container">

        <%-- 1. 로고 (위치/크기는 CSS로 제어) --%>
        <div class="logo">
            <a href="${ctx}/main.do">
                <img src="${ctx}/img/SmartRecifitLogoSpoonFork.png" alt="스마트 레시핏 로고">
            </a>
        </div>

        <%-- 2. 유튜브 검색창 컨테이너 (새로 추가) --%>
        <div class="search-bar-container">
             <form action="${ctx}/recipeURL.do" method="post">
                 <input class="youtube-url" type="text" name="youtube-url" placeholder="유튜브 레시피 영상 URL을 넣어보세요! AI가 요약해드립니다" />
                 <button type="submit">전송</button>
             </form>
        </div>

        <%-- 3. 네비게이션 메뉴 (링크만 포함) --%>
        <nav class="navigation">
            <ul>
                <li><a href="${ctx}/recipes.do">레시피</a></li>
                <li><a href="${ctx}/ranking.do">랭킹</a></li>
                <li><a href="${ctx}/reviews.do?page=1">후기</a></li>
                <li><a href="${ctx}/events.do">EVENT</a></li>
                <%-- 유튜브 폼은 위로 이동했음 --%>
            </ul>
        </nav>

        <%-- 4. 사용자 액션 버튼 (우측 상단) --%>
        <div class="user-actions">
            <c:choose>
                <c:when test="${empty sessionScope.user.userNickName and empty sessionScope.log}">
                    <%-- 클래스 login-open 과 btn-userJoin 유지 (JS 또는 CSS 선택자 위해) --%>
                    <button class="login-open" styke="font-family: 'ChosunGu'">로그인</button>
                    <a href="${ctx}/userJoin.do" class="btn-userJoin">회원가입</a>
                </c:when>
                <c:otherwise>
                    <a href="${ctx}/logout.do" class="logout-btn">로그아웃</a>
                    <c:choose>
                         <c:when test="${not empty sessionScope.user.userNickName}">
                             <a href="${ctx}/userContent.do?num=${sessionScope.log}">${sessionScope.user.userNickName}님</a>
                         </c:when>
                         <c:when test="${not empty sessionScope.log}">
                             <a href="${ctx}/userContent.do?num=${sessionScope.log}">${sessionScope.nickName}님</a>
                         </c:when>
                         <c:otherwise>
                             <a href="#">내 정보</a>
                         </c:otherwise>
                    </c:choose>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>
<main>