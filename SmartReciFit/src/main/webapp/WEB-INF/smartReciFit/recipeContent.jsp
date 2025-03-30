<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../part/header.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>
/* General Body Styles */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Malgun Gothic', '맑은 고딕', sans-serif;
	/* Common Korean font */
	margin: 0;
	padding: 0;
	/* Light background for the page */
	line-height: 1.6;
}

/* Main Recipe Container */
.recipe-content {
	max-width: 800px;
	/* Limit width for better readability */
	margin: 20px auto;
	/* Center the container */
	background-color: #ffffff;
	/* White background for the content area */
	padding: 0;
	/* Reset padding, apply to inner elements */
	/* Subtle shadow */
	/* Slightly rounded corners */
	overflow: hidden;
	/* Ensure children don't overflow rounded corners */
}

/* Hidden Inputs - No visual style needed */
.recipe-type, .meal-size {
	display: none;
}

/* Recipe Title Header */
.recipe-title {
	border-radius: 10px;
	background-color: #4CAF50;
	/* Green background like the image */
	color: white;
	/* White text */
	font-size: 1.8em;
	/* Larger font size for title */
	text-align: center;
	/* Center the title */
	padding: 15px 20px;
	/* Padding around the title */
	margin: 0 0 20px 0;
	/* Remove default margin */
}

/* Main Recipe Image */
.recipe-content>img {
	border-radius: 10px;
	display: block;
	/* Remove extra space below image */
	width: 100%;
	/* Make image responsive */
	height: auto;
	/* Maintain aspect ratio */
	max-height: 500px;
	/* Optional: limit image height */
	object-fit: cover;
	/* Cover the area nicely */
	margin-bottom: 10px;
	/* No margin around the image itself */
}

.ingredient-seasoning-container {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 20px;
}

.origin-meal-size {
	height: 40px;
	display: flex;
	justify-content: center;
	align-items: center;
}

/* Serving Size Slider Area */
.range-container {
	height: 40px;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 15px 20px;
	/* Add vertical margin */
	/* Separator line */
	/* Separator line */
	/* Needed for pseudo-elements */
}

/* The Slider Input */
#range {
	flex-grow: 1;
	/* Allow slider to take up space */
	max-width: 300px;
	/* Limit slider width */
	height: 4px;
	cursor: pointer;
	accent-color: orange;
	/* Color for the thumb/track like the image */
	background: blue;
	/* Default track color */
	outline: none;
}

/* Slider Output Value (Hidden as per image structure, labels are used instead) */
.output-container {
	display: flex;
	width: 100px;
	justify-content: center;
	align-items: center;
}

#output {
	width: 30px;
}

/* Wrapper for Ingredient/Seasoning sections to enable side-by-side */
/* Since we cannot modify HTML, we simulate the side-by-side look */
/* We center the parent and use inline-block for children */
/* Add text-align center to the parent that holds these two containers */
/* In this case, it would be .recipe-content, but that affects everything. */
/* Let's simulate a wrapper visually using margins and inline-block */
.ingredient-container, .seasoning-container,
	.convert-ingredient-container, .convert-seasoning-container {
	display: flex;
	flex-direction: column;
	margin-bottom: 20px;
	margin-top: 10px;
	/* Allows side-by-side layout */
	/* 50% width minus margins/padding */
	vertical-align: top;
	/* Align boxes at the top */
	background-color: #f8f8f8;
	/* Light gray background like placeholders */
	padding: 20px;
	/* Provides space around boxes */
	border-radius: 8px;
	box-sizing: border-box;
	/* Include padding in width calculation */
	min-height: 150px;
	/* Minimum height */
	/* Reset text alignment for content */
	position: relative;
	align-items: center;
	/* For pseudo-element title */
}

/* Add Titles to Ingredient/Seasoning Boxes */
.convert-ingredient-container::before, .ingredient-container::before {
	content: '재료';
	/* Title "Ingredients" */
	display: block;
	font-weight: bold;
	font-size: 1.1em;
	margin-bottom: 15px;
	color: #333;
}

.convert-seasoning-container::before, .seasoning-container::before {
	content: '양념';
	/* Title "Seasoning" */
	display: block;
	font-weight: bold;
	font-size: 1.1em;
	margin-bottom: 15px;
	color: #333;
}

/* Individual Ingredient/Seasoning Items */
.ingredient, .seasoning {
	font-size: 0.95em;
	color: #444;
	padding: 2px 0;
	/* Small vertical padding */
}

.convert-ingredient, .convert-seasoning {
	display: inline-block;
	/* Show items inline */
	margin: 5px 10px;
	font-size: 0.9em;
}

.recipe-manual-container {
	display: grid;
	grid-template-columns: 1fr;
	/* 데스크탑에서는 2열 그리드 */
	gap: 20px;
	counter-reset: recipe-step;
	/* 스텝 카운터 초기화 */
	padding: 20px;
	/* 컨테이너 주변 여백 (선택 사항) */
}

/* Individual Recipe Step */
.recipe-manual {
	display: grid;
	/* !!! 그리드 컨테이너로 변경 !!! */
	grid-template-columns: 200px 1fr;
	/* 1열(이미지): 120px, 2열(나머지): 남은 공간 */
	/* grid-template-rows: auto auto; */
	/* 행 높이는 콘텐츠에 맞게 자동 설정 (명시 불필요) */
	gap: 0 15px;
	/* 행 간격 0, 열 간격 15px */
	align-items: start;
	/* 그리드 셀 내 아이템을 상단 정렬 */
	/* position: relative; */
	/* 더 이상 필요 없음 */
	/* margin-bottom 등은 container의 gap으로 처리 */
}

/* Step Image */
.recipe-manual img {
	/* order: 1; */
	/* 그리드에서는 order 대신 grid-column/row 사용 */
	grid-column: 1;
	/* 1열에 배치 */
	grid-row: 1/span 2;
	/* 1행에서 시작해서 2개 행을 차지 (번호와 텍스트 높이만큼) */
	/* flex-shrink: 0; */
	/* 그리드 아이템에는 불필요 */
	width: 200px;
	/* 이미지 너비 */
	/* height: 100px; */
	/* 높이는 auto 또는 고정값 */
	height: 100%;
	/* 부모 그리드 행 높이를 채우도록 시도 */
	object-fit: cover;
	border-radius: 5px;
	background-color: #d7f0d8;
	border: 1px solid #c8e6c9;
	align-self: stretch;
	/* 셀의 높이를 채우도록 함 */
}

/* Step Number Circle */
.recipe-manual::before {
	counter-increment: recipe-step;
	/* 스텝 카운터 증가 */
	content: counter(recipe-step);
	/* 카운터 값 표시 */
	grid-column: 2;
	/* !!! 2열에 배치 !!! */
	grid-row: 1;
	/* !!! 1행에 배치 !!! */
	justify-self: start;
	/* 셀 내에서 왼쪽 정렬 (start, center, end) */
	align-self: center;
	/* 셀 내에서 수직 중앙 정렬 (선택적) */
	/* --- 기존 스타일 유지 --- */
	background-color: #4CAF50;
	color: white;
	width: 24px;
	height: 24px;
	border-radius: 50%;
	display: flex;
	/* 내부 숫자 정렬 위해 flex 유지 */
	align-items: center;
	justify-content: center;
	font-weight: bold;
	font-size: 20px;
	margin-bottom: 5px;
	/* 번호 아래, 텍스트와의 간격 */
}

/* Step Title/Instruction (Text Area) */
.recipe-manual h1 {
	/* order: 2; */
	/* 그리드에서는 order 대신 grid-column/row 사용 */
	grid-column: 2;
	/* !!! 2열에 배치 !!! */
	grid-row: 2;
	/* !!! 2행에 배치 !!! */
	/* flex: 1; */
	/* 그리드 아이템에는 불필요 (셀이 크기 조절) */
	font-size: 1.1em;
	margin: 0;
	color: #333;
	line-height: 1.5;
	/* padding-top: 35px; */
	/* !!! 제거: 번호가 위에 자연스럽게 배치되므로 불필요 !!! */
	padding-bottom: 10px;
}

.recipe-ai-manual-container {
	counter-reset: recipe-step;
}

.recipe-ai-manual h1::before {
	counter-increment: recipe-step;
	/* 스텝 카운터 증가 */
	content: counter(recipe-step);
	/* 카운터 값 표시 */
	/* !!! 2열에 배치 !!! */
	/* !!! 1행에 배치 !!! */
	justify-self: start;
	/* 셀 내에서 왼쪽 정렬 (start, center, end) */
	align-self: center;
	/* 셀 내에서 수직 중앙 정렬 (선택적) */
	/* --- 기존 스타일 유지 --- */
	background-color: #4CAF50;
	color: white;
	width: 30px;
	height: 30px;
	border-radius: 50%;
	display: flex;
	/* 내부 숫자 정렬 위해 flex 유지 */
	align-items: center;
	justify-content: center;
	font-weight: bold;
	font-size: 20px;
	margin-bottom: 5px;
	/* 번호 아래, 텍스트와의 간격 */
}

.recipe-ai-manual h1 {
	font-size: 25px;
}

iframe {
	margin: 20px 0;
	border-radius: 10px;
}

/* Responsive Adjustments (Optional) */
@media ( max-width : 600px) {
	.recipe-title {
		font-size: 1.5em;
	}
	.ingredient-container, .seasoning-container {
		display: block;
		/* Stack ingredients/seasoning on small screens */
		width: calc(100% - 30px);
		/* Full width minus margins */
		margin: 15px auto;
		/* Center the block */
	}
	.recipe-manual {
		flex-direction: column;
		/* Stack text and image vertically */
		align-items: flex-start;
		/* Align items to the start */
		/* Keep padding for number */
	}
	.recipe-manual img {
		width: 100%;
		/* Full width image */
		height: auto;
		/* Adjust height */
		max-width: 200px;
		/* Limit max width */
		margin-top: 10px;
		/* Add space above image */
	}
	.range-container::before, .range-container::after {
		font-size: 0.8em;
		/* Smaller labels */
		margin: 0 8px;
	}
}
</style>
<div class="recipe-content">
	<input class="recipe-type" type="hidden" value="${recipe.recipeType}">
	<c:if
		test="${recipe.recipeType eq 'API' or recipe.recipeType eq 'USER' or recipe.aiRecipeBoolean}">
		<input class="meal-size" type="hidden"
			value="${recipe.recipeMealSize }" />
		<h1 class="recipe-title">${recipe.recipeName }</h1>
		<img alt="" src="${recipe.recipeThumbnail }" />
		<div class="ingredient-seasoning-container">
			<div class="recipe-origin">
				<p class="origin-meal-size">
					<fmt:formatNumber value="${recipe.recipeMealSize}" type="number"
						maxFractionDigits="0" />
					인분
				</p>
				<div class="ingredient-container">
					<c:forEach items="${fn:split(recipe.recipeIngredient, '|')}"
						var="ingredient">
						<div class="ingredient">${ingredient}</div>
					</c:forEach>
				</div>
				<div class="seasoning-container">
					<c:forEach items="${fn:split(recipe.recipeSeasoning, '|')}"
						var="seasoning">
						<div class="seasoning">${seasoning}</div>
					</c:forEach>
				</div>
			</div>

			<div class="recipe-convert">
				<div class="range-container">
					<input type="range" name="range" id="range" value="1" min="0"
						max="5" oninput="output.value = this.value" step="0.2">
					<div class="output-container">
						<output type="number" id="output" class="output">1</output>
						<p>인분</p>
					</div>
				</div>
				<div class="convert-ingredient-container"></div>
				<div class="convert-seasoning-container"></div>
			</div>
		</div>
	</c:if>
	<div class="recipe-manual-container">
		<c:if test="${recipe.recipeType eq 'API'}">
			<c:set var="splitManual"
				value="${fn:split(recipe.recipeManual, '|')}" />
			<c:set var="splitRecipeImg"
				value="${fn:split(recipe.apiRecipeImg, '|')}" />
			<c:forEach var="i" begin="0" end="${fn:length(splitManual) - 1}">
				<div class="recipe-manual ${i }">
					<h1>${splitManual[i]}</h1>
					<img alt="" src="${splitRecipeImg[i]}">
				</div>
			</c:forEach>
		</c:if>
	</div>

	<div class="recipe-manual-container">
		<c:if test="${recipe.recipeType eq 'USER'}">
			<c:set var="splitManual"
				value="${fn:split(recipe.recipeManual, '|')}" />
			<c:set var="splitRecipeImg"
				value="${fn:split(recipe.userRecipeImg, '|')}" />
			<c:forEach var="i" begin="0" end="${fn:length(splitManual) - 1}">
				<div class="recipe-manual ${i }">
					<h1>${splitManual[i]}</h1>
					<img alt="" src="${splitRecipeImg[i]}">
				</div>
			</c:forEach>
		</c:if>
	</div>

	<c:if test="${recipe.recipeType eq 'AI'}">
		<input type="hidden" class="ai-recipe-boolean"
			value="${recipe.aiRecipeBoolean}">
		<div class="recipe-ai-manual-container">
			<c:choose>
				<c:when test="${recipe.aiRecipeBoolean}">
					<c:set var="splitManual"
						value="${fn:split(recipe.recipeManual, '|')}" />
					<c:forEach var="i" begin="0" end="${fn:length(splitManual) - 1}">
						<div class="recipe-ai-manual">
							<h1>${splitManual[i]}</h1>
							<iframe width="560" height="315"
								src="https://www.youtube.com/embed/${videoId}?start=${timeStamp.get(i)}"
								title="동영상 제목" frameborder="0" allowfullscreen></iframe>
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<h1>레시피 동영상이 아닙니다</h1>
				</c:otherwise>
			</c:choose>
		</div>
	</c:if>

</div>
<script src="${ctx}/js/recipe/recipeConverter.js"></script>
<%@ include file="../../part/footer.jsp"%>