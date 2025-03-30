package kr.smartReciFit.controller.user;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.smartReciFit.controller.Controller;
import kr.smartReciFit.model.user.UserDAO;
import kr.smartReciFit.model.user.UserInfoDAO;

public class UserInfoFixController implements Controller {

	@Override
	public String requestHandler(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		System.out.println("유저 인포 수정 컨트롤러 진입");
		HttpSession session = request.getSession();
		String ctx=request.getContextPath();
		PrintWriter out = response.getWriter();
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		Integer num=(Integer)session.getAttribute("log");
		int userNum=-1;
		
		if (num!=null) {
//			userNum=Integer.parseInt(request.getParameter("num"));
			userNum=(int)num;
		}else {
			System.out.println("오류발생");
			return "redirect:"+ctx+"/recipes.do";
		}
		
		System.out.println("Fix userNum="+userNum);
		session.setAttribute("log", userNum);
		
		if (session.getAttribute("firstInUserInfoFix")==null||(Boolean)session.getAttribute("firstInUserInfoFix")==false) {
			System.out.println("첫 진입");
			
			double userMealSize=Double.parseDouble(request.getParameter("userMealSize"));
			System.out.println("userNum="+userNum);
			System.out.println("userMealSize="+userMealSize );
			String[]list=request.getParameterValues("list");
	        System.out.println("list: " + Arrays.toString(list));
	        
	        request.setAttribute("userNum", userNum);
	        request.setAttribute("userMealSize", userMealSize);
	        request.setAttribute("list", list);
			
			session.setAttribute("firstInUserInfoFix", true);
			return "userInfoFix";
		}
        
		System.out.println("두번째 진입, 리셋");
		session.setAttribute("firstInUserInfoFix", false);
		
		String mealSize= request.getParameter("mealSize");
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
        

		//userNum에 업데이트하기
		//받아온 userNum 넣어서 나머지 데이터 입력해 userInfo 넣기
        int result=UserInfoDAO.getInstance().updateUserInfo(userNum, mealSizeInt, ingredient, cookingStyle, cookingMethod, eatTime);
        System.out.println("result 1이면 수정완료 0이면 실패:"+result);
        
        if (result==0) {
			System.out.println("UserInfoFix 오류");
			
			out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
			out.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js'></script>");
			out.println("<script>");
			out.println("window.onload = function() {");
			out.println("  Swal.fire({");
			out.println("icon: 'error',");
			out.println("title: 'TAG 수정 실패!',");
			out.println("text: '입력값을 확인해주세요.',");
			out.println("confirmButtonColor: '#777777',}).then(function() {");
//			out.println("location.href='" + ctx + "/userContent.do';");
			out.println("    history.go(-1);");
			out.println("  });");
			out.println("};");
			out.println("</script>");
			
		}else {
			System.out.println("UserInfo 수정 완료");
			//스윗머시기 띄워야지
			
			out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
			out.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js'></script>");
			out.println("<script>");
			out.println("window.onload = function() {");
			out.println("  Swal.fire({");
			out.println("icon: 'success',");
			out.println("title: 'TAG 수정 성공!',");
			out.println("text: '마이페이지에서 확인해주세요.',");
			out.println("confirmButtonColor: '#3CB371',}).then(function() {");
			out.println("location.href='" + ctx + "/userContent.do';");
//			out.println("    history.go(-1);");
			out.println("  });");
			out.println("};");
			out.println("</script>");
			
		}
        return null;
	}
}
