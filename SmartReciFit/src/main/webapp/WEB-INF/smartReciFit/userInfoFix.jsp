<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Arrays" %>

<!DOCTYPE html>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<%@ include file="../../part/header.jsp"%>
<% 
    String[] list = (String[]) request.getAttribute("list");
	double userMealSize = (Double) request.getAttribute("userMealSize"); // 서버에서 식사량 값을 가져옴
	System.out.println("userMealSize2="+userMealSize );
    System.out.println("list2: " + Arrays.toString(list));
%>


<div class="inner">
    <h2>내 태그 수정하기</h2>
    <form id="userInfoForm" method="post" action="userInfoFix.do">
        <p>평소 식사량을 선택해 주세요. 해당 정보를 기반으로 레시피의 재료양이 수정됩니다.</p>
        <div class="checkMealSize" id="box-mealSixe">
            <input type="radio" name="mealSize" value="0.5"> 0.5인분
            <input type="radio" name="mealSize" value="0.7"> 0.7인분
            <input type="radio" name="mealSize" value="1.0" checked="checked"> 1인분
            <input type="radio" name="mealSize" value="1.2"> 1.2인분
            <input type="radio" name="mealSize" value="1.4"> 1.5인분
            <input type="radio" name="mealSize" value="2.0"> 2인분
        </div>

        <p>좋아하는 재료를 선택해주세요. 추천 알고리즘의 기반이 됩니다.<br>
            총 5가지를 선택할 수 있으며 최소 1가지를 선택해주세요.<br>
            한 카테고리에 여러 재료를 선택하는 것도 가능합니다.</p>

        <div class="checkItem" id="box-itemMain">
            <h3>메인 재료</h3>
            <input type="checkbox" name="itemMain" value="쌀">쌀
            <input type="checkbox" name="itemMain" value="곡류">곡류
            <input type="checkbox" name="itemMain" value="달걀">달걀
            <input type="checkbox" name="itemMain" value="가공식품">가공식품
            <input type="checkbox" name="itemMain" value="유제품">유제품
            <input type="checkbox" name="itemMain" value="육류">육류
        </div>

        <div class="checkItem" id="box-itemMeat">
            <h3>고기</h3>
            <input type="checkbox" name="itemMeat" value="돼지고기">돼지고기
            <input type="checkbox" name="itemMeat" value="소고기">소고기
            <input type="checkbox" name="itemMeat" value="양고기">양고기
            <input type="checkbox" name="itemMeat" value="닭고기">닭고기
            <input type="checkbox" name="itemMeat" value="해산물">해산물
        </div>

        <div class="checkItem" id="box-itemVegitable">
            <h3>채소</h3>
            <input type="checkbox" name="itemVegitable" value="채소">채소
            <input type="checkbox" name="itemVegitable" value="과일">과일
            <input type="checkbox" name="itemVegitable" value="버섯">버섯
        </div>

        <div class="checkItem" id="box-itemContry">
            <h3>국가</h3>
            <input type="checkbox" name="itemContry" value="양식">양식
            <input type="checkbox" name="itemContry" value="한식">한식
            <input type="checkbox" name="itemContry" value="중식">중식
            <input type="checkbox" name="itemContry" value="일식">일식
            <input type="checkbox" name="itemContry" value="아시안식">아시안식
        </div>

        <div class="checkItem" id="box-itemCook">
            <h3>조리방법</h3>
            <input type="checkbox" name="itemCook" value="볶음">볶음
            <input type="checkbox" name="itemCook" value="조림">조림
            <input type="checkbox" name="itemCook" value="탕">탕
            <input type="checkbox" name="itemCook" value="튀김">튀김
            <input type="checkbox" name="itemCook" value="샐러드">샐러드
            <input type="checkbox" name="itemCook" value="찜">찜
            <input type="checkbox" name="itemCook" value="구이">구이
        </div>

        <div class="checkItem" id="box-itemTime">
            <h3>시간</h3>
            <input type="checkbox" name="itemTime" value="아침">아침
            <input type="checkbox" name="itemTime" value="점심">점심
            <input type="checkbox" name="itemTime" value="저녁">저녁
            <input type="checkbox" name="itemTime" value="야식">야식
            <input type="checkbox" name="itemTime" value="간식">간식
        </div>
    </form>
    <button name="btn-infoCancel" id="btn-infoCancel">입력취소</button>
    <button name="btn-infoSubmit" id="btn-infoSubmit">검사완료</button>
</div>

<script>
    $(document).ready(function() {
    	
        // 식사량 라디오 버튼 초기 선택
        //문자열을 숫자형으로 변환
        const mealSize = parseFloat("<%= userMealSize %>"); 
        $(`input[name="mealSize"]`).each(function() {
            if (parseFloat(this.value) === mealSize) { // 숫자형으로 비교
                this.checked = true;
            }
        });
        
    	console.log("mealSize: "+mealSize);
    	
        const listString = "<%= Arrays.toString(list) %>";
        const list = listString.substring(1, listString.length - 1).split(', '); // JavaScript 배열로 변환
        
    	console.log("list: "+list);

        // 모든 체크박스에 대해 반복하며 선택된 값과 비교하여 체크
        $('input:checkbox').each(function() {
            if (list && list.indexOf(this.value) !== -1) {
                this.checked = true;
            }
        });
        
    });
</script>

<script src="${ctx}/js/user/userInfoFix.js"></script>
<%@ include file="../../part/footer.jsp"%>