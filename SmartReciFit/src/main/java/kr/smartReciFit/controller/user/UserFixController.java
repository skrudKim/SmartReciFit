package kr.smartReciFit.controller.user;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import kr.smartReciFit.controller.Controller;
import kr.smartReciFit.model.user.User;
import kr.smartReciFit.model.user.UserDAO;

public class UserFixController implements Controller {

	@Override
	public String requestHandler(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		System.out.println("유저 정보 수정 컨트롤러 진입");
		HttpSession session = request.getSession();
		String ctx=request.getContextPath();
		
		Integer userNum=(Integer)session.getAttribute("log");
		System.out.println("유저픽스컨트롤러의  UserNum"+userNum);
		
		if (userNum==null) {
			System.out.println("오류발생");
			return "redirect:"+ctx+"/recipes.do";
		}
		
//		String num=request.getParameter("num");
//		if (num==null) {
//			num=(String) request.getAttribute("log");
//		}
		
		User vo=UserDAO.getInstance().numGetUser(userNum);
//		System.out.println("테스트옹 vo: "+vo);
		request.setAttribute("userFix", vo);
		
		//입력된 값 받아오기
		String id=request.getParameter("id-new");
		String pw=request.getParameter("pw-new");
		System.out.println(pw);
		String name=request.getParameter("name");
		System.out.println(name);
		String nickName=request.getParameter("nickName");
		System.out.println(nickName);
		String email=request.getParameter("email");
		
		
		if (email==null||session.getAttribute("firstInUserFix")==null||(Boolean)session.getAttribute("firstInUserFix")==false) {
			System.out.println("값없음");
			session.setAttribute("firstInUserFix", true);
			return "userFix";
		}
		
		System.out.println("값있음");
		session.setAttribute("firstInUserFix", false);
		

		if (email.trim().equals("")) {
			email=null;
		}
		System.out.println(email);
		String phone=request.getParameter("phone");
		if (phone.trim().equals("")) {
			phone=null;
		}
		System.out.println(phone);
		
		String profileImg=null;
		String existingImg = request.getParameter("originalImgHidden");
//		String existingImg = request.getParameter("imgChange");
		System.out.println("existingImg="+existingImg);
		
		String saveDirectory = request.getServletContext().getRealPath("/img");
		Path saveDirPath = Paths.get(saveDirectory);
		if (!Files.isDirectory(saveDirPath)) {
			Files.createDirectories(saveDirPath);
		}
		System.out.println("saveDirectory = " + saveDirectory);
		
		String sFileName = null;
		String oFileName = null;
		Part filePart = request.getPart("uploadFile");
        if (filePart != null && filePart.getSize() > 0) {
        	System.out.println("파일 업로드 수정함");
         	oFileName = extractFileName(filePart);
            sFileName =  System.currentTimeMillis() +"_"+oFileName ;
            
            filePart.write(saveDirPath.resolve(sFileName).toString());
            String fileType = filePart.getContentType();
            System.out.println("fileType= " + fileType);
            profileImg=sFileName;
        } else {
        	System.out.println("파일 업로드 수정 안함");
            profileImg = existingImg; // 파일이 업로드되지 않았으면 기존 이미지 이름 사용
        }
		
		PrintWriter out = response.getWriter();
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		try {
			//업데이트 할 곳
			int pass=UserDAO.getInstance().UserUpdate(userNum,id,pw,name,nickName,email,phone,profileImg);
			System.out.println("pass="+pass);
			if (pass>0) {
				out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
				out.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js'></script>");
				out.println("<script>");
				out.println("  Swal.fire({");
				out.println("icon: 'success',");
				out.println("title: 'Okay!',");
				out.println("text: '회원 정보 수정을 완료했습니다',");
				out.println("confirmButtonColor: '#3CB371',}).then(function() {");
				out.println("location.href='" + ctx + "/userContent.do';");
				out.println("  });");
				out.println("</script>");
				System.out.println("회원 정보 수정 성공");
			}else {
				out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
				out.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js'></script>");
				out.println("<script>");
				out.println("  Swal.fire({");
				out.println("title: 'Error!',");
				out.println("text: '회원 정보 수정을 실패했습니다',");
				out.println("icon: 'error',");
				out.println("confirmButtonColor: '#777777'}).then(function() {");
				out.println("    history.go(-1);");
				out.println("  });");
				out.println("</script>");
				System.out.println("회원 정보 수정 실패");
			}
//			return "redirect:" + ctx + "/userInfo.do";
		}catch (Exception e) {
			e.printStackTrace();
			out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
			out.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js'></script>");
			out.println("<script>");
			out.println("  Swal.fire({");
			out.println("title: '회원 정보 수정 실패!',");
			out.println("text: '오류가 발생했습니다',");
			out.println("icon: 'error',");
			out.println("confirmButtonColor: '#777777'}).then(function() {");
			out.println("    history.go(-1);");
			out.println("  });");
			out.println("</script>");
			System.out.println("회원 가입 실패");
//			return "userJoin.do";
		}finally {
			out.close();
		}
		return null;
	}

	private String extractFileName(Part filePart) {
        String contentDisposition = filePart.getHeader("content-disposition");
        String[] items = contentDisposition.split(";");
        
        System.out.println("items =" + Arrays.toString(items));
        
        for (String item : items) {
            if (item.trim().startsWith("filename")) {
                String fileName = item.substring(item.indexOf("=") + 2, item.length() - 1);
                return Paths.get(fileName).getFileName().toString(); // Extract just the filename
            }
        }
        return null;
	}

}
