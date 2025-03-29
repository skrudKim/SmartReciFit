package kr.smartReciFit.controller.user;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.smartReciFit.controller.Controller;
import kr.smartReciFit.model.user.UserDAO;
import kr.smartReciFit.model.user.UserInfoDAO;

public class UserInfoController implements Controller {

	@Override
	public String requestHandler(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//user 갖고 와서...
		System.out.println("유저 인포 진입");
		
		PrintWriter out = response.getWriter();
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		HttpSession session = request.getSession();
		Integer log=(Integer)session.getAttribute("log");
		System.out.println("현재 로그인 상태: "+log);
		String ctx=request.getContextPath();
        String mealSize= request.getParameter("mealSize");

        if (mealSize==null) {
        	System.out.println("값이 아무것도 없는 상태");
        	return "userInfo";
		}
        
        System.out.println("값이 들어온 상태");
        double mealSizeInt= Double.parseDouble(mealSize);
        System.out.println("mealSizeDouble="+mealSizeInt);
        System.out.println(mealSize);
        
        String[]itemMain=request.getParameterValues("itemMain");
        String[]itemMeat=request.getParameterValues("itemMeat");
        String[]itemVegitable=request.getParameterValues("itemVegitable");
        String[]itemContry=request.getParameterValues("itemContry");
        String[]itemCook=request.getParameterValues("itemCook");
        String[]itemTime=request.getParameterValues("itemTime");
        System.out.println(Arrays.toString(itemMain));
        System.out.println(Arrays.toString(itemMeat));
        System.out.println(Arrays.toString(itemVegitable));
        System.out.println(Arrays.toString(itemContry));
        System.out.println(Arrays.toString(itemCook));
        System.out.println(Arrays.toString(itemTime));
        
        int mainLength=itemMain==null?0:itemMain.length;
        int meatLength=itemMeat==null?0:itemMeat.length;
        int vegitableLength=itemVegitable==null?0:itemVegitable.length;
        System.out.println("메인길이:"+mainLength);
        System.out.println("미트길이:"+meatLength);
        System.out.println("야채길이:"+vegitableLength);
        
        String[]ingredientList=new String[mainLength+meatLength+vegitableLength];
        int cnt=0;
        if (mainLength!=0) {
        	for(String main:itemMain) {
        		ingredientList[cnt++]=main;
        	}
		}
        if (meatLength!=0) {
        	for(String meat:itemMeat) {
        		ingredientList[cnt++]=meat;
        	}
		}
        if (vegitableLength!=0) {
        	for(String veg:itemVegitable) {
        		ingredientList[cnt++]=veg;
        	}
		}
        System.out.println("메인재료 합친거:"+Arrays.toString(ingredientList));
        System.out.println("다 넣었는지 체크: "+(mainLength+meatLength+vegitableLength)+"/"+cnt);
        
        String ingredient=ingredientList.length!=0?String.join("|", ingredientList):null;
        String cookingStyle = itemContry!=null?String.join("|", itemContry):null;
        String cookingMethod = itemCook!=null?String.join("|", itemCook):null;
        String eatTime = itemTime!=null?String.join("|", itemTime):null;
        
        System.out.println("String으로 만든 ingredient: "+ingredient);
        System.out.println("String으로 만든 cookingStyle: "+cookingStyle);
        System.out.println("String으로 만든 cookingMethod: "+cookingMethod);
        System.out.println("String으로 만든 eatTime: "+eatTime);

		//log가 null인지 확인하고
		//log가 null이 아니면 userNum 에 넣어서 추가 아니면
		//user DAO에서 제일 마지막에 추가된 user_Num 받아오기
		int userNum=log==null?UserDAO.getInstance().getLastUserNum():(int)log;
		System.out.println("넣게 될 userNum: "+userNum);
		
		//받아온 userNum 넣어서 나머지 데이터 입력해 userInfo 넣기
        int result=UserInfoDAO.getInstance().insertUserInfo(userNum, mealSizeInt, ingredient, cookingStyle, cookingMethod, eatTime);
        System.out.println("result 1이면 수정완료 0이면 실패:"+result);
        
        if (result==0) {
			System.out.println("UserInfoInsert 오류");
			out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
			out.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js'></script>");
			out.println("<script>");
			out.println("window.onload = function() {");
			out.println("  Swal.fire({");
			out.println("icon: 'error',");
			out.println("title: '오류 발생!',");
			out.println("text: 'TAG 입력에 실패했습니다.',");
			out.println("confirmButtonColor: '#777777}).then(function() {");
			out.println("    history.go(-1);");
			out.println("  });");
			out.println("};");
			out.println("</script>");
			out.println("history.go(-1); </script>"); 
        	//return "userInfo";
		}else {
			System.out.println("UserInfo 삽입완료");
			//스윗머시기 띄워야지
//			out.println("<script> Swal.fire({title: '회원가입 완료!',text: '저희 사이트에 가입해주셔서 감사합니다.',icon: 'success', confirmButtonText: '확인'});");
			if (log==null) {
				out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
				out.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js'></script>");
				out.println("<script>");
				out.println("window.onload = function() {");
				out.println("  Swal.fire({");
				out.println("icon: 'success',");
				out.println("title: '회원 가입 성공!',");
				out.println("text: 'SmartReciFit에 오신 것을 환영합니다.',");
				out.println("confirmButtonColor: '#3CB371',}).then(function() {");
				out.println("location.href='" + ctx + "/index.jsp';");
				out.println("  });");
				out.println("};");
				out.println("</script>");
			}else {
				out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
				out.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js'></script>");
				out.println("<script>");
				out.println("window.onload = function() {");
				out.println("  Swal.fire({");
				out.println("icon: 'success',");
				out.println("title: 'TAG 입력 성공!',");
				out.println("text: '마이페이지에서 확인해주세요.',");
				out.println("confirmButtonColor: '#3CB371',}).then(function() {");
				out.println("location.href='" + ctx + "/userContent.do';");
//				out.println("    history.go(-1);");
				out.println("  });");
				out.println("};");
				out.println("</script>");
			}
//			return "redirect:" + ctx + "/index.jsp";
		}
        return null;
	}
}
