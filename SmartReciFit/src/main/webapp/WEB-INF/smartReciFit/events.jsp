<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../part/header.jsp"%>
<style>
.event-main {
    max-width: 900px; 
    margin: 40px auto; 
    padding: 0 15px;
}

.event-main h2 {
    text-align: center;
    font-size: 1.8rem;
    font-weight: 600;
    color: #333;
    margin-bottom: 35px;
    padding-bottom: 15px;
    border-bottom: 2px solid #eee; 
}

.event-list {
  
}


.event-item {
    display: flex; 
    border: 1px solid #ddd; 
    margin-bottom: 25px; 
    background-color: #fff; 
    border-radius: 8px; 
    overflow: hidden; 
    text-decoration: none;
    color: inherit; 
    transition: box-shadow 0.3s ease; 
}

.event-item:hover {
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1); 
}


.event-info {
    flex-basis: 220px;
    flex-shrink: 0; 
    background-color: #FFF3C2; 
    padding: 20px;
    display: flex;
    flex-direction: column;
    justify-content: center; 
    border-right: 1px solid #eee; 
}

.event-title {
    font-size: 1.15rem; 
    font-weight: 600;
    color: #333;
    margin: 0 0 8px 0; 
}

.event-date {
    font-size: 0.9rem; 
    color: #555; 
    margin: 0;
}

.event-image-placeholder {
    flex-grow: 1; 
    display: flex; 
    align-items: center;
    justify-content: center;
    min-height: 160px; 
    background-color: #f8f8f8;
    color: #bbb; 
    font-size: 1rem;
}

.event-image-placeholder img {
    display: block; 
    width: 100%;
    height: 100%;
    object-fit: cover; 
}




</style>

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