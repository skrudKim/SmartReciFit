<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<!-- 예쁜 알람창용 스크립트 -->
<%@ include file="../../part/header.jsp" %>
<link rel="stylesheet" type="text/css" href="${ctx}/css/CJYstyle.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<div class="inner">
<h2>정말 <span class="notice">탈퇴</span>하시겠습니까?</h2>
 <hr>
<p> 회원탈퇴를 진행하면 기존에 작성했던 글과 덧글은 삭제, 수정할 수 없습니다.</p>
<p> 원하신다면 탈퇴 전에 삭제, 수정해주세요.</p>
<!-- <form id="userInfoForm" method="post" action="userDel.do"> -->
<div class="delCheckBoxDiv">
<input type="checkbox" class="delCheckBox"  id="confirmCheckbox"> 확인했습니다
</div>
<button class="btn-submit btn-grey" name="btn-submit" id="btn-submit" disabled>탈퇴하기</button>
<!-- </form> -->
</div>

<script src="${ctx}/js/user/userDel.js"> </script>
<%@ include file="../../part/footer.jsp" %>