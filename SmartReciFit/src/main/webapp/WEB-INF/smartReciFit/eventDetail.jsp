<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../part/header.jsp"%>

<link rel="stylesheet" type="text/css" href="${ctx}/css/eventDetail.css">

<div class="event-detail-container">

	<c:if test="${not empty event}">

		<%-- 이벤트 배너 이미지 --%>
		<div class="event-detail-banner">
			<img src="${ctx}${event.eventImg}" alt="${event.eventTitle} 배너">
		</div>

		<h2 class="event-detail-title">${event.eventTitle}</h2>

		<%-- 이벤트 소개글 --%>
		<div class="event-detail-intro">
			<p>${event.introductionText}</p>
		</div>

		<div class="event-section">
			<h3>기간</h3>
			<ul>
				<li><strong>응모 기간:</strong> 
					<fmt:formatDate value="${event.startDate}" pattern="yyyy년 MM월 dd일" />
					~ <fmt:formatDate value="${event.endDate}" pattern="yyyy년 MM월 dd일" />
				</li>
				<li><strong>발표:</strong> 이벤트 마지막일</li>
			</ul>
		</div>

		<div class="event-section">
			<h3>당첨자 선정</h3>
			<ul>
				<li><strong>경품:</strong> 백화점 상품권 5만원권</li>
				<li><strong>당첨 인원:</strong> ${event.winnerCount}</li>
				<li><strong>선정 기준:</strong></li>
			</ul>
			<p>${event.selectionCriteria}</p>

			<p style="font-size: 0.9em; color: #777; margin-top: 10px;">*
				당첨자에게는 개별 연락 드릴 예정입니다.</p>
		</div>

		<div class="event-section">
			<h3>안내사항</h3>
			<p>${event.guidelines}</p>
		</div>

	</c:if>

</div>

<%@ include file="../../part/footer.jsp"%>