package kr.smartReciFit.controller.admin;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.smartReciFit.controller.Controller;
import kr.smartReciFit.model.user.UserDAO;

public class AdminUserController implements Controller {

    @Override
    public String requestHandler(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	System.out.println("AdminUserController 진입");
        UserDAO dao = UserDAO.getInstance();
        String ctx=request.getContextPath();
        if (request.getRequestURI().contains("deleteUser.do")) {
            // 회원 삭제
        	System.out.println("삭제 할것");
            String userId = request.getParameter("userId");
            dao.deleteUser(userId);
            return "userList"; // 삭제 후 이전 페이지로 리다이렉트

        } else {
            // 페이징 처리
            int page = 1;
            int pageSize = 10; // 페이지당 회원 수
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
            }

            // 전체 회원 수 조회
            int totalCount = dao.getUserCount();
            int totalPages = (int) Math.ceil((double) totalCount / pageSize);

            // 페이징된 회원 목록 조회
            ArrayList<HashMap<String, Object>> userList = dao.getPagedUserList(page, pageSize);

            // 요청 속성에 데이터 추가
            request.setAttribute("userList", userList);
            request.setAttribute("totalCount", totalCount);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", page);

            return "userList"; // 전체 회원 목록 JSP 페이지
        }
    }
}