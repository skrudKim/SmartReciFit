package kr.smartReciFit.controller.admin;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.smartReciFit.controller.Controller;
import kr.smartReciFit.model.user.UserDAO;

public class AdminManagerUserController implements Controller {

	@Override
	public String requestHandler(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("AdminManagerUserController 진입");
		String ctx = request.getContextPath();
		UserDAO dao = UserDAO.getInstance();
		if (request.getRequestURI().contains("deleteUser.do")) {
			// 회원 삭제
			String userId = request.getParameter("userId");
			dao.deleteUser(userId);
			return "adminUser";
		} else {
			// 페이징 처리
			int page = 1;
			int pageSize = 10; // 페이지당 회원 수
			String pageParam = request.getParameter("page");
			if (pageParam != null && !pageParam.isEmpty()) {
				page = Integer.parseInt(pageParam);
			}

			// 전체 관리자 수 조회
			int totalCount = dao.getAdminCount();
			int totalPages = (int) Math.ceil((double) totalCount / pageSize);

			// 페이징된 관리자 목록 조회
			ArrayList<HashMap<String, Object>> adminList = dao.getPagedAdminList(page, pageSize);
			
			

			// 요청 속성에 데이터 추가
			request.setAttribute("userList", adminList);
			request.setAttribute("totalCount", totalCount);
			request.setAttribute("totalPages", totalPages);
			request.setAttribute("currentPage", page);
			System.out.println(request.getAttribute("userList"));

			return "adminUser"; // 관리자 목록 JSP 페이지
		}
	}
}