package kr.smartReciFit.controller.user;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.smartReciFit.controller.Controller;
import kr.smartReciFit.model.user.User;
import kr.smartReciFit.model.user.UserDAO;
import kr.smartReciFit.model.user.UserInfo;
import kr.smartReciFit.model.user.UserInfoDAO;

public class LoginCheckController implements Controller {

	@Override
	public String requestHandler(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			System.out.println("LoginCheckController 진입");
			String id = request.getParameter("id");
	        String pw = request.getParameter("pw");

	        User user = new User();
	        user.setUserId(id);
	        user.setUserPw(pw);

	        String result = UserDAO.getInstance().userLogin(user);
	        System.out.println("result = "+result);

	        response.setCharacterEncoding("UTF-8");
	        response.setContentType("text/plain");

	        if (result != null) {
	        	  HttpSession session = request.getSession();
	        	  String nickName = UserDAO.getInstance().getNickName(id);
	        	   int userNum=(int)UserDAO.getInstance().checkId(id);
	        	   user = UserDAO.getInstance().numGetUser(userNum);
	        	   UserInfo userInfo = UserInfoDAO.getInstance().numGetUserInfo(userNum);
	        	   if(userInfo != null) {
	        		   session.setAttribute("userMealSize", userInfo.getUserMealSize());
	        	   }
	        	   
	        	   session.setAttribute("user", user); // User 객체를 세션에 저장
	        	   System.out.println(user);
	        	   System.out.println("------------------------");
	        	   session.setAttribute("log", userNum); // 로그에 사용자 num 저장
	        	   session.setAttribute("nickName", nickName);
	        	   System.out.println(session.getAttribute("nickName"));
	        	   System.out.println(session.getAttribute("log"));
	        	   
	               // 연동된 소셜 계정 상태 확인
	               Map<String, Boolean> linkedAccounts = new HashMap<>();
	               
	               if (UserDAO.getInstance().isKakaoLinked(userNum)) {
	                   linkedAccounts.put("kakao", true);
	               }
	               if (UserDAO.getInstance().isNaverLinked(userNum)) {
	                   linkedAccounts.put("naver", true);
	               }
	               if (UserDAO.getInstance().isGoogleLinked(userNum)) {
	                   linkedAccounts.put("google", true);
	               }
	               
	               session.setAttribute("linkedAccounts", linkedAccounts); // linkedAccounts 세션에 저장
	               
	        	// 관리자 로그인 확인
	               if ("admin".equals(user.getUserId())) {
	                   response.getWriter().write("admin_success"); // 관리자 로그인 성공
	               } else {
	                   response.getWriter().write("success"); // 일반 로그인 성공
	               }
	           } else {
	               response.getWriter().write("failure"); // 로그인 실패
	           }
	           return null; // 응답을 직접 보냈으므로 뷰를 반환하지 않음
	       }
	   }


