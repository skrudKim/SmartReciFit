<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../part/header.jsp"%>


<style>
.paging { text-align: center; margin-top: 20px; }
.paging a, .paging span { display: inline-block; padding: 5px 10px; margin: 0 3px; border: 1px solid #ccc; text-decoration: none; color: #333; transition: background-color 0.3s ease, color 0.3s ease; }
/* .paging a.current 스타일은 기존 것 유지 (border-color 다름) */
.paging a.current { background-color: #2E8B57; color: white; border-color: #007bff; }
.paging a:hover { background-color: #3CB371; color: white; }
.paging span { color: #999; border-color: transparent; }

/* 전체 컨테이너 스타일 */
.review-detail {
    max-width: 900px; /* 목록보다 약간 좁게 */
    margin: 30px auto;
    padding: 30px;
    background-color: #fff;
    border: 1px solid #eee;
    border-radius: 8px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.05);
}

/* 제목 h1 */
.review-detail h1 {
    text-align: center;
    margin-top: 0; /* 위쪽 마진 제거 */
    margin-bottom: 20px;
    font-size: 1.8rem;
    color: #333;
    padding-bottom: 15px;
    border-bottom: 2px solid #eee;
}

/* 부가 정보 p 태그들 (글쓴이, 내용, 조회수, 좋아요, 작성일) - 선택자 주의! */
/* H1 바로 다음 p (글쓴이) */
.review-detail h1 + p {
    text-align: right;
    color: #666;
    font-size: 0.9em;
    margin-bottom: 5px; /* 간격 줄임 */
}
/* .image-slider 바로 다음 p (내용) - 슬라이더 없을 때 대비 필요 */
.review-detail .image-slider + p,
.review-detail h1 + p + p:not(:has(button.like-button)):not(:has(a)) { /* 슬라이더 없을 때 내용 p (추정) */
    color: #333;
    font-size: 1rem;
    line-height: 1.7;
    margin: 30px 0;
    min-height: 100px;
    text-align: left;
}
/* 조회수 p (내용 p 다음 p로 추정) */
.review-detail .image-slider + p + p,
.review-detail h1 + p + p + p:not(:has(button.like-button)) { /* 슬라이더 없을 때 조회수 p (추정) */
     text-align: right;
     color: #666;
     font-size: 0.9em;
     margin-bottom: 10px;
     margin-top: -20px; /* 내용 아래 간격 조정 */
}
/* 좋아요 p (button 포함한 p) */
.review-detail p:has(button.like-button) {
    text-align: center;
    margin: 30px 0;
    padding: 15px 0;
    border-top: 1px dashed #eee;
    border-bottom: 1px dashed #eee;
    font-size: 1.1em;
    color: #333;
}
.review-detail p:has(button.like-button) #like-count {
    font-weight: bold;
    margin-right: 8px;
}
/* 작성일 p (수정/삭제 div 바로 위 p) */
.review-detail .review-update-delete + p, /* 수정/삭제 버튼 없을 때 */
.review-detail div.review-update-delete ~ p { /* 수정/삭제 버튼 있을 때 그 뒤의 마지막 p*/
    text-align: right;
    color: #666;
    font-size: 0.9em;
    margin-top: 20px; /* 위 요소와 간격 */
    margin-bottom: 25px;
}
/* "후기 이미지가 없습니다" p */
.review-detail > p:not(:has(*)):not(.review-content-paragraph):not(.like-paragraph) { /* 내용이 텍스트 뿐인 p */
     text-align: center;
     color: #999;
     margin: 30px 0;
}

/* 이미지 슬라이더 */
.review-detail .image-slider {
    margin: 35px auto; /* 위아래 여백 약간 증가 */
    max-width: 700px; /* 너비 약간 증가 (선택 사항) */
    position: relative; /* 화살표/점 절대 위치의 기준점 */
    padding-bottom: 30px; /* 점 네비게이션 공간 확보 (아래 배치 시) */
}

.review-detail .slick-slide {
	margin: 0 10px;
    outline: none;
    /* 슬라이드 이미지에 부드러운 전환 효과 (선택 사항) */
    /* transition: transform 0.3s ease; */
}
/* 슬라이드에 마우스 올렸을 때 약간 확대 (선택 사항) */
/* .review-detail .slick-slide:hover {
    transform: scale(1.02);
} */

.review-detail .slick-slide img {
	width: 100%;
	border: none; /* 테두리 제거 (또는 더 얇게: 1px solid #f0f0f0;) */
    border-radius: 8px; /* 모서리 둥글게 */
    object-fit: cover;
    max-height: 450px; /* 최대 높이 조정 */
    display: block;
    margin: 0 auto;
    box-shadow: 0 5px 15px rgba(0,0,0,0.1); /* 그림자 효과 추가 */
}

/* 슬라이더 화살표 버튼 기본 스타일 */
.review-detail .slick-prev,
.review-detail .slick-next {
    font-size: 0; /* 기본 텍스트 숨김 */
    line-height: 0;
    position: absolute;
    top: 50%; /* 세로 중앙 정렬 */
    display: block;
    width: 40px; /* 버튼 크기 */
    height: 40px;
    padding: 0;
    transform: translateY(-50%);
    cursor: pointer;
    color: transparent; /* 기본 색상 숨김 */
    border: none;
    outline: none;
    background: rgba(255, 255, 255, 0.7); /* 반투명 배경 */
    border-radius: 50%; /* 원형 버튼 */
    z-index: 10; /* 이미지 위에 표시 */
    transition: background-color 0.3s ease, opacity 0.3s ease;
    opacity: 0.5; /* 평소엔 약간 투명하게 */
}
.review-detail .slick-prev:hover,
.review-detail .slick-next:hover {
    background: rgba(255, 255, 255, 0.9); /* 호버 시 더 불투명하게 */
    opacity: 1;
}

/* 화살표 버튼 위치 */
.review-detail .slick-prev { left: -15px; } /* 슬라이더 약간 바깥 왼쪽 */
.review-detail .slick-next { right: -15px; } /* 슬라이더 약간 바깥 오른쪽 */
/* 또는 안쪽 배치 시: */
/* .review-detail .slick-prev { left: 15px; } */
/* .review-detail .slick-next { right: 15px; } */


/* 화살표 아이콘 스타일 (기존 :before 활용) */
.review-detail .slick-prev:before,
.review-detail .slick-next:before {
    font-family: 'slick'; /* Slick 기본 폰트 사용 */
    font-size: 20px; /* 아이콘 크기 */
    line-height: 1;
    opacity: 0.8; /* 아이콘 투명도 */
    color: #333; /* 아이콘 색상 (어둡게) */
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    /* 버튼 중앙에 아이콘 배치 */
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}
/* 기본 아이콘 문자 사용 (폰트 로드 안될 경우 대비) */
/* .review-detail .slick-prev:before { content: '<'; }
.review-detail .slick-next:before { content: '>'; } */


/* 점 네비게이션 (Dots) 스타일 */
.review-detail .slick-dots {
    position: absolute;
    bottom: 10px; /* 슬라이더 하단 안쪽 위치 */
    display: block;
    width: 100%;
    padding: 0;
    margin: 0;
    list-style: none;
    text-align: center;
}
.review-detail .slick-dots li {
    position: relative;
    display: inline-block;
    width: 10px; /* 점 크기 */
    height: 10px;
    margin: 0 5px; /* 점 사이 간격 */
    padding: 0;
    cursor: pointer;
}
.review-detail .slick-dots li button {
    font-size: 0;
    line-height: 0;
    display: block;
    width: 10px; /* 버튼 영역 = 점 크기 */
    height: 10px;
    padding: 0; /* 내부 패딩 제거 */
    cursor: pointer;
    color: transparent;
    border: 0;
    outline: none;
    background: transparent; /* 버튼 배경 투명 */
}
/* 점 모양 스타일 */
.review-detail .slick-dots li button:before {
    font-family: 'slick'; /* slick 폰트 미사용 */
    content: ''; /* 내용 없음 */
    display: block;
    width: 8px; /* 실제 점 크기 */
    height: 8px;
    border-radius: 50%; /* 원형 */
    background: #ccc; /* 비활성 점 색상 */
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    transition: background-color 0.3s ease;
    opacity: 0.7;
}
/* 활성 상태 점 */
.review-detail .slick-dots li.slick-active button:before {
    background: #2E8B57; /* 활성 점 색상 (목록 페이지와 통일) */
    opacity: 1;
}
/* 점 호버 시 */
.review-detail .slick-dots li:hover button:before {
    background: #a0a0a0; /* 호버 시 색상 */
}
/* 좋아요 버튼 */
.like-button {
	background: none;
	border: none;
	padding: 0;
	font-size: 1.5rem;
	cursor: pointer;
    vertical-align: middle;
    transition: transform 0.2s ease;
    color: initial; /* 기본 색상 지정 (원래 빨간색 제거) */
}
.like-button:hover { transform: scale(1.2); }
/* 좋아요 상태 색상은 JSP에서 직접 아이콘으로 제어 */


/* 참고 레시피 h3 */
.review-detail h3 {
    margin-top: 30px;
    margin-bottom: 10px;
    font-size: 1.3rem;
    color: #333;
    border-bottom: 1px solid #f0f0f0;
    padding-bottom: 8px;
    text-align: left;
}
/* 참고 레시피 링크 a (h3 다음 a) */
.review-detail h3 + a {
    color: #2E8B57;
    text-decoration: none;
    font-weight: bold;
    font-size: 1rem;
    display: block; /* 링크 영역 확보 및 마진 적용 */
    margin-bottom: 15px;
}
.review-detail h3 + a:hover { text-decoration: underline; }
/* 참고 레시피 없는 p (h3 다음 p) */
.review-detail h3 + p {
     font-size: 1rem;
     color: #666;
     margin-bottom: 15px;
}


/* 수정/삭제 버튼 영역 div.review-update-delete */
.review-detail .review-update-delete {
    text-align: right;
    margin-top: 20px;
    margin-bottom: 30px;
    padding-top: 15px;
    border-top: 1px solid #eee;
}
/* 수정하기 버튼 (div 안 첫번째 버튼) */
.review-detail .review-update-delete button:first-of-type {
    padding: 8px 15px;
    background-color: #FFCD50;
    color: #333;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 0.9rem;
    margin-left: 10px;
}
.review-detail .review-update-delete button:first-of-type:hover { background-color: #fdd674; 
}
/* 삭제하기 버튼 (div 안 마지막 버튼) */
.review-detail .review-update-delete button:last-of-type {
    padding: 8px 15px;
    background-color: #777777;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 0.9rem;
    margin-left: 10px;
}
.review-detail .review-update-delete button:last-of-type:hover { background-color: #5a6268; }

/* 댓글 h3 */
/* 기존 h3 스타일 재사용 */

/* 댓글 폼 div.comment-form */
.review-detail .comment-form {
    margin-top: 20px;
    margin-bottom: 30px; /* 댓글 목록과의 간격 */
    display: flex; /* 자식 요소들을 가로로 배치 */
    align-items: stretch; /* 자식 요소들의 높이를 같게 늘림 */
    gap: 10px; /* 요소들 사이의 기본 간격 */
}

/* 댓글 폼 form (textarea + 작성 버튼 포함) */
.review-detail .comment-form form {
    flex-grow: 1; /* 남는 공간을 최대한 차지 */
    display: flex; /* textarea와 작성 버튼을 가로로 배치 */
    margin-bottom: 0; /* form 자체의 하단 마진 제거 */
    gap: 0; /* 내부 요소 간격은 0으로 하고 개별 마진/패딩 사용 */
}

/* 댓글 textarea */
.review-detail .comment-form textarea {
    flex-grow: 1; /* form 내에서 남는 공간 차지 */
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px 0 0 4px; /* 오른쪽 모서리 각지게 */
    resize: none; /* 크기 조절 불가 (기존 스타일 유지) */
    min-height: 80px; /* 최소 높이 지정 (버튼 높이와 맞춤) */
    font-size: 0.95rem;
    margin-bottom: 0; /* 하단 마진 제거 */
    box-sizing: border-box;
    /* 인라인 스타일 height, width 제거됨 (flex-grow로 대체) */
    /* 인라인 스타일 resize:none 유지 */
    border-right: none; /* 작성 버튼과 테두리 합침 */
}

/* 댓글 작성 버튼 */
.review-detail .comment-form button[type="submit"] {
    padding: 8px 15px;
    background-color: #2E8B57;
    color: white;
    border: 1px solid #2E8B57; /* 테두리 추가 */
    border-radius: 0 4px 4px 0; /* 왼쪽 모서리 각지게 */
    cursor: pointer;
    font-size: 0.95rem;
    /* 높이는 align-items: stretch 로 자동 조절됨 */
    white-space: nowrap; /* 버튼 이름 줄바꿈 방지 */
    margin-left: -1px; /* 테두리 겹침 조정 */
}
.review-detail .comment-form button[type="submit"]:hover {
    background-color: #3CB371;
}

/* 목록 버튼 (기존 클래스 활용) */
.review-detail .review-list-btn {
    padding: 8px 15px;
    background-color: #777777;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 0.95rem;
    white-space: nowrap; /* 버튼 이름 줄바꿈 방지 */
}
.review-detail .review-list-btn:hover {
    background-color: #5a6268;
}

/* 댓글 목록 */
.review-detail .comment-list {
	margin-top: 30px; /* 댓글 폼 영역과의 간격 확보 */
    border-top: 2px solid #333;
}
/* 댓글 아이템 div.comment-item */
.review-detail .comment-item {
	border-bottom: 1px solid #eee;
	padding: 15px 0;
}
/* 댓글 내용 div.comment-div */
.review-detail .comment-item .comment-div {
    margin-bottom: 8px;
    font-size: 1rem;
    line-height: 1.5;
    color: #333;
}
/* 댓글 정보 small */
.review-detail .comment-item small {
    color: #666;
    font-size: 0.85em;
    display: block;
    margin-bottom: 8px;
}
/* 댓글 수정 버튼 (button.comment-btn) */
.review-detail .comment-item button.comment-btn {
    padding: 5px 10px;
    background-color: #f8f9fa;
    color: #333;
    border: 1px solid #ccc;
    border-radius: 4px;
    cursor: pointer;
    font-size: 0.85rem;
    margin-right: 5px;
}
.review-detail .comment-item button.comment-btn:hover { background-color: #e2e6ea; }
/* 댓글 삭제 버튼 (form 안의 버튼) */
.review-detail .comment-item form { display: inline; }
.review-detail .comment-item form button {
    padding: 5px 10px;
    background-color: #f8f9fa; /* 일단 동일 스타일 */
    color: #333;
    border: 1px solid #ccc;
    border-radius: 4px;
    cursor: pointer;
    font-size: 0.85rem;
}
.review-detail .comment-item form button:hover { background-color: #e9ecef; }

/* 댓글 수정 폼 (JS로 제어) */
.comment-edit-form { margin-top: 10px; }
.comment-edit-form textarea {
    width: calc(100% - 180px); /* 버튼들 너비 고려 조정 */
    min-height: 60px;
    resize: vertical;
    border: 1px solid #ccc;
    padding: 8px;
    margin-right: 10px;
    vertical-align: top;
}
.comment-edit-form button {
    padding: 5px 10px;
    background-color: #f8f9fa;
    color: #333;
    border: 1px solid #ccc;
    border-radius: 4px;
    cursor: pointer;
    font-size: 0.85rem;
    margin-right: 5px;
    vertical-align: top;
}
/* 수정완료 버튼 */
.comment-edit-form button[type="submit"] { background-color: #28a745; color: white; border-color: #28a745; }
.comment-edit-form button[type="submit"]:hover { background-color: #218838; }
/* 취소 버튼 */
.comment-edit-form button[type="button"] { background-color: #6c757d; color: white; border-color: #6c757d; }
.comment-edit-form button[type="button"]:hover { background-color: #5a6268; }

</style>

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