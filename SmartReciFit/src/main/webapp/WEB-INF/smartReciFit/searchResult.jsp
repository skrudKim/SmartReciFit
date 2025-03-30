<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../part/header.jsp"%>
<link rel="stylesheet" type="text/css" href="${ctx}/css/searchResult.css">


<div class="review-list">
    <h2>검색 결과</h2>
    <c:if test="${not empty searchResults}">
        <table>
            <thead>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>글쓴이</th>
                    <th>등록일</th>
                    <th>조회</th>
                    <th>좋아요</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="review" items="${searchResults}">
                    <tr>
                        <td>${review.review_board_num}</td>
                        <td>
                        <c:if test="${not empty review.review_board_img}">
                        	<span class="image-icon" title="이미지 있음">🖼️</span>
                        </c:if>

                        <a 
                        	href="${ctx}/reviewDetail.do?reviewBoardNum=${review.review_board_num}&user=${user}&userNickname=${review.user_nickname}" class="review-title-link"
                        	data-img-src="${not empty review.review_board_img ? review.review_board_img : ''}">
                        	${review.review_board_title}
                        	</a>
                        	<c:if test="${review.comment_count > 0}">
							<span class="comment-count">[${review.comment_count}]</span>
							</c:if>
                        </td>
                        <td>${review.user_nickname}</td>
                        <td>${review.review_board_created_at}</td>
                        <td>${review.review_board_views}</td>
                        <td>${review.review_board_likes}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
    <c:if test="${empty searchResults}">
        <p>검색 결과가 없습니다.</p>
    </c:if>
   
	
	</div>
       	<div class="action-buttons-area">
		<c:if test="${not empty user}">
           <button type="button" class="review-write"
               onclick="location.href='${ctx}/reviewWrite.do?user=${user}'">글쓰기</button>
 		  </c:if>
       <button class="list-btn" onclick="location.href='${ctx}/reviews.do?page=1'">목록</button>
       </div>

	
	
	<div class="paging">
		<c:if test="${page > 1}">
			<a href="${ctx}/searchReviewBoard.do?searchName=${searchName}&keyword=${keyword}&page=${page - 1}">< 이전</a>
		</c:if>
		<c:if test="${page <= 1}">
			<span>< 이전</span>
		</c:if>
		 <c:forEach var="i" begin="${startPage}" end="${endPage}">
        <c:choose>
            <c:when test="${i == page}">
                <a class="current" href="${ctx}/searchReviewBoard.do?searchName=${searchName}&keyword=${keyword}&page=${i}">${i}</a>
            </c:when>
            <c:otherwise>
                <a href="${ctx}/searchReviewBoard.do?searchName=${searchName}&keyword=${keyword}&page=${i}">${i}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>
		<c:if test="${page < totalPages}">
			<a href="${ctx}/searchReviewBoard.do?searchName=${searchName}&keyword=${keyword}&page=${page + 1}">다음 ></a>
		</c:if>
		<c:if test="${page >= totalPages}">
			<span>다음 ></span>
		</c:if>
	</div>
<div class="search-area">
    <form action="${ctx}/searchReviewBoard.do" method="post">
        <select name="searchName">
            <option value="title" ${searchName == 'title' ? 'selected' : ''}>제목</option>
            <option value="titleAndContent" ${searchName == 'titleAndContent' ? 'selected' : ''}>제목+내용</option>
        </select>
        <input type="text" name="keyword" class="search-area-input" value="${keyword}">
        <button type="submit" class="search-btn">검색</button>
    </form>
</div>
</div>
<div id="image-preview-popup">
    <img id="preview-image" src="" alt="미리보기">
</div>
<script src="${ctx}/js/board/previewImage.js"></script>
<%@ include file="../../part/footer.jsp"%>