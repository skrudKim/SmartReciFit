package kr.smartReciFit.controller.user;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.smartReciFit.controller.Controller;
import kr.smartReciFit.model.user.User;
import kr.smartReciFit.model.user.UserDAO;

public class UnlinkButtonController implements Controller {

	@Override
	public String requestHandler(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	       System.out.println("unLinkButtonController 진입");
	        String platform = request.getParameter("platform");
	        HttpSession session = request.getSession();
	        User user = (User) session.getAttribute("user");
	        PrintWriter out = response.getWriter();
	        if (user != null) {
	            boolean unlinked = UserDAO.getInstance().unlinkSocialAccount(user.getUserNum(), platform);
	            if (unlinked) {
	                // 추가: 연동된 소셜 계정이 하나도 없으면 social 테이블에서 삭제
	                Map<String, Boolean> linkedAccounts = UserDAO.getInstance().getLinkedSocialAccounts(user.getUserNum());
	                // null 체크 및 기본값 설정
	                boolean kakaoLinked = linkedAccounts.get("kakao") != null ? linkedAccounts.get("kakao") : false;
	                boolean naverLinked = linkedAccounts.get("naver") != null ? linkedAccounts.get("naver") : false;
	                boolean googleLinked = linkedAccounts.get("google") != null ? linkedAccounts.get("google") : false;

	                // 조건문에서 삭제 처리
	                if (!kakaoLinked && !naverLinked && !googleLinked) {
	                    UserDAO.getInstance().deleteSocialAccount(user.getUserNum());
	                }

	                session.setAttribute("linkedAccounts", linkedAccounts);
	                out.print("success");
	            } else {
	                out.print("fail");
	            }
	        } else {
	            out.print("fail");
	        }
	        out.close();
	        return null;
	    }
	}