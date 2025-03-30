<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../part/header.jsp"%>
<style>
.event-detail-container {
	max-width: 800px; 
	margin: 40px auto;
	padding: 30px; 
	background-color: #fff; 
	border: 1px solid #e0e0e0; 
	border-radius: 8px;
	line-height: 1.7; 
	color: #333;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05); 
}


.event-detail-banner {
	margin-bottom: 30px;
	border-radius: 5px; 
	overflow: hidden; 
}

.event-detail-banner img {
	display: block;
	width: 100%;
	max-height: 400px; 
	object-fit: cover;
}

.event-detail-title {
	font-size: 2rem; 
	font-weight: 700; /
	color: #2E8B57; 
	margin-bottom: 20px;
	text-align: center; 
}

.event-detail-intro {
	font-size: 1.05rem; 
	color: #555;
	margin-bottom: 40px; 
	padding: 25px;
	background-color: #f9f9f9;
	border-radius: 5px; 
	border-left: 5px solid #3CB371; 
}


.event-section {
	margin-bottom: 40px; 
}


.event-section h3 {
	font-size: 1.4rem; 
	font-weight: 600; 
	color: #2E8B57;
	margin-bottom: 15px;
	padding-bottom: 10px;
	border-bottom: 2px solid #f0f0f0; 
	display: flex;
	align-items: center; 
}

.event-section h3::before {
	content: '◎';
	color: #FF7300; 
	font-size: 1.2rem;
	margin-right: 10px; 
	line-height: 1; 
}

.event-section ul {
	list-style: none; 
	padding-left: 10px; 
	margin: 0; 
}

.event-section li {
	margin-bottom: 10px; 
	color: #444; 
	font-size: 0.95rem; 
}

.event-section li strong {
	font-weight: 600; 
	min-width: 85px; 
	display: inline-block;
	color: #333; 
	margin-right: 5px; 
}


.event-section p {
	color: #444; 
	padding-left: 10px; 
	font-size: 0.95rem; 
}

.event-section p strong {
	color: #E65100; 
	font-weight: 600;
}


.event-section h4 { 
	margin-top: 25px;
	margin-bottom: 10px;
	font-size: 1.1rem;
	color: #555;
}

.winners-list {
	background-color: #fff8e1; 
	padding: 15px 20px;
	border-radius: 5px;
	border-left: 4px solid #FFC107; /* 왼쪽 강조선 */
	margin: 15px 0;
}

.winners-list span { 
	display: inline-block; 
	margin-right: 15px; 
	margin-bottom: 5px;
	background-color: #eee;
	padding: 3px 8px;
	border-radius: 4px;
	font-size: 0.9em;
	color: #444;
}

@media ( max-width : 600px) {
	.event-detail-container {
		padding: 20px;
		margin: 20px auto;
	}
	.event-detail-title {
		font-size: 1.8rem;
	}
	.event-section h3 {
		font-size: 1.25rem;
	}
	.event-section li, .event-section p {
		font-size: 0.9rem;
	}
	.event-section li strong {
		min-width: 70px; 
	}
}
</style>

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