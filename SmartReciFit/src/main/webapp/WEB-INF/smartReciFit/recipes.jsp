<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../part/header.jsp"%>
<style>

/* ----- 필터 섹션 (수정됨) ----- */
.recipe-filter {
	background-color: #fff;
	width: 80%;
	padding: 20px; /* 컬럼 간 간격은 grid gap으로 처리, 내부 여백 유지 */
	margin: 0 auto 30px auto; /* 위쪽 margin 제거, 아래쪽 유지 */
	border-radius: 8px;
	box-shadow: 0 1px 4px rgba(0, 0, 0, 0.08);
	/* === Grid Layout으로 변경 === */
	display: grid;
	grid-template-columns: repeat(4, 1fr); /* 4개의 동일한 너비 컬럼 생성 */
	gap: 25px; /* 컬럼 사이의 간격 */
	position: relative;
}

/* --- 기존 .filter-container 스타일 제거 또는 주석 처리 --- */
/*
.filter-container {
	display: flex;
	flex-wrap: wrap;
	gap: 10px;
	margin-bottom: 15px;
	padding-bottom: 15px;
	border-bottom: 1px solid #eee;
}
.filter-container:last-child {
	margin-bottom: 0;
	padding-bottom: 0;
	border-bottom: none;
}
*/

/* ----- 새 필터 컬럼 스타일 ----- */
.filter-column {
	/* 컬럼 자체에 대한 추가 스타일링 가능 (예: 배경, 테두리) */
	/* border-right: 1px solid #eee; 컬럼 구분선 (선택 사항) */
	/* padding: 10px; 컬럼 내부 여백 (선택 사항) */
	
}
/* .filter-column:last-child {
    border-right: none; 마지막 컬럼 구분선 제거
} */

/* 컬럼 제목 스타일 (선택 사항 - HTML의 h3에 적용) */
.filter-column-title {
	font-size: 1rem; /* 0.9rem 또는 원하는 크기 */
	color: #333;
	font-weight: 600;
	margin-bottom: 12px; /* 제목과 버튼 그룹 사이 간격 */
	/* padding-left: 5px; 약간의 들여쓰기 (선택 사항) */
}

/* ----- 필터 버튼들을 감싸는 컨테이너 (수정됨) ----- */
/* 이 클래스는 각 컬럼 내에서 버튼들의 레이아웃을 담당합니다. */
.filter-items {
	display: flex;
	flex-wrap: wrap; /* 버튼이 많으면 자동으로 줄바꿈 */
	gap: 8px 10px; /* 버튼 사이 간격 (세로 8px, 가로 10px) */
	/* justify-content: space-between; */ /* 버튼이 2개일 때 양쪽 정렬 (선택 사항) */
	align-items: flex-start; /* 버튼 높이가 다를 경우 상단 정렬 */
}

/* ----- 필터 버튼 (기존 스타일 유지) ----- */
.recipe-filter input[type="checkbox"] {
	position: absolute;
	opacity: 0;
	cursor: pointer;
	height: 0;
	width: 0;
}

.recipe-filter label {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	padding: 7px 12px; /* 내부 여백 약간 조정 (선택 사항) */
	/* width: calc(50% - 5px); */ /* 중요: 한 줄에 2개씩 강제 배치 (가로 gap 고려) */
	/* min-width 제거 또는 조정 */
	height: 32px; /* 높이 약간 조정 (선택 사항) */
	border: 1px solid #ccc;
	border-radius: 16px; /* 높이의 절반 */
	font-size: 0.85rem; /* 폰트 크기 약간 작게 (선택 사항) */
	color: #555;
	background-color: #fff;
	cursor: pointer;
	transition: all 0.2s ease-in-out;
	user-select: none;
	text-align: center; /* 내부 텍스트 가운데 정렬 */
	flex-grow: 1; /* 남는 공간을 채우도록 함 (선택 사항) */
	/* 한 줄에 정확히 2개를 맞추려면 width를 calc()로 계산해야 할 수 있습니다. */
	/* 예: width: calc(50% - (gap / 2)); 가로 gap이 10px이면 width: calc(50% - 5px); */
	/* 하지만 flex-wrap과 함께 사용하면 자연스럽게 배치될 수도 있습니다. */
	margin-bottom: 10px;
}

/* 버튼 너비를 자동으로 하되, 한 줄에 두 개 정도 들어가도록 유도 */
.recipe-filter label {
	/* ... 기존 스타일 ... */
	flex-basis: calc(50% - 10px); /* 기본 너비를 50%에서 gap 절반 뺀 값으로 시도 */
	flex-grow: 0; /* 더 이상 늘어나지 않게 */
	min-width: 80px; /* 너무 작아지는 것 방지 */
	box-sizing: border-box; /* 패딩/테두리 포함해서 너비 계산 */
}

.recipe-filter label:hover {
	background-color: #e9f5ff;
	border-color: #a0d3f0;
	color: #1a7dbe;
}

.recipe-filter input[type="checkbox"]:checked+label {
	background-color: #2196F3;
	color: #fff;
	border-color: #1a7dbe;
	font-weight: 500;
}

.recipe-search {
	grid-column: 3/span 2; /* 1번 열부터 시작하여 3칸을 차지 */
	padding: 10px; /* 검색창의 패딩 */
	background-color: #f0f0f0; /* 검색창의 배경색 */
	border: 1px solid #ddd; /* 검색창의 테두리 */
	position: absolute;
	top: 120px;
	right: 200px;
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

#searchResults {
	display: flex; /* Arrange cards horizontally */
	flex-wrap: wrap; /* Allow cards to wrap to the next line */
	gap: 15px; /* Space between cards */
	width: 80%;
	justify-content: space-between;
	/* Center the cards if they don't fill the row */
	padding: 20px; /* Padding around the group of cards */
	margin: auto;
}

/* ----- Individual Search Result Card (Small Recipe Card Style) ----- */
.search-result {
	display: flex;
	flex-direction: column; /* Stack image and title vertically */
	align-items: center; /* Center content horizontally */
	width: 100px; /* << --- SETTING THE CARD WIDTH */
	background-color: #fff;
	border-radius: 8px; /* Slightly smaller radius for small card */
	box-shadow: 0 1px 4px rgba(0, 0, 0, 0.1); /* Slightly smaller shadow */
	overflow: hidden; /* Important for image bounds and border-radius */
	transition: transform 0.2s ease, box-shadow 0.2s ease;
	cursor: pointer;
	padding-bottom: 8px; /* Space below the title */
}

.search-result:hover {
	/* transform: translateY(-3px); */ /* Subtle lift effect */
	box-shadow: 0 3px 8px rgba(0, 0, 0, 0.15);
	/* Enhanced shadow on hover */
}

/* Search Result Image */
.search-result img {
	display: block; /* Remove extra space below image */
	width: 100%; /* Make image fill the card width */
	height: 100px; /* Make image square (same as width) */
	/* aspect-ratio: 1 / 1; /* Alternative: maintain 1:1 ratio */
	object-fit: cover; /* Cover the area, cropping if needed */
	/* border-radius: 0; Removed: parent overflow:hidden handles corners */
	margin-bottom: 8px; /* Space between image and title */
	transition: transform 0.3s ease;
	/* Override inline width/height if necessary (though CSS usually wins) */
	/* height: auto; */ /* Let object-fit and height handle it */
}

.search-result:hover img {
	transform: scale(1.05); /* Slightly zoom image on hover */
}

/* Search Result Title */
.search-result-title {
	font-weight: 600;
	font-size: 0.75rem; /* Smaller font size for the small card */
	color: #333;
	text-align: center;
	padding: 0 5px; /* Small horizontal padding */
	line-height: 1.3; /* Adjust line height for small text */
	/* Optional: Ellipsis for long text (single line) */
	/* white-space: nowrap; */
	/* overflow: hidden; */
	/* text-overflow: ellipsis; */
	/* Optional: Ellipsis for long text (multi-line, requires careful height setting) */
	/* max-height: 2.6em; */ /* Approx 2 lines (line-height * 2) */
	/* overflow: hidden; */
}
</style>
<script src="${ctx}/js/recipe/searchRecipe.js"></script>
<input class="offset" type="hidden" value="${offset }">

<div class="recipe-filter">
	<div class="filter-container">
		<c:forEach var="ingredient" items="${tagIngredient}">
			<input type="checkbox" class="ingredient"
				id="ingredient-${ingredient }" name="ingredient"
				value="${ingredient}">
			<label for="ingredient-${ingredient }">${ingredient }</label>
		</c:forEach>
	</div>
	<div class="filter-container">
		<c:forEach var="cookingMethod" items="${tagCookingMethod}">
			<input type="checkbox" class="cooking-method"
				id="cooking-method-${cookingMethod }" name="cooking-method"
				value="${cookingMethod}">
			<label for="cooking-method-${cookingMethod }">${cookingMethod }</label>
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

	</div>
	<div class="recipe-search">
		<input type="text" id="keyword" placeholder="레시피 검색"
			class="search-input" required onkeyup="searchRecipes()">
	</div>
</div>
<div id="searchResults" class="search-results"></div>
<div class="recipe-container"></div>

<script src="${ctx}/js/recipe/recipes.js"></script>
<%@ include file="../../part/footer.jsp"%>