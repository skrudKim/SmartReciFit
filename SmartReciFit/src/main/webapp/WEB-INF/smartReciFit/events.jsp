<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../part/header.jsp"%>

<link rel="stylesheet" type="text/css" href="${ctx}/css/events.css">


<div class="event-main">

    <h2>진행중인 이벤트</h2>

    <div class="event-list">

        <%-- 이벤트1 --%>
        <a href="${ctx}/eventDetail.do?id=1" class="event-item"> 
            <div class="event-info">
               <h3 class="event-title">스마트레시핏 <br>오픈이벤트</h3>
               	<p class="event-date">2025.03.10 ~ 2025.04.30</p>
            </div>
            <div class="event-image-placeholder">
                <img src="${ctx}/img/스마트레시핏1.jpg" alt="첫번째 이벤트 배너">
            </div>
        </a>

        <%-- 이벤트2 --%>
        <a href="${ctx}/eventDetail.do?id=2" class="event-item">
            <div class="event-info">
             <h3 class="event-title">제 1회 스마트레시핏 <br>댓글 이벤트</h3>
                <p class="event-date">2025.03.10 ~ 2025.04.10</p>
            </div>
            <div class="event-image-placeholder">
            	<img src="${ctx}/img/스마트레시핏2.jpg" alt="두번째 이벤트 배너">
            </div>
        </a>

        <%-- 이벤트3 --%>
         <a href="${ctx}/eventDetail.do?id=3" class="event-item">
            <div class="event-info">
                <h3 class="event-title">스마트레시핏 AI활용<br>후기이벤트</h3>
                <p class="event-date">상시 진행</p>
            </div>
            <div class="event-image-placeholder">
            	<img src="${ctx}/img/스마트레시핏3.jpg" alt="세번째 이벤트 배너">
            </div>
        </a>

    </div>

</div>

<%@ include file="../../part/footer.jsp"%>