<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../part/header.jsp"%>


<style>

.review-page {
    max-width: 850px; /* 폼 전체의 최대 너비 설정 */
    margin: 40px auto; /* 폼을 페이지 중앙에 위치 */
    padding: 35px 45px; /* 폼 내부 여백 늘림 */
    background-color: #ffffff; /* 폼 영역 배경색 흰색 */
    border-radius: 10px; /* 폼 모서리 좀 더 둥글게 */
    box-shadow: 0 6px 18px rgba(0, 0, 0, 0.1); /* 그림자 약간 강조 */
    box-sizing: border-box;
}

/* --- 레시피 검색 영역 스타일 --- */
.recipe-search {
    margin-bottom: 8px; /* 검색 결과창과의 간격 줄임 */
    position: relative;
}

.recipe-search .search-input {
    width: 100%;
    padding: 12px 18px; /* 내부 여백 늘림 */
    border: 1px solid #ced4da;
    border-radius: 6px; /* 모서리 살짝 더 둥글게 */
    font-size: 1rem;
    box-sizing: border-box;
}
.recipe-search .search-input::placeholder {
    color: #adb5bd;
}
/* --- 검색 결과 영역 스타일 --- */
#searchResults {
    max-height: 280px; /* 카드 형태이므로 높이 확보 */
    overflow-y: auto; /* 내용 많으면 스크롤 */
    background-color: #f8f9fa; /* 카드 배경과 구분 위해 약간의 배경색 */
    border: 1px solid #e0e0e0;
    border-radius: 6px; /* 검색창과 통일감 */
    padding: 15px; /* 카드 주변 여백 */
    margin-top: 0; /* 검색창 바로 아래 붙임 */
    margin-bottom: 25px; /* 검색 결과 아래 여백 확보 */
    box-shadow: inset 0 1px 3px rgba(0,0,0,0.05);

    /* 스크롤바 디자인 */
    scrollbar-width: thin; /* Firefox */
    scrollbar-color: #bbb #f1f1f1; /* Firefox */
}


/* --- 메인 폼 테이블 스타일 (테이블을 섹션처럼 보이게 조정) --- */
.write-table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0 25px; /* 행(row) 사이의 수직 간격 늘림 */
    margin-top: 10px; /* 검색 결과 아래 테이블과의 간격 */
    border: none; /* 테이블 자체 테두리 제거 */
}

.write-row th,
.write-row td {
    padding: 0;
    text-align: left;
    vertical-align: top;
    border: none; /* 셀 테두리 제거 */
}

.write-row th {
    width: 120px; /* 제목(th) 너비 고정 */
    font-weight: 600;
    color: #333;
    padding-right: 20px; /* 제목과 입력칸 사이 간격 늘림 */
    padding-top: 10px; /* 입력 필드와 수직 정렬 */
    box-sizing: border-box;
}

/* --- 입력 필드 공통 스타일 --- */
.input-field,
.textarea-field {
    width: 100%;
    padding: 10px 14px; /* 내부 여백 조정 */
    border: 1px solid #ced4da;
    border-radius: 4px;
    font-size: 0.95rem;
    box-sizing: border-box;
    margin-bottom: 5px;
    transition: border-color 0.2s ease, box-shadow 0.2s ease;
}
.input-field:focus,
.textarea-field:focus {
    border-color: #80bdff; /* 포커스 시 테두리 색 변경 */
    outline: 0;
    box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25); /* 포커스 시 외부 광선 효과 */
}

.textarea-field {
    resize: vertical;
    min-height: 150px; /* 최소 높이 늘림 */
}

.input-field::placeholder,
.textarea-field::placeholder {
    color: #adb5bd;
}

/* --- 이미지 업로드 영역 스타일 --- */
.review-image {
    display: flex;
    flex-wrap: wrap;
    gap: 20px; /* 이미지 컨테이너 사이 간격 */
}

.image-container {
    border: 1px dashed #ced4da; /* 기본 점선 테두리 */
    padding: 10px;
    border-radius: 6px; /* 모서리 둥글게 */
    width: 150px; /* 컨테이너 너비 고정 */
    height: 150px; /* 컨테이너 높이 고정 */
    display: flex;
    flex-direction: column;
    align-items: center; /* 내부 요소 중앙 정렬 */
    justify-content: center; /* 내부 요소 중앙 정렬 */
    background-color: #f8f9fa;
    position: relative; /* 삭제 버튼 위치 기준 */
    text-align: center;
    box-sizing: border-box;
}

/* 이미지가 로드되었을 때 컨테이너 스타일 */
.image-container:has(img[style*="inline-block"]) {
    border-style: solid; /* 실선 테두리 */
    background-color: transparent;
    padding: 5px; /* 패딩 줄임 */
}

/* 이미지 미리보기 스타일 */
.image-container img {
    max-width: 100%; /* 컨테이너 너비에 맞춤 */
    max-height: 100px; /* 최대 높이 제한 */
    height: auto; /* 비율 유지 */
    object-fit: contain; /* 이미지가 잘리지 않도록 */
    margin-bottom: 8px;
    border-radius: 4px;
}

/* 파일명 스타일 (선택 사항) */
#filename1, #filename2, #filename3 {
    font-size: 0.75rem;
    color: #666;
    word-break: break-all;
    max-width: 100%;
    margin-top: 5px;
    line-height: 1.2;
}

/* 파일 선택 input 필드 스타일 (input 자체는 숨길 수 있음) */
.image-container input[type="file"].input-field {
    /* 기본 input 숨기기 (버튼 스타일로 대체) */
    /* opacity: 0; */
    /* position: absolute; */
    /* width: 100%; height: 100%; */
    /* left: 0; top: 0; cursor: pointer; */

    /* 또는 간단히 스타일 조정 */
    border: none;
    padding: 5px;
    background: none;
    width: auto;
    max-width: 100%;
    font-size: 0.85rem;
    margin-top: 8px; /* 다른 요소와 간격 */
}

/* 브라우저 기본 파일 선택 버튼 스타일 개선 */
.image-container input[type="file"]::file-selector-button {
    padding: 6px 12px;
    border: 1px solid #fadd4bbb;
    background-color: #fadd4bbb;
    color: white;
    border-radius: 4px;
    cursor: pointer;
    font-size: 0.85rem;
    transition: background-color 0.2s ease;
    margin-right: 8px; /* 버튼과 텍스트 사이 간격 */
}
.image-container input[type="file"]::file-selector-button:hover {
    background-color: #0056b3;
}

/* 이미지 삭제 버튼 스타일 */
.image-container .delete-btn {
    position: absolute;
    top: 5px;
    right: 5px;
    background-color: rgba(220, 53, 69, 0.8); /* 부트스트랩 danger 색상 반투명 */
    color: white;
    border: none;
    border-radius: 50%;
    width: 22px;
    height: 22px;
    font-size: 12px;
    line-height: 22px; /* 수직 중앙 정렬 */
    text-align: center;
    cursor: pointer;
    padding: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 1px 3px rgba(0,0,0,0.2);
    transition: background-color 0.2s ease;
}
.image-container .delete-btn:hover {
    background-color: rgba(200, 35, 51, 0.9); /* 호버 시 더 진하게 */
}

/* --- 하단 버튼 영역 스타일 --- */
.write-Allbtn {
    text-align: center; /* 버튼들을 중앙 정렬 */
    padding-top: 20px;
}

/* 공통 버튼 스타일 */
.write-btn,
.cancel-btn {
    padding: 12px 30px; /* 버튼 크기 늘림 */
    border: none;
    border-radius: 6px; /* 모서리 둥글게 */
    font-size: 1rem;
    font-weight: 500;
    cursor: pointer;
    margin: 0 10px; /* 버튼 사이 간격 */
    transition: background-color 0.2s ease, box-shadow 0.2s ease, transform 0.1s ease;
}
.write-btn:active,
.cancel-btn:active {
    transform: translateY(1px); /* 클릭 시 살짝 눌리는 효과 */
}

/* 작성하기 버튼 스타일 */
.write-btn {
    background-color: #3CB371; /* 초록색 */
    color: white;
    box-shadow: 0 2px 5px rgba(40, 167, 69, 0.4);
}
.write-btn:hover {
    background-color: #218838;
    box-shadow: 0 4px 8px rgba(40, 167, 69, 0.5);
}

/* 취소/목록 버튼 스타일 */
.cancel-btn {
    background-color: #6c757d; /* 회색 */
    color: white;
    box-shadow: 0 2px 5px rgba(108, 117, 125, 0.4);
}
.cancel-btn:hover {
    background-color: #5a6268;
    box-shadow: 0 4px 8px rgba(108, 117, 125, 0.5);
}

/* 반응형 예시: 작은 화면에서 카드 레이아웃 조정 */
@media (max-width: 768px) {
    .review-page {
        padding: 25px 30px;
    }
    #searchResults > label {
        flex-basis: calc(50% - 8px); /* 한 줄에 2개 */
    }
    .write-row th {
        width: 100px; /* 라벨 너비 줄임 */
        padding-right: 10px;
    }
}

@media (max-width: 576px) {
    .review-page {
        padding: 20px;
        margin: 20px auto;
    }
    #searchResults > label {
        flex-basis: 100%; /* 한 줄에 1개 */
    }
    .write-row th {
        width: auto; /* 라벨 너비 자동 */
        display: block; /* 라벨을 위로 올림 */
        padding-bottom: 5px; /* 라벨 아래 간격 */
        padding-top: 0;
    }
    .write-row td {
        display: block; /* 입력 필드도 블록으로 */
    }
    .write-table {
        border-spacing: 0 15px; /* 간격 줄임 */
    }
    .review-image {
        gap: 10px;
    }
    .image-container {
        width: calc(50% - 5px); /* 작은 화면에서 이미지 컨테이너 2개씩 */
        height: auto;
        min-height: 120px;
    }
    .write-Allbtn {
        display: flex;
        flex-direction: column;
        gap: 10px;
    }
    .write-btn, .cancel-btn {
        width: 100%;
        margin: 0;
    }
}


</style>


<div class="review-page">
	<form action="${ctx}/reviewWriteProcess.do" method="post"
		enctype="multipart/form-data">
		<input type="hidden" name="user" value="${user}">

		<div class="recipe-search">
			<input type="text" id="keyword" placeholder="참고 레시피 검색"
				class="search-input" required onkeyup="searchRecipes()">
		</div>

		<!-- 검색 결과 표시 영역 -->
		<div id="searchResults" class="search-results"></div>

		<table class="write-table">
			<tr class="write-row">
				<th>후기 제목</th>
				<td><input type="text" name="title" required
					placeholder="예) 소고기 미역국 끓이기" class="input-field"></td>
			</tr>
			<tr class="write-row">
				<th>글 내용</th>
				<td><textarea name="content" required
						placeholder="후기 내용을 작성해주세요. 예) 어머니 생신을 맞아 소고기 미역국을 끓여봤어요 너무너무 좋아하셨습니다!"
						class="textarea-field"
						style="height: 100px; width: 610px; resize: none;"></textarea></td>
			</tr>
			<tr class="write-row">
				<th>이미지</th>
				<td>
					<!-- 기존 이미지 표시 및 수정/삭제 -->
					<div class="review-image">
						<c:forEach var="i" begin="1" end="3">
							<div id="imageDiv${i}" class="image-container">
								<img id="previewImg${i}"
									src="${ctx}/img/${not empty imagePaths[i-1] ? imagePaths[i-1] : ''}"
									alt="Image ${i}"
									style="width: 100px; height: 100px; object-fit: cover; margin: 5px;  display: ${not empty imagePaths[i-1] ? 'inline-block' : 'none'} !important;">

								<span id="filename${i}"
									style="display: ${not empty imagePaths[i-1] ? 'block' : 'none'};">${not empty imagePaths[i-1] ? imagePaths[i-1] : ''}</span>

								<input type="file" name="img${i}" accept="image/*"
									class="input-field"
									style="display: ${not empty imagePaths[i-1] ? 'none' : 'block'}"
									onchange="previewImage(this, ${i})"> <input
									type="hidden" name="existingImg${i}" value="${imagePaths[i-1]}">
								<button type="button" class="delete-btn"
									style="display: ${not empty imagePaths[i-1] ? 'inline-block' : 'none'}"
									onclick="deleteImage(this,${i})">X</button>
							</div>
						</c:forEach>

					</div>
				</td>
			<tr class="write-row">
				<td colspan="2" class="write-Allbtn">
					<button type="submit" class="write-btn">작성하기</button>
					<button type="button" class="cancel-btn" onclick="history.back()">목록으로
						돌아가기</button>
				</td>
			</tr>
		</table>
	</form>
</div>



<script src="${ctx}/js/board/updateReview.js"></script>
<script src="${ctx}/js/board/searchRecipe.js"></script>
<%@ include file="../../part/footer.jsp"%>