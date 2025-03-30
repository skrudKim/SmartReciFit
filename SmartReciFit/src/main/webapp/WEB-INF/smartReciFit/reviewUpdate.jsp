<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../part/header.jsp"%>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.util.List" %>


<style>
.review-page { /* 이 클래스는 동일하게 사용 */
    max-width: 850px; /* 폼 전체의 최대 너비 설정 */
    margin: 40px auto; /* 폼을 페이지 중앙에 위치 */
    padding: 35px 45px; /* 폼 내부 여백 늘림 */
    background-color: #ffffff; /* 폼 영역 배경색 흰색 */
    border-radius: 10px; /* 폼 모서리 좀 더 둥글게 */
    box-shadow: 0 6px 18px rgba(0, 0, 0, 0.1); /* 그림자 약간 강조 */
    box-sizing: border-box;
}

/* --- 메인 폼 테이블 스타일 (update 페이지용) --- */
.update-table { /* 클래스명 변경 */
    width: 100%;
    border-collapse: separate;
    border-spacing: 0 25px; /* 행(row) 사이의 수직 간격 늘림 */
    margin-top: 10px;
    border: none; /* 테이블 자체 테두리 제거 */
}

.update-row th, /* 클래스명 변경 */
.update-row td { /* 클래스명 변경 */
    padding: 0;
    text-align: left;
    vertical-align: top;
    border: none; /* 셀 테두리 제거 */
}

.update-row th { /* 클래스명 변경 */
    width: 120px; /* 제목(th) 너비 고정 */
    font-weight: 600;
    color: #333;
    padding-right: 20px; /* 제목과 입력칸 사이 간격 늘림 */
    padding-top: 10px; /* 입력 필드와 수직 정렬 */
    box-sizing: border-box;
}

/* --- 입력 필드 공통 스타일 (클래스명 동일하므로 그대로 적용) --- */
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

.textarea-field { /* 스타일 오버라이드를 위해 !important 제거 */
    resize: vertical;
    min-height: 150px; /* 최소 높이 늘림 */
    /* JSP의 인라인 스타일(height, width, resize)보다 CSS 우선순위를 높이려면 아래처럼 할 수 있으나,
       가급적 인라인 스타일을 지우는 것이 좋습니다. */
    /* height: auto !important; */ /* 인라인 스타일 height 무시 */
    /* width: 100% !important; */ /* 인라인 스타일 width 무시 */
}

.input-field::placeholder,
.textarea-field::placeholder {
    color: #adb5bd;
}

/* --- 이미지 업로드 영역 스타일 (클래스명 동일하므로 그대로 적용) --- */
.review-image {
    display: flex;
    flex-wrap: wrap;
    gap: 15px; /* 간격 약간 줄임 (조절 가능) */
}

.image-container {
    border: 1px dashed #ced4da;
    padding: 10px; /* 내부 패딩 */
    border-radius: 6px;
    width: 150px; /* 너비 고정 */
    height: 180px; /* 높이 약간 늘림 (파일명/버튼 공간 확보) */
    display: flex;
    flex-direction: column; /* 세로 배치 */
    /* justify-content: center; */ /* 중앙 정렬 대신 다른 방식 사용 */
    justify-content: space-between; /* 위아래 공간 분배 */
    align-items: center; /* 가로 중앙 정렬 유지 */
    background-color: #f8f9fa;
    position: relative;
    text-align: center;
    box-sizing: border-box;
    overflow: hidden; /* 내부 요소 넘침 방지 */
}

/* 이미지가 로드되었을 때 컨테이너 스타일 */
.image-container:has(img[style*="inline-block"]) {
    border-style: solid;
    background-color: transparent;
    padding: 10px; /* 패딩 일관성 유지 */
}

/* 이미지 미리보기 스타일 수정 */
.image-container img {
    max-width: 100%;
    max-height: 80px; /* 최대 높이 줄여서 아래 공간 확보 */
    height: auto;
    object-fit: contain; /* 이미지 잘리지 않게 */
    margin-bottom: 8px; /* 이미지 아래 간격 */
    border-radius: 4px;
    display: block; /* JSP 인라인 스타일 덮어쓰기 */
}

/* 파일명 스타일 수정 */
#filename1, #filename2, #filename3 {
    font-size: 0.75rem; /* 12px */
    color: #666;
    word-break: break-all; /* 단어 중간에서 줄바꿈 허용 */
    overflow-wrap: break-word; /* 위와 유사 */
    max-width: 100%;
    line-height: 1.3; /* 줄 간격 */
    text-align: center; /* 중앙 정렬 */
    margin-top: auto; /* 위 요소와 최대한 멀어지게 (justify-content: space-between과 함께 사용) */
    margin-bottom: 5px; /* 아래 파일 선택 버튼과의 간격 */
    display: block !important; /* JSP 인라인 스타일 덮어쓰기 */
    /* 만약 한 줄 + 말줄임표를 원하면 아래 주석 해제 */
    /* white-space: nowrap; */
    /* overflow: hidden; */
    /* text-overflow: ellipsis; */
}

/* 파일 선택 input 필드 스타일 수정 */
.image-container input[type="file"].input-field {
    border: none;
    padding: 0; /* 불필요 패딩 제거 */
    background: none;
    width: 100%; /* 너비 꽉 채움 */
    font-size: 0.85rem;
    margin-top: 5px; /* 위 파일명과의 간격 */
    display: block !important; /* JSP 인라인 스타일 덮어쓰기 */
    text-align: left; /* 내부 버튼/텍스트 왼쪽 정렬 */
    overflow: hidden; /* 내부 요소 넘침 방지 */
}

/* 브라우저 기본 파일 선택 버튼 스타일 개선 */
.image-container input[type="file"]::file-selector-button {
    padding: 5px 10px; /* 버튼 크기 살짝 조정 */
    border: 1px solid #fadd4bbb;
    background-color: #fadd4bbb;
    color: white;
    border-radius: 4px;
    cursor: pointer;
    font-size: 0.8rem; /* 버튼 폰트 크기 살짝 조정 */
    transition: background-color 0.2s ease;
    margin-right: 5px;
    /* float: left; */ /* 필요시 왼쪽 정렬 */
}
.image-container input[type="file"]::file-selector-button:hover {
    background-color: #0056b3;
}
/* 파일 선택 후 표시되는 텍스트 (브라우저 기본 동작) 스타일 */
/* (직접 제어 어려움, input 너비 제한으로 간접 처리) */


/* 이미지 삭제 버튼 스타일 (변경 없음, 위치 확인) */
.image-container .delete-btn {
    position: absolute;
    top: 5px;
    right: 5px;
    background-color: rgba(220, 53, 69, 0.8);
    color: white;
    border: none;
    border-radius: 50%;
    width: 20px; /* 크기 살짝 줄임 */
    height: 20px;
    font-size: 10px; /* 폰트 크기 줄임 */
    line-height: 20px;
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
    background-color: rgba(200, 35, 51, 0.9);
}

/* --- 하단 버튼 영역 스타일 (update 페이지용) --- */
.update-Allbtn { /* 클래스명 변경 */
    text-align: center; /* 버튼들을 중앙 정렬 */
    padding-top: 20px;
}

/* 공통 버튼 스타일 */
.update-btn, /* 클래스명 변경 */
.update-cancel-btn { /* 클래스명 변경 */
    padding: 12px 30px; /* 버튼 크기 늘림 */
    border: none;
    border-radius: 6px; /* 모서리 둥글게 */
    font-size: 1rem;
    font-weight: 500;
    cursor: pointer;
    margin: 0 10px; /* 버튼 사이 간격 */
    transition: background-color 0.2s ease, box-shadow 0.2s ease, transform 0.1s ease;
}
.update-btn:active, /* 클래스명 변경 */
.update-cancel-btn:active { /* 클래스명 변경 */
    transform: translateY(1px); /* 클릭 시 살짝 눌리는 효과 */
}

/* 수정하기 버튼 스타일 */
.update-btn { 
    background-color: #3CB371; /* 파란색 계열 (수정 버튼) */
    color: white;
    box-shadow: 0 2px 5px rgba(40, 167, 69, 0.4);
}
.update-btn:hover {
    background-color: #218838;
    box-shadow: 0 4px 8px rgba(40, 167, 69, 0.5);
}

/* 돌아가기 버튼 스타일 */
.update-cancel-btn { /* 클래스명 변경 */
    background-color: #6c757d; /* 회색 */
    color: white;
    box-shadow: 0 2px 5px rgba(108, 117, 125, 0.4);
}
.update-cancel-btn:hover { /* 클래스명 변경 */
    background-color: #5a6268;
    box-shadow: 0 4px 8px rgba(108, 117, 125, 0.5);
}


/* 반응형 예시: 작은 화면 */
@media (max-width: 768px) {
    .review-page {
        padding: 25px 30px;
    }
    /* update 페이지용 반응형 */
    .update-row th { /* 클래스명 변경 */
        width: 100px;
        padding-right: 10px;
    }
}

@media (max-width: 576px) {
    .review-page {
        padding: 20px;
        margin: 20px auto;
    }
    /* update 페이지용 반응형 */
    .update-row th { /* 클래스명 변경 */
        width: auto;
        display: block;
        padding-bottom: 5px;
        padding-top: 0;
    }
    .update-row td { /* 클래스명 변경 */
        display: block;
    }
    .update-table { /* 클래스명 변경 */
        border-spacing: 0 15px;
    }
    .review-image {
        gap: 10px;
    }
    .image-container {
        width: calc(50% - 5px);
        height: auto;
        min-height: 120px;
    }
    .update-Allbtn { /* 클래스명 변경 */
        display: flex;
        flex-direction: column;
        gap: 10px;
    }
    .update-btn, .update-cancel-btn { /* 클래스명 변경 */
        width: 100%;
        margin: 0;
    }
}


</style>
<div class="review-page">
    <form
        action="${ctx}/reviewUpdateProcess.do?reviewBoardNum=${review.reviewBoardNum}&userNickname=${userNickname}"
        method="post" enctype="multipart/form-data">
        <table class="update-table">
            <tr class="update-row">
                <th>후기 제목</th>
                <td><input type="text" name="title" required
                           value="${review.reviewBoardTitle}" class="input-field"></td>
            </tr>
            <tr class="update-row">
                <th>글 내용</th>
                <td><textarea name="content" required class="textarea-field"
                              style="height: 100px; width: 610px; resize: none;">${review.reviewBoardContent}</textarea></td>
            </tr>
            <tr class="update-row">
                <th>이미지</th>
                <td>
                    <!-- 기존 이미지 표시 및 수정/삭제 -->
                    <div class="review-image">
                        <c:forEach var="i" begin="1" end="3">
                            <div id="imageDiv${i}" class = "image-container">
                                <img id="previewImg${i}" src="${ctx}/img/${not empty imagePaths[i-1] ? imagePaths[i-1] : ''}" alt="Image ${i}"
                                     style="width: 100px; height: 100px; object-fit: cover; margin: 5px;  display: ${not empty imagePaths[i-1] ? 'inline-block' : 'none'} !important;">
								  
								   <span id="filename${i}" style="display: ${not empty imagePaths[i-1] ? 'block' : 'none'};">${not empty imagePaths[i-1] ? imagePaths[i-1] : ''}</span>

                                <input type="file" name="img${i}" accept="image/*" class="input-field" style= "display: ${not empty imagePaths[i-1] ? 'none' : 'block'}"
                                       onchange="previewImage(this, ${i})">
                                <input type="hidden" name="existingImg${i}" value="${imagePaths[i-1]}">
                                <button type="button" class= "delete-btn" style="display: ${not empty imagePaths[i-1] ? 'inline-block' : 'none'}"
                                        onclick="deleteImage(this,${i})">X</button>
                            </div>
                        </c:forEach>

                    </div>
                </td>
            </tr>
             <tr class="update-row">
                <td colspan="2" class="update-Allbtn">
                    <input type="hidden" name="reviewBoardNum" value="${review.reviewBoardNum}">
                    <button type="submit" class="update-btn">수정하기</button>
                    <button type="button" class="update-cancel-btn" onclick="history.back()">돌아가기</button>
                </td>
            </tr>
        </table>
    </form>
</div>
	
<script src="${ctx}/js/board/updateReview.js"></script>
<%@ include file="../../part/footer.jsp"%>
