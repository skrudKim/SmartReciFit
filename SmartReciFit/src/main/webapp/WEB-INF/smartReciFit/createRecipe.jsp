<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../part/header.jsp"%>
<link rel="stylesheet" type="text/css" href="${ctx}/css/createRecipe.css">

<div class="create-recipe-container">
	<h2>나만의 레시피 등록</h2>

	<form action="${ctx}/saveRecipe.do" method="post"
		enctype="multipart/form-data">

		<input type="hidden" name="userNum" value="${sessionScope.log}">

		<div class="form-group">
			<label for="recipeName">레시피 제목</label> <input type="text"
				id="recipeName" name="recipeName" placeholder="예) 초간단 김치볶음밥"
				required>
		</div>

		<div class="form-group">
			<label>대표 이미지 (썸네일)</label> <input type="file" id="recipeThumbnail"
				name="recipeThumbnail" accept="image/*" style="display: none;" required>
			<label for="recipeThumbnail" class="file-label">파일 선택</label> <span
				id="thumbnail-filename">선택된 파일 없음</span>
		</div>

		<div class="form-group category-group" required>
			<label>카테고리</label> <select name="tagEatTime">
				<option value="">종류별</option>
				<option value="아침">아침</option>
				<option value="점심">점심</option>
				<option value="저녁">저녁</option>
				<option value="야식">야식</option>
				<option value="간식">간식</option>
				<option value="반찬">반찬</option>
				<option value="기타">기타</option>
			</select> <select name="tagCookingStyle" required>
				<option value="">상황별</option>
				<option value="양식">양식</option>
				<option value="한식">한식</option>
				<option value="중식">중식</option>
				<option value="일식">일식</option>
				<option value="아시안식">아시안식</option>
				<option value="기타">기타</option>
			</select>
			  <div class="checkbox-sections-wrapper">

        <%-- 요리 방법 체크박스 그룹 --%>
        <div class="checkbox-section cooking-method-section">
            <label class="checkbox-section-title">요리 방법:</label> <%-- 그룹 라벨 추가 (선택 사항) --%>
            <div class="checkbox-items"> <%-- 체크박스 아이템들을 감싸는 div --%>
                <c:forEach var="cookingMethod" items="${tagCookingMethod}">
                    <div class="checkbox-item"> <%-- 개별 아이템 div --%>
                        <input type="checkbox" class="cooking-method" id="cooking-method-${cookingMethod}" name="cooking-method" value="${cookingMethod}">
                        <label for="cooking-method-${cookingMethod}">${cookingMethod}</label>
                    </div>
                </c:forEach>
            </div>
        </div>

        <%-- 주재료 체크박스 그룹 --%>
        <div class="checkbox-section ingredient-section">
            <label class="checkbox-section-title">주재료:</label> <%-- 그룹 라벨 추가 (선택 사항) --%>
             <div class="checkbox-items"> <%-- 체크박스 아이템들을 감싸는 div --%>
                <c:forEach var="ingredient" items="${tagIngredient}">
                    <div class="checkbox-item"> <%-- 개별 아이템 div --%>
                        <input type="checkbox" class="ingredient" id="ingredient-${ingredient}" name="ingredient" value="${ingredient}">
                        <label for="ingredient-${ingredient}">${ingredient}</label>
                    </div>
                </c:forEach>
            </div>
        </div>

    </div> <%-- checkbox-sections-wrapper 끝 --%>

		</div>

		<div class="form-group">
			<label>재료</label>
			<div id="ingredient-list">
				<div class="ingredient-item">
					<input type="text" name="ingredients[]" placeholder="예) 김치 1/4포기" required>
					<button type="button" class="remove-btn"
						onclick="removeInput(this)">-</button>
				</div>
			</div>
			<button type="button" class="add-btn" onclick="addIngredientInput()">+</button>
		</div>


		<%-- 요리 순서 섹션 수정 --%>
		<div class="form-group">
			<label>요리 순서</label>
			<div id="steps-list">
				<div class="step-item">
					<span class="step-number">Step 1.</span>
					<div class="step-content">
						<textarea name="steps[]" placeholder="조리 과정을 순서대로 작성해주세요." required></textarea>
						<div class="step-image-upload">
							<input type="file" id="step_img_1" name="steps_img" accept="image/*" style="display: none;">
							<label for="step_img_1" class="file-label">사진 추가</label>
							<span class="step-filename">선택된 파일 없음</span>
						</div>
					</div>
					<button type="button" class="remove-btn" onclick="removeStep(this)">-</button>
				</div>
			</div>
			<button type="button" class="add-btn" onclick="addStepInput()">+</button>
		</div>

		<%-- 등록 버튼 --%>
		<button type="submit" class="submit-btn">레시피 등록하기</button>

	</form>
</div>

<script src="${ctx}/js/recipe/createRecipes.js">
	
</script>
<%@ include file="../../part/footer.jsp"%>