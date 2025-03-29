package kr.smartReciFit.controller.user;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.smartReciFit.controller.Controller;
import kr.smartReciFit.model.user.User;
import kr.smartReciFit.model.user.UserDAO;
import kr.smartReciFit.model.user.UserInfo;
import kr.smartReciFit.model.user.UserInfoDAO;

public class UserContentController implements Controller {

	@Override
	public String requestHandler(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//user 갖고 와서...
		System.out.println(" 마이페이지 진입");
		HttpSession session = request.getSession();
		String ctx=request.getContextPath();
		
		int num =-1;
		//String getNum=request.getParameter("num");
		//System.out.println("UserContentController의 num"+getNum);
		Integer getLog=(Integer)session.getAttribute("log");
		System.out.println("UserContentController의 log"+getLog);
		if(getLog==null){
			return "redirect:"+ctx+"/recipes.do";
		}else{
			num = (int)getLog;
		}
		User vo=UserDAO.getInstance().numGetUser(num);
//		System.out.println("테스트옹 vo: "+vo);
		request.setAttribute("userContent", vo);
		
		//num으로 userInfo 테이블 검색
		UserInfo voInfo=UserInfoDAO.getInstance().numGetUserInfo(num);
		request.setAttribute("userInfoContent", voInfo);
		
		//있으면 가져오고 없으면 null로 반환하기
		if (voInfo==null) {
			System.out.println("voInfo 정보없음");
			return "userContent";
		}else {
			Double voMealSize=(Double)voInfo.getUserMealSize();
			request.setAttribute("userInfoMealSize", voMealSize);
			String voIngredient=voInfo.getIngredient();
			String voCookingStyle=voInfo.getCookingStyle();
			String voCookingMethod=voInfo.getCookingMethod();
			String voEatTime=voInfo.getEatTime();
			System.out.println(voIngredient);
			
			String[] voIngredientList = null;
			String[] voCookingStyleList = null;
			String[] voCookingMethodList = null;
			String[] voEatTimeList = null;
			
			ArrayList<String> totalInfo=new ArrayList<String>(); 
			
			//문자열을 배열로 쪼개기
			if(voIngredient!=null) {
				voIngredientList = voIngredient.split("\\|");
				System.out.println("voIngredientList: "+Arrays.toString(voIngredientList));
		        for (String info : voIngredientList) {
		            totalInfo.add(info);
		        }
			}
			if(voCookingStyle!=null) {
				voCookingStyleList = voCookingStyle.split("\\|");
				System.out.println("voCookingStyleList: "+Arrays.toString(voCookingStyleList));
		        for (String info : voCookingStyleList) {
		            totalInfo.add(info);
		        }
			}
			if(voCookingMethod!=null) {
				voCookingMethodList = voCookingMethod.split("\\|");
				System.out.println("voCookingMethodList: "+Arrays.toString(voCookingMethodList));
		        for (String info : voCookingMethodList) {
		            totalInfo.add(info);
		        }
			}
			if(voEatTime!=null) {
				voEatTimeList = voEatTime.split("\\|");
				System.out.println("voEatTimeList: "+Arrays.toString(voEatTimeList));
				for (String info : voEatTimeList) {
		            totalInfo.add(info);
		        }
			}
			System.out.println("totalInfo: " + totalInfo.toString());
			request.setAttribute("totalInfo", totalInfo);
			
			return "userContent";
			
		}
	}
}
