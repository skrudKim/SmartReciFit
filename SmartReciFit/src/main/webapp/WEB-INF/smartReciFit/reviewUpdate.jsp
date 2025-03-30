<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../part/header.jsp"%>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.util.List" %>
<link rel="stylesheet" type="text/css" href="${ctx}/css/reviewUpdate.css">



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
