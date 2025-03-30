package kr.smartReciFit.controller.user;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.smartReciFit.controller.Controller;
import kr.smartReciFit.model.user.SocialDTO;
import kr.smartReciFit.model.user.SocialLoginDTO;
import kr.smartReciFit.model.user.User;
import kr.smartReciFit.model.user.UserDAO;

public class SaveSocialLoginInfo implements Controller {

	 @Override
	    public String requestHandler(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {

	        System.out.println("SaveSocialLoginInfo 진입");

	        // 소셜 로그인 정보 가져오기
	        String platform = request.getParameter("platform");
	        String nickname = request.getParameter("nickname");
	        String email = request.getParameter("email");

	        System.out.println("======소셜로그인 정보 확인구간=====");
	        System.out.println("플랫폼: " + platform);
	        System.out.println("닉네임: " + nickname);
	        System.out.println("이메일: " + email);
	        System.out.println("=============================");

	        HttpSession session = request.getSession();
	        
	        User user = (User) session.getAttribute("user");
	        PrintWriter out = response.getWriter();
			if (user != null) {
				System.out.println(platform);
				System.out.println(email);

				boolean linked = UserDAO.getInstance().linkSocialAccount(user.getUserNum(), platform, email);

				if (linked) {
				    Map<String, Boolean> linkedAccounts = UserDAO.getInstance().getLinkedSocialAccounts(user.getUserNum());
				    session.setAttribute("linkedAccounts", linkedAccounts);
				    System.out.println("연동 성공");
				}else {
					session.setAttribute("message", "이미 연동된 계정입니다.");
				}
				out.close();
				return null;
			}

	        UserDAO userDAO = UserDAO.getInstance();

	        // ✅ social 테이블에서 이메일 확인 (기존 소셜 계정인지 체크)
	        SocialDTO existingSocial = userDAO.getSocialByEmail(email);
	        System.out.println(existingSocial); // NULL이면 신규, NULL이 아니면 기존
	        response.setContentType("text/plain");
	        
	        
	        int userNum;
	        if (existingSocial != null) { // 소셜로그인 한번이라도 한 자면,
	            userNum = existingSocial.getUserNum(); // 기존 유저면 그대로 로그인 진행
	        } else { // 소셜로그인 안한 유저
	            // ✅ 닉네임 중복 검사 (모든 신규 유저에 대해 실행)
	            if (userDAO.checkNickName(nickname) != null) {
	                request.setAttribute("nicknameExists", true);
	                request.setAttribute("platform", platform);
	                request.setAttribute("email", email);
	                request.setAttribute("nickname", nickname);
	                session.setAttribute("platform", platform);
	                session.setAttribute("email", email);
	                System.out.println("닉네임 중복 if문");
	                out.print("닉네임 중복");
	                out.close();
	                return null; // 닉네임 입력 폼으로 이동
	                
	            }
	            // 닉네임이 중복되지 않으면 새로운 유저 생성
	            User newUser = new User();
	            newUser.setUserNickName(nickname);
	            userNum = userDAO.insertUserTableBySocial(newUser);
	            System.out.println("userNum : "+userNum);
	            newUser.setUserNum(userNum);

	            // 🔹 신규 userNum을 social 테이블에도 저장
	            SocialDTO socialDTO = new SocialDTO();
	            socialDTO.setUserNum(userNum);
	            if ("kakao".equals(platform))
	                socialDTO.setKakao(email);
	            else if ("naver".equals(platform))
	                socialDTO.setNaver(email);
	            else if ("google".equals(platform))
	                socialDTO.setGoogle(email);
	            
	            userDAO.InsertSocialInfo(socialDTO);
	            
	        }
            System.out.println("세션 저장하는 곳");
            
	        // ✅ 세션 저장 (로그인 처리)
	        User loggedInUser = userDAO.getUserByNum(userNum);
	        System.out.println(loggedInUser);
	        session.setAttribute("user", loggedInUser);
	        session.setAttribute("log", userNum);
	        session.setAttribute("nickName", loggedInUser.getUserNickName());
	        
	        // 소셜 계정 연동 상태 저장
	        Map<String, Boolean> linkedAccounts = new HashMap<>();
	        linkedAccounts.put(platform, true); // 연동한 플랫폼만 true로 설정
	        if(linkedAccounts.getOrDefault(platform, true)) {
	        	return "userContent";
	        }

	        // 다른 소셜 계정도 연동 여부 체크 (예: 카카오, 네이버, 구글)
	        if (userDAO.isKakaoLinked(userNum)) {
	            linkedAccounts.put("kakao", true);
	        }
	        if (userDAO.isNaverLinked(userNum)) {
	            linkedAccounts.put("naver", true);
	        }
	        if (userDAO.isGoogleLinked(userNum)) {
	            linkedAccounts.put("google", true);
	        }

	        session.setAttribute("linkedAccounts", linkedAccounts); // linkedAccounts 세션에 저장

	        System.out.println("세션 저장 완료: " + session.getAttribute("log") + " / " + session.getAttribute("nickName"));
	        

	            return "main";
			
	    }
	}