<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../part/header.jsp"%>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet" type="text/css" href="${ctx}/css/ranking.css">

<div class="main-content">
    <!-- 레시피 조회수 랭킹 -->
    <div class="ranking-section">
        <div class="title">레시피 조회수 랭킹 Top 3</div>
        <div class="ranking-entries">
            <%-- c:forEach 루프 --%>
            <c:forEach var="recipe" items="${topRecipesByViews}" varStatus="status">
                <a href="${ctx}/recipeContent.do?rn=${recipe.reviewBoardRecipeId}"
                   class="ranking-entry ${status.index == 0 ? 'rank-1' : (status.index == 1 ? 'rank-2' : (status.index == 2 ? 'rank-3' : ''))}">
                    <div class="rank-badge">
                        <c:choose>
                            <c:when test="${status.index == 0}"><i class="fas fa-crown"></i></c:when>
                            <c:when test="${status.index == 1}"><i class="fas fa-medal"></i></c:when>
                            <c:when test="${status.index == 2}"><i class="fas fa-award"></i></c:when>
                        </c:choose>
                    </div>
                    <div class="recipe-image-container">
                         <img src="${recipe.recipeThumbnail}" alt="${recipe.recipeName} 이미지">
                    </div>
                    <div class="recipe-info">
                        <div class="recipe-title" title="${recipe.recipeName}">${recipe.recipeName}</div>
                        <div class="ranking-details">
                            <p> <i class="fas fa-eye"></i>${recipe.reviewBoardViews} </p>
                        </div>
                    </div>
                </a>
            </c:forEach>
        </div>
    </div>

    <!-- 레시피 좋아요 랭킹 -->
    <div class="ranking-section">
        <div class="title">레시피 좋아요 랭킹 Top 3</div>
        <div class="ranking-entries">
            <%-- c:forEach 루프 --%>
             <c:forEach var="recipe" items="${topRecipesByLike}" varStatus="status">
                 <a href="${ctx}/recipeContent.do?rn=${recipe.reviewBoardRecipeId}"
                   class="ranking-entry ${status.index == 0 ? 'rank-1' : (status.index == 1 ? 'rank-2' : (status.index == 2 ? 'rank-3' : ''))}">
                    <div class="rank-badge">
                         <c:choose>
                            <c:when test="${status.index == 0}"><i class="fas fa-crown"></i></c:when>
                            <c:when test="${status.index == 1}"><i class="fas fa-medal"></i></c:when>
                            <c:when test="${status.index == 2}"><i class="fas fa-award"></i></c:when>
                        </c:choose>
                    </div>
                     <div class="recipe-image-container">
                         <img src="${recipe.recipeThumbnail}" alt="${recipe.recipeName} 이미지">
                     </div>
                    <div class="recipe-info">
                        <div class="recipe-title" title="${recipe.recipeName}">${recipe.recipeName}</div>
                        <div class="ranking-details">
                            <p> <i class="fas fa-heart"></i>${recipe.reviewBoardLikes} </p>
                        </div>
                    </div>
                </a>
            </c:forEach>
        </div>
    </div>
</div>

<%@ include file="../../part/footer.jsp"%>