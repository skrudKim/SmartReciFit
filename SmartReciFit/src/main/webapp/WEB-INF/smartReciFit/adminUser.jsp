<%@page import="java.util.ArrayList"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../part/adminHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 목록</title>
    <link rel="stylesheet" type="text/css" href="${ctx}/css/adminStyle.css">
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
</head>
<body>
    <div class="container">
        <div class="admin-menu">
            <jsp:include page="menu.jsp" />
        </div>
        <div class="user-list-content">
            <h2>관리자 목록</h2>
            <p>전체 관리자 수: ${totalCount}</p>
            <table>
                <thead>
                    <tr>
                        <th>회원번호</th>
                        <th>아이디</th>
                        <th>닉네임</th>
                        <th>이메일</th>
                        <th>전화번호</th>
                        <th>삭제</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${userList}">
                        <tr>
                            <td>${user.user_num}</td>
                            <td>${user.user_id}</td>
                            <td>${user.user_nickname}</td>
                            <td>${user.user_email}</td>
                            <td>${user.user_phone}</td>
                            <td><button onclick="deleteUser('${user.user_id}')">삭제</button></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="pagination">
                <c:if test="${currentPage > 1}">
                    <a href="${ctx}/adminUser.do?page=${currentPage - 1}">이전</a>
                </c:if>
                <c:forEach var="i" begin="1" end="${totalPages}">
                    <a href="${ctx}/adminUser.do?page=${i}" ${currentPage == i ? 'class="active"' : ''}>${i}</a>
                </c:forEach>
                <c:if test="${currentPage < totalPages}">
                    <a href="${ctx}/adminUser.do?page=${currentPage + 1}">다음</a>
                </c:if>
            </div>
        </div>
    </div>
    <script>
    function deleteUser(userId) {
        if (confirm("정말 삭제하시겠습니까?")) {
            // 삭제 요청을 AdminUserController로 보냄
            fetch("${ctx}/deleteUser.do?userId=" + userId)
                .then(response => {
                    if (response.ok) {
                        // 삭제 성공 시 userList.do 페이지로 이동
                        location.href = "${ctx}/adminUser.do";
                    } else {
                        alert("삭제에 실패했습니다.");
                    }
                })
                .catch(error => {
                    console.error("삭제 요청 중 오류 발생:", error);
                    alert("삭제 요청 중 오류가 발생했습니다.");
                });
        }
    }
    
    </script>
</body>
</html>
