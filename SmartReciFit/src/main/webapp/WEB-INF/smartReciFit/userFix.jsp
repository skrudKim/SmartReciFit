<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<!-- 예쁜 알람창용 스크립트 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<%@ include file="../../part/header.jsp" %>
<link rel="stylesheet" type="text/css" href="${ctx}/css/CJYstyle.css">

<div class="inner">
	<h2> 회원정보수정 </h2> 
	    <hr>
	<form id="userFixForm" action="${ctx}/userFix.do?num=${userFix.userNum}" method="post"  enctype="multipart/form-data">
	<p class="notice">*표가 있는 항목은 필수 입력 항목입니다.</p>
	<table class="tableUserFix">
	<tr>
	<td>아이디*</td>
	<td><input class="inputUserFix" type="text" name="id-new" id="id-new"  value="${userFix.userId}" required><input type="hidden" id="originalIdHidden" data-original-id="${userFix.userId}"></td>
	<td><button class="btn-checkId" name="btn-checkId" id="btn-checkId">아이디 중복검사</button></td>
	</tr>
	<tr>
	<td>비밀번호*</td>
	<td><input class="inputUserFix" type="password" name="pw-new" id="pw-new" value="${userFix.userPw}"  required></td>
	</tr>
	<tr>
	<td>이름*</td>
	<td><input class="inputUserFix" type="text" name="name" id="name" value="${userFix.userName}" required></td>
	</tr>
	<tr>
	<td>닉네임*</td>
	<td><input type="text" class="inputUserFix" name="nickName" id="nickName" value="${userFix.userNickName}" required><input type="hidden" id="originalNickNameHidden" data-original-id="${userFix.userNickName}"></td>
	<td><button class="btn-checkNickName" name="btn-checkNickName" id="btn-checkNickName">닉네임 중복검사</button></td>
	</tr>
	<tr>
	<td>이메일*</td>
	<td><input type="text" class="inputUserFix" name="email" id="email"  value="${userFix.userEmail}"><input type="hidden" id="originalEmailHidden" data-original-id="${userFix.userEmail}"></td>
	<td><button class="btn-checkEmail" name="btn-checkEmail" id="btn-checkEmail"  onclick="email_ok(email.value)">이메일인증</button></td>
	</tr>
	<tr>
	<td><div id="countdown"></div></td>
	<td><input type="text" class="inputUserFix" name="checkEmailOk" id="checkEmailOk"></td>
	<td><button class="btn-checkEmailOk" name="btn-checkEmailOk" id="btn-checkEmailOk" placeholder="인증번호를 입력해주세요">인증완료</button></td>
	</tr>
	<tr>
	<td>전화번호</td>
	<td><input type="text" class="inputUserFix" name="phone" id="phone" value="${userFix.userPhone }"></td>
	</tr>

	<tr>
	<td>프로필 사진</td>
	<td><label for="uploadFile" class="fileLabel">파일 선택</label>
	<input type="file" class="inputFileHidden"  name="uploadFile" id="uploadFile" accept="image/*"  onchange="tryImgPreview(event)" >
	<input type="hidden" id="originalImgHidden" data-original-id="${userFix.userImg}" name="originalImgHidden" value="${userFix.userImg}">
	</td>
	<td><button class="btn-imgDel" name="btn-imgDel" id="btn-imgDel">이미지삭제</button></td>
	
	<script>

	</script>
	
	</tr>
	<tr><td colspan="3">
	
	<div id="imgPreview">
	<c:choose>
		<c:when test="${not empty userFix.userImg}">
			<img src="${ctx}/img/${userFix.userImg}" class="photo"
				id="userImg" />
		</c:when>
		<c:otherwise>
			<img src="${ctx}/img/ProfileBasicImg.png" class="photo"
				id="default" />
		</c:otherwise>
	</c:choose>
	</div>
	</td></tr>
	</table>
	
	<button class="btn-submit" name="btn-submit" id="btn-submit">수정완료</button>
	</form>
	</div>
	
<!-- 	<script>
	let testId="${user.userPw}";
	console.log("testId="+testId);
	</script> -->

<script src="${ctx}/js/user/userFix.js"> </script>
<%@ include file="../../part/footer.jsp" %>