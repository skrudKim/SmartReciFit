<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../part/adminHeader.jsp"%>
<c:if test="${recipes eq null}">
	<c:redirect url="/adminRecipe.do?page=1" />
</c:if>
<div class="box" style="display: flex;">
	<div class="admin-menu"">
		<jsp:include page="menu.jsp" />
	</div>
	<div class="recipe-list">
		<h2>recipe</h2>
		<table>
			<thead>
				<tr>
					<th>번호</th>
					<th>이름</th>
					<th>양</th>
					<th>재료</th>
					<th>양념</th>
					<th>메뉴얼</th>
					<th>썸네일</th>
					<th>cookingMethods</th>
					<th>ingredients</th>
					<th>eatTime</th>
					<th>cookingStyle</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="recipe" items="${recipes}">
					<tr>
						<td>${recipe.recipeNum}</td>
						<td>${recipe.recipeName}</td>
						<td>${recipe.recipeMealSize}</td>
						<td>${recipe.recipeIngredient}</td>
						<td>${recipe.recipeSeasoning}</td>
						<td>${recipe.recipeManual}</td>
						<td><img alt="" src="${recipe.recipeThumbnail}" /></td>
						<td>${recipe.cookingMethods}</td>
						<td>${recipe.ingredients}</td>
						<td>${recipe.eatTime}</td>
						<td>${recipe.cookingStyle}</td>
						<td>
							<form action="${ctx}/adminRecipeDelete.do">
								<input type="hidden" name="recipe-num"
									value="${recipe.recipeNum}">
								<button>삭제</button>
							</form>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="paging">
			<c:if test="${page > 1}">
				<a href="${ctx}/adminRecipe.do?page=${page - 1}">< 이전</a>
			</c:if>
			<c:if test="${page <= 1}">
				<span>< 이전</span>
			</c:if>
			<c:forEach var="i" begin="${startPage}" end="${endPage}">
				<c:choose>
					<c:when test="${i == page}">
						<a class="current" href="${ctx}/adminRecipe.do?page=${i}">${i}</a>
					</c:when>
					<c:otherwise>
						<a href="${ctx}/adminRecipe.do?page=${i}">${i}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${page < totalPages}">
				<a href="${ctx}/adminRecipe.do?page=${page + 1}">다음 ></a>
			</c:if>
			<c:if test="${page >= totalPages}">
				<span>다음 ></span>
			</c:if>
		</div>
		<div class="search-area">
			<form action="${ctx}/searchrecipeBoard.do" method="post">
				<select name="searchName">
					<option value="title" selected>제목</option>
					<option value="titleAndContent">제목+내용</option>
				</select> <input type="text" name="keyword" class="search-area-input">
				<button type="submit" class="search-btn">검색</button>
			</form>
		</div>
	</div>
</div>
