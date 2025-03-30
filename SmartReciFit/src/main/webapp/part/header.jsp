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
		<div class="logo">
			<a href="${ctx}/main.do"> <img
				src="${ctx}/img/logo.png"
				alt="스마트 레시핏 로고">
			</a>
		</div>
		<nav class="navigation">
			<ul>
				<li><a href="${ctx}/recipes.do">레시피</a></li>
				<li><a href="${ctx}/ranking.do">랭킹</a></li>
				<li><a href="${ctx}/reviews.do?page=1">후기</a></li>
				<li><a href="${ctx}/events.do">EVENT</a></li>
				<li>
					<form action="${ctx}/recipeURL.do" method="post">
						<input class="youtube-url" type="text" name="youtube-url" />
						<button>전송</button>
					</form>
				</li>
			</ul>
		</nav>


		<div class="user-actions">
			<c:choose>
				<c:when
					test="${empty sessionScope.user.userNickName and empty sessionScope.log}">
					<!-- 로그인 상태가 아닐 때 -->
					<button class="login-open">로그인</button>
					<button class="btn-userJoin"
						onclick="location.href='${ctx}/userJoin.do'">회원가입</button>
				</c:when>
				<c:otherwise>
					<!-- 로그인 상태일 때 -->
					<button class="btn-create-recipe"
						onclick="location.href='${ctx}/createRecipe.do'">레시피등록</button>
					<a href="${ctx}/logout.do" class="logout-btn">로그아웃</a>
					<c:if test="${not empty sessionScope.user.userNickName}">
						<a href="${ctx}/userContent.do?num=${sessionScope.log}">${sessionScope.user.userNickName}님</a>
					</c:if>
					<!--회원가입한 유저 로그인 상태 -->
					<c:if
						test="${empty sessionScope.user.userNickName and not empty sessionScope.log}">
						<a href="${ctx}/userContent.do?num=${sessionScope.log}">${sessionScope.nickName}님</a>
					</c:if>
					<!--소셜로그인한 로그인상태 -->
				</c:otherwise>
			</c:choose>

		</div>
	</div>
</header>
<main>