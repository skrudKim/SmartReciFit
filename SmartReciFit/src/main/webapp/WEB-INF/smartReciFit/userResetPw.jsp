<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<!-- 예쁜 알람창용 스크립트 -->
<%@ include file="../../part/header.jsp" %>
<link rel="stylesheet" type="text/css" href="${ctx}/css/CJYstyle.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<div class="inner">
<h2>비밀번호 재설정하기</h2>
<hr>
<p>재설정할 비밀번호를 입력해주세요.</p>
<div class="resetPwDiv">
<form id="pwResetForm" action="${ctx}/userResetPw.do" method="post" >
<input class="inputPwReset"  type="password" name="pw-new" id="pw-new" required>
<button class="btn-submit btn-green"  name="btn-submit" id="btn-resetPw" >완료</button>
</form>
</div>
</div>

<script src="${ctx}/js/user/userResetPw.js"> </script>
<%@ include file="../../part/footer.jsp" %>