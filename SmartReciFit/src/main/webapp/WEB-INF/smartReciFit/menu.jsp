<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<div class="admin-menu">
    <h3>회원 관리</h3>
    <ul>
        <li><a href="${ctx}/userList.do">전체 회원</a></li>
        <li><a href="${ctx}/adminUser.do">관리/운영</a></li>
    </ul>
    <h3>콘텐츠 관리</h3>
    <ul>
        <li><a href="${ctx}/adminRecipe.do?page=1">레시피</a></li>
        <li><a href="${ctx}/adminReview.do">후기</a></li>
    </ul>
</div>