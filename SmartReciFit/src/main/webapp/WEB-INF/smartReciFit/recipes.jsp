<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../part/header.jsp"%>
<link rel="stylesheet" type="text/css" href="${ctx}/css/recipes.css">

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