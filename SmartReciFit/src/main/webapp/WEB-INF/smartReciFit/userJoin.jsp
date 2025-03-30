<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<!-- 예쁜 알람창용 스크립트 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<%@ include file="../../part/header.jsp" %>
<link rel="stylesheet" type="text/css" href="${ctx}/css/CJYstyle.css">

<div class="inner">
	<h2> 회원가입 </h2> 
	<hr>
	<p class="notice">*표가 있는 항목은 필수 입력 항목입니다.</p></td>
	<form id="userJoinForm" action="${ctx}/userJoin.do" method="post"  enctype="multipart/form-data">
	<table class="tableUserJoin">
	<tr>
	<td>아이디*</td>
	<td><input type="text" class="inputUserJoin" name="id-new" id="id-new" required></td>
	<td><button class="btn-checkId" name="btn-checkId" id="btn-checkId">아이디 중복검사</button></td>
	</tr>
	<tr>
	<td>비밀번호*</td>
	<td><input type="password" class="inputUserJoin"  name="pw-new" id="pw-new" required></td>
	</tr>
	<tr>
	<td>이름*</td>
	<td><input type="text" class="inputUserJoin" name="name" id="name" required></td>
	</tr>
	<tr>
	<td>닉네임*</td>
	<td><input type="text" class="inputUserJoin"  name="nickName" id="nickName" required></td>
	<td><button class="btn-checkNickName" name="btn-checkNickName" id="btn-checkNickName">닉네임 중복검사</button></td>
	</tr>
	<tr>
	<td>이메일*</td>
	<td><input type="text" class="inputUserJoin" name="email" id="email"></td>
	<td><button class="btn-checkEmail" name="btn-checkEmail" id="btn-checkEmail" onclick="email_ok(email.value)">이메일인증</button></td>
	</tr>
	<tr>
	<td><div id="countdown"></div></td>
	<td><input type="text" class="inputUserJoin" name="checkEmailOk" id="checkEmailOk"></td>
	<td><button class="btn-checkEmailOk" name="btn-checkEmailOk" id="btn-checkEmailOk" placeholder="인증번호를 입력해주세요">인증완료</button></td>
	</tr>
	<tr>
	<td>전화번호</td>
	<td><input type="text" class="inputUserJoin"  name="phone" id="phone"></td>
	</tr>
	<tr>
	<td>프로필 사진</td>
	<td><label for="uploadFile" class="fileLabel">파일 선택</label>
	<input type="file" class="inputFileHidden" name="uploadFile" id="uploadFile" accept="image/*" onchange="tryImgPreview(event)" ></td>
	<td><button class="btn-imgDel" name="btn-imgDel" id="btn-imgDel">이미지삭제</button></td>
	</tr>
	<tr><td colspan="3"> <div id="imgPreview"><img src="${ctx}/img/ProfileBasicImg.png" class="photo" id="default" /></div> </td></tr>
	</table>
	</form>
	<button class="btn-submit" name="btn-submit" id="btn-submit">회원가입</button>
</div>

<script src="${ctx}/js/user/userJoin.js"> </script>
<%@ include file="../../part/footer.jsp" %>