<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../part/header.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link rel="stylesheet" type="text/css" href="${ctx}/css/recipeContent.css">

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