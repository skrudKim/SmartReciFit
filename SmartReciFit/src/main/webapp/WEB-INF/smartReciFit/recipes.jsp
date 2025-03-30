<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../part/header.jsp"%>
<style>

/* ----- 필터 섹션 ----- */
.recipe-filter {
	background-color: #fff;
	width: 80%;
	/* 필터 영역 배경색 */
	padding: 20px;
	margin-bottom: 30px;
	/* 필터와 레시피 목록 사이 간격 */
	border-radius: 8px;
	box-shadow: 0 1px 4px rgba(0, 0, 0, 0.08);
	/* 은은한 그림자 */
	margin: auto;
	margin-bottom: 20px;
}

.filter-container {
	display: flex;
	flex-wrap: wrap;
	/* 항목이 많으면 자동으로 줄바꿈 */
	gap: 10px;
	/* 필터 버튼 사이의 간격 (가로, 세로 모두 적용) */
	margin-bottom: 15px;
	/* 필터 그룹 간의 간격 */
	padding-bottom: 15px;
	/* 그룹 하단 여백 */
	border-bottom: 1px solid #eee;
	/* 그룹 구분선 */
}

.filter-container:last-child {
	margin-bottom: 0;
	/* 마지막 그룹 아래 여백 제거 */
	padding-bottom: 0;
	border-bottom: none;
	/* 마지막 그룹 구분선 제거 */
}

/* 필터 그룹 제목 (선택적 - HTML에 추가 필요)
.filter-container h3 {
  width: 100%;
  margin-bottom: 10px;
  font-size: 1rem;
  color: #555;
} */
.recipe-filter input[type="checkbox"] {
	/* 기존 스타일 유지 - 화면에서 숨김 */
	position: absolute;
	opacity: 0;
	cursor: pointer;
	height: 0;
	width: 0;
}

.recipe-filter label {
	display: inline-flex;
	/* 내용을 가운데 정렬하면서 inline 요소처럼 배치 */
	align-items: center;
	justify-content: center;
	padding: 8px 15px;
	/* 내부 여백 (너비 대신 사용) */
	min-width: 80px;
	/* 최소 너비 보장 (선택 사항) */
	height: 34px;
	/* 높이 */
	border: 1px solid #ccc;
	/* 테두리 색상 약간 연하게 */
	border-radius: 17px;
	/* 높이의 절반으로 완전한 캡슐 형태 */
	font-size: 0.9rem;
	/* 폰트 크기 약간 작게 */
	color: #555;
	/* 기본 글자색 */
	background-color: #fff;
	/* 기본 배경색 */
	cursor: pointer;
	transition: all 0.2s ease-in-out;
	/* 부드러운 전환 효과 */
	user-select: none;
	/* 텍스트 선택 방지 */
}

.recipe-filter label:hover {
	background-color: #e9f5ff;
	/* 호버 시 배경색 (은은하게) */
	border-color: #a0d3f0;
	/* 호버 시 테두리 색 */
	color: #1a7dbe;
	/* 호버 시 글자색 */
}

.recipe-filter input[type="checkbox"]:checked+label {
	background-color: #2196F3;
	/* 체크 시 배경색 */
	color: #fff;
	/* 체크 시 글자색 */
	border-color: #1a7dbe;
	/* 체크 시 테두리 색 */
	font-weight: 500;
	/* 약간 굵게 (선택 사항) */
}

/* ----- 레시피 목록 컨테이너 ----- */
.recipe-container {
	display: grid;
	width: 80%;
	/* 반응형 그리드: 화면 너비에 따라 자동으로 컬럼 수 조절 */
	grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
	gap: 25px;
	margin: auto;
	/* 그리드 아이템 사이의 간격 */
	/* justify-self: center; 는 grid 아이템에 적용하는 속성입니다. */
	/* 컨테이너 자체를 가운데 정렬하려면 max-width와 margin: auto를 사용해야 할 수 있습니다. */
	/* 예: max-width: 1200px; margin: 0 auto; */
}

/* ----- 개별 레시피 카드 ----- */
.recipe {
	display: flex;
	flex-direction: column;
	align-items: center;
	/* 내용물(이미지, 텍스트) 중앙 정렬 */
	background-color: #fff;
	/* 카드 배경색 */
	border-radius: 10px;
	/* 카드 모서리 둥글게 */
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
	/* 카드 그림자 */
	overflow: hidden;
	/* 이미지 넘침 방지 및 border-radius 적용 */
	transition: transform 0.2s ease, box-shadow 0.2s ease;
	/* 호버 효과를 위한 전환 */
	cursor: pointer;
	/* 클릭 가능함을 암시 */
	padding-bottom: 15px;
	/* 카드 하단 여백 (텍스트용) */
}

.recipe:hover {
	/* transform: translateY(-5px); */
	/* 위로 살짝 떠오르는 효과 */
	box-shadow: 0 5px 12px rgba(0, 0, 0, 0.15);
	/* 그림자 강조 */
}

/* 레시피 이미지 영역 */
.recipe-img {
	/* margin: 10px; 제거 -> grid gap으로 처리 */
	width: 115%;
	/* height: 300px; 고정 높이 대신 비율 사용 */
	aspect-ratio: 1/1;
	/* 1:1 비율 유지 (정사각형), 최신 브라우저 지원 */
	/* position: relative; padding-bottom: 100%; height: 0; overflow: hidden; */
	border-radius: 0;
	/* 상단 모서리는 .recipe에서 처리, 여기선 필요 없음 */
	box-shadow: none;
	/* 그림자는 .recipe에서 처리 */
	overflow: hidden;
	/* 내부 이미지 넘침 방지 */
	margin-bottom: 10px;
	/* 이미지와 텍스트 사이 간격 */
}

.recipe img {
	display: block;
	/* 이미지 하단 여백 제거 */
	width: 100%;
	height: 100%;
	object-fit: cover;
	/* 중요: 이미지가 비율 유지하며 영역을 채우도록 함 (잘릴 수 있음) */
	/* border-radius: 10px; 제거 -> .recipe에서 overflow:hidden으로 처리 */
	transition: transform 0.3s ease;
	/* 확대/축소 효과 시간 조정 */
	/* HTML에서 width/height 속성 제거 권장 (CSS로 제어) */
}

/* 이미지 호버 효과는 기존 유지 */
.recipe:hover img {
	/* .recipe 전체에 호버했을 때 이미지 확대 */
	transform: scale(1.05);
	/* 약간만 확대 */
}

/* 레시피 이름 스타일링 (HTML 수정 필요) */
/* HTML에서 레시피 이름을 <div> 또는 <span>으로 감싸고 클래스(예: recipe-name) 부여 권장 */
.recipe-name {
	/* 이 클래스를 HTML에 추가했다고 가정 */
	font-weight: 600;
	/* 굵기 */
	font-size: 1rem;
	color: #333;
	padding: 0 15px;
	/* 좌우 여백 */
	text-align: center;
	/* 여러 줄 처리 (선택 사항) */
	/* display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
  text-overflow: ellipsis; */
}

/* 만약 HTML 수정 없이 현재 구조 그대로 사용한다면 (덜 이상적) */
.recipe {
	/* 기존 align-items: center 유지 */
	font-weight: 600;
	font-size: 1rem;
	color: #333;
	padding: 0 15px 15px 15px;
	/* 이미지 아래 텍스트 영역 확보 */
	text-align: center;
}

.recipe>.recipe-img+* {
	/* 이미지 바로 뒤에 오는 텍스트 노드 (완벽하지 않음) */
	margin-top: 10px;
}
</style>
<input class="offset" type="hidden" value="${offset }">

<div class="recipe-filter">
	<div class="filter-container">
		<c:forEach var="cookingMethod" items="${tagCookingMethod}">
			<input type="checkbox" class="cooking-method"
				id="cooking-method-${cookingMethod }" name="cooking-method"
				value="${cookingMethod}">
			<label for="cooking-method-${cookingMethod }">${cookingMethod }</label>
		</c:forEach>
	</div>
	<div class="filter-container">
		<c:forEach var="ingredient" items="${tagIngredient}">
			<input type="checkbox" class="ingredient"
				id="ingredient-${ingredient }" name="ingredient"
				value="${ingredient}">
			<label for="ingredient-${ingredient }">${ingredient }</label>
		</c:forEach>
	</div>
	<div class="filter-container">
		<c:forEach var="eatTime" items="${tagEatTime}">
			<input type="checkbox" class="eat-time" id="eat-time-${eatTime }"
				name="eat-time" value="${eatTime}">
			<label for="eat-time-${eatTime }">${eatTime }</label>
		</c:forEach>
	</div>
	<div class="filter-container">
		<c:forEach var="cookingStyle" items="${tagCookingStyle}">
			<input type="checkbox" class="ingredient"
				id="cookingStyle-${cookingStyle }" name="cookingStyle"
				value="${cookingStyle}">
			<label for="cookingStyle-${cookingStyle }">${cookingStyle }</label>
		</c:forEach>
		<div class="recipe-search">
			<input type="text" id="keyword" placeholder="레시피 검색"
				class="search-input" required onkeyup="searchRecipes()">
		</div>
	</div>
</div>
<div id="searchResults" class="search-results"></div>
<div class="recipe-container">
	<%-- <c:forEach var="recipe" items="${recipeList }">
		<div class="recipe ${recipe.recipeNum }">
			<div class="recipe-img">
				<a href="${ctx }/recipeContent.do?rn=${recipe.recipeNum }"> <img
					class="img ${recipe.recipeNum }" src="${recipe.recipeThumbnail }"
					alt="" width="300px" height="300px">
				</a>
			</div>
			${recipe.recipeName}
		</div>
	</c:forEach> --%>
</div>
<script src="${ctx}/js/board/searchRecipe.js"></script>
<script src="${ctx}/js/recipe/recipes.js"></script>
<%@ include file="../../part/footer.jsp"%>