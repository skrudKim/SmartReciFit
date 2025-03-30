<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../part/header.jsp"%>

<link rel="stylesheet" type="text/css" href="${ctx}/css/reviewDetail.css">

<div class="review-detail">
	<h1>${review.reviewBoardTitle}</h1>
	<p>글쓴이: ${userNickname}</p>

	<!-- 이미지 슬라이더 -->
	<c:if test="${not empty imagePaths}">
		<div class="image-slider">
			<c:forEach var="imagePath" items="${imagePaths}">
				<div>
					<img src="${ctx}/img/${imagePath}" alt="${review.reviewBoardTitle}">
				</div>
			</c:forEach>
		</div>
	</c:if>
	<c:if test="${empty imagePaths}">
		<p>후기 이미지가 없습니다.</p>
	</c:if>

	<p>내용: ${review.reviewBoardContent}</p>
	<p>조회수: ${review.reviewBoardViews}</p>
	<p>
		좋아요: <span id="like-count"> ${totalLikes} </span>
		<button class="like-button"
			onclick="toggleLike(${review.reviewBoardNum})">
			<c:choose>
				<c:when test="${liked}">
                    ❤️
                </c:when>
				<c:otherwise>
                    🤍
                </c:otherwise>
			</c:choose>
		</button>
	</p>
	<c:if test="${recipe == null}">
		<h3>참고 레시피</h3>
		<p>참고한 레시피가 없습니다</p>
	</c:if>
	<c:if test="${recipe != null}">
		<c:if test="${recipe.recipeNum != 0}">
			<h3>참고 레시피</h3>
			<a href="${ctx}/recipeContent.do?rn=${recipe.recipeNum}">
				${recipe.recipeName}
			</a>
		</c:if>
	</c:if>

	<p>작성일: ${review.reviewBoardCreated}</p>
	<c:if test="${review.userNum == userNum or userNum eq 1}">
		<div class="review-update-delete">
			<button
				onclick="location.href='${ctx}/reviewUpdate.do?reviewBoardNum=${review.reviewBoardNum}&userNickname=${userNickname}'">수정하기</button>
			<button
				onclick="location.href='${ctx}/reviewDelete.do?reviewBoardNum=${review.reviewBoardNum}'">삭제하기</button>
		</div>
	</c:if>
	<h3>댓글</h3>
	<div class="comment-form">
		<form action="${ctx}/commentAdd.do" method="post">
			<input type="hidden" name="userNickname" value="${userNickname}">
			<input type="hidden" name="boardNum" value="${review.reviewBoardNum}">
			<textarea name="commentContent" placeholder="댓글을 입력하세요" required
				style="height: 100px; width: 610px; resize: none"></textarea>
			<button type="submit">댓글 작성</button>
		</form>
		<button class="review-list-btn"
			onclick="location.href='${ctx}/reviews.do?page=1'">목록</button>
	</div>

	<div class="comment-list">
		<c:forEach var="comment" items="${comments}">
			<div class="comment-item" id="comment-item-${comment.commentNum}">
				<div class="comment-div" id="comment-div-${comment.commentNum}">${comment.commentContent}</div>
				<small>작성자: ${comment.userNickname}, 작성일:
					${comment.commentCreated}</small>
				<c:if test="${userNum eq comment.userNum or userNum eq 1}">
					<button class="comment-btn" id="comment-btn-${comment.commentNum}"
						onclick="showEdit(${comment.commentNum}, ${review.reviewBoardNum})">수정</button>
					<form action="${ctx}/commentDelete.do" method="post"
						style="display: inline;">
						<input type="hidden" name="commentNum"
							value="${comment.commentNum}"> <input type="hidden"
							name="boardNum" value="${review.reviewBoardNum}"> <input
							type="hidden" name="userNickname" value="${userNickname}">
						<button type="submit">삭제</button>
					</form>
				</c:if>
			</div>
		</c:forEach>
	</div>
	<div class="paging">
		<c:if test="${commentPage > 1}">
			<a
				href="${ctx}/reviewDetail.do?reviewBoardNum=${review.reviewBoardNum}&userNickname=${userNickname}&commentPage=${commentPage - 1}"><
				이전</a>
		</c:if>
		<c:if test="${commentPage <= 1}">
			<span>< 이전</span>
		</c:if>
		<c:forEach var="i" begin="${startPage}" end="${endPage}">
			<c:choose>
				<c:when test="${i == commentPage}">
					<a class="current"
						href="${ctx}/reviewDetail.do?reviewBoardNum=${review.reviewBoardNum}&userNickname=${userNickname}&commentPage=${i}">${i}</a>
				</c:when>
				<c:otherwise>
					<a
						href="${ctx}/reviewDetail.do?reviewBoardNum=${review.reviewBoardNum}&userNickname=${userNickname}&commentPage=${i}">${i}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:if test="${commentPage < totalCommentPages}">
			<a
				href="${ctx}/reviewDetail.do?reviewBoardNum=${review.reviewBoardNum}&userNickname=${userNickname}&commentPage=${commentPage + 1}">다음
				></a>
		</c:if>
		<c:if test="${commentPage >= totalCommentPages}">
			<span>다음 ></span>
		</c:if>
	</div>
</div>

<script src="${ctx}/js/board/slider.js"></script>
<script src="${ctx}/js/board/comment.js"></script>
<%@ include file="../../part/footer.jsp"%>