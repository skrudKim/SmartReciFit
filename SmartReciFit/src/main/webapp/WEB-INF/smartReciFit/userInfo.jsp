<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>

<!-- 예쁜 알람창용 스크립트 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<%-- <%
    boolean isLogin = (session.getAttribute("log") != null);
%> --%>

<script>
$(document).ready(function() {
<%-- 	
    let isLogin = <%= isLogin %>; // JavaScript 변수에 로그인 상태 전달
	console.log("isLogin="+isLogin);
	 --%>
/*  if (!isLogin||isLogin==='false') { */
		Swal.fire({
			icon: "info",
			title: "선호TAG를 입력하시겠습니까?",
			text: "마이페이지에 기록해둘 수 있습니다",
			showDenyButton: true,
			showCancelButton: false,
			confirmButtonText: "네, 입력할게요",
			denyButtonText: "입력하지 않을래요"
			confirmButtonColor: '#3CB371',
			denyButtonColor: '#777777'
		}).then((result) => {
			if (result.isConfirmed) {
				console.log("입력하기 선택");
			} else if (result.isDenied) {
				console.log("입력안하기 선택");
		        Swal.fire({
					title: "회원가입 완료!",
		            text: "저희 사이트에 가입해주셔서 감사합니다.",
		            icon: "success",
		            confirmButtonText: "확인"
		        }).then(() => {
					window.location.href = "index.jsp";
		        });
			}
		});
/* 	} */
}
</script>


<%@ include file="../../part/header.jsp"%>

        <h2> 선호TAP 입력하기 </h2>
      <div class="inner">
		<form id="userInfoForm" method="post" action="userInfo.do">
		<p> 평소 식사량을 골라주세요. 해당 정보를 기반으로 레시피의 재료양이 수정됩니다.</p>
		<div class=checkMealSize id=box-mealSixe>	
        <input type="radio" class="infoRadio" name="mealSize" value="0.5"> 0.5인분
        <input type="radio" class="infoRadio" name="mealSize" value="0.7"> 0.7인분
        <input type="radio" class="infoRadio" name="mealSize" value="1.0" checked="checked"> 1인분
        <input type="radio" class="infoRadio" name="mealSize" value="1.2"> 1.2인분
        <input type="radio" class="infoRadio" name="mealSize" value="1.4"> 1.5인분
        <input type="radio" class="infoRadio" name="mealSize" value="2.0"> 2인분
        </div>
        
		<p> 좋아하는 재료를 선택해주세요. 추천 알고리즘의 기반이 됩니다.<br>
		총 5가지를 선택할 수 있으며 최소 1가지를 선택해주세요. 한 카테고리에 여러 재료를 선택하는 것도 가능합니다. </p>
        
        <h3>메인 재료</h3>
		<div class=checkItem id=box-itemMain>	
		<input type="checkbox" class="infoCheckbox" name="itemMain" value="쌀">쌀
		<input type="checkbox" class="infoCheckbox" name="itemMain" value="곡류">곡류
		<input type="checkbox" class="infoCheckbox" name="itemMain" value="달걀">달걀
		<input type="checkbox" class="infoCheckbox" name="itemMain" value="가공식품">가공식품
		<input type="checkbox" class="infoCheckbox" name="itemMain" value="유제품">유제품
		<input type="checkbox" class="infoCheckbox" name="itemMain" value="육류">육류
		</div>
		
        <h3>고기</h3>
		<div class=checkItem id=box-itemMeat>	
		<input type="checkbox" class="infoCheckbox" name="itemMeat" value="돼지고기">돼지고기
		<input type="checkbox" class="infoCheckbox" name="itemMeat" value="소고기">소고기
		<input type="checkbox" class="infoCheckbox" name="itemMeat" value="양고기">양고기
		<input type="checkbox" class="infoCheckbox" name="itemMeat" value="닭고기">닭고기
		<input type="checkbox" class="infoCheckbox" name="itemMeat" value="해산물">해산물
		</div>
		
        <h3>채소</h3>
		<div class=checkItem id=box-itemVegitable>	
		<input type="checkbox" class="infoCheckbox" name="itemVegitable" value="채소">채소
		<input type="checkbox" class="infoCheckbox" name="itemVegitable" value="과일">과일
		<input type="checkbox" class="infoCheckbox" name="itemVegitable" value="버섯">버섯
		</div>
		
        <h3>국가</h3>
		<div class=checkItem id=box-itemContry>	
		<input type="checkbox" class="infoCheckbox" name="itemContry" value="양식">양식
		<input type="checkbox" class="infoCheckbox" name="itemContry" value="한식">한식
		<input type="checkbox" class="infoCheckbox" name="itemContry" value="중식">중식
		<input type="checkbox" class="infoCheckbox" name="itemContry" value="일식">일식
		<input type="checkbox" class="infoCheckbox" name="itemContry" value="아시안식">아시안식
		</div>
		
        <h3>조리방법</h3>
		<div class=checkItem id=box-itemCook>	
		<input type="checkbox" class="infoCheckbox" name="itemCook" value="볶음">볶음
		<input type="checkbox" class="infoCheckbox" name="itemCook" value="조림">조림
		<input type="checkbox" class="infoCheckbox" name="itemCook" value="탕">탕
		<input type="checkbox" class="infoCheckbox" name="itemCook" value="튀김">튀김
		<input type="checkbox" class="infoCheckbox" name="itemCook" value="샐러드">샐러드
		<input type="checkbox" class="infoCheckbox" name="itemCook" value="찜">찜
		<input type="checkbox" class="infoCheckbox" name="itemCook" value="구이">구이
		</div>
		
        <h3>시간</h3>
		<div class=checkItem id=box-itemTime>	
		<input type="checkbox" class="infoCheckbox" name="itemTime" value="아침">아침
		<input type="checkbox" class="infoCheckbox" name="itemTime" value="점심">점심
		<input type="checkbox"  class="infoCheckbox" name="itemTime" value="저녁">저녁
		<input type="checkbox" class="infoCheckbox" name="itemTime" value="야식">야식
		<input type="checkbox" class="infoCheckbox" name="itemTime" value="간식">간식
		</div>
	</form>
		<button name="btn-infoSubmit" id="btn-infoSubmit">검사완료</button>
		<button name="btn-infoCancel" id="btn-infoCancel">입력취소</button>
    </div>
    
<script src="${ctx}/js/user/userInfo.js"> </script>

<%@ include file="../../part/footer.jsp"%>