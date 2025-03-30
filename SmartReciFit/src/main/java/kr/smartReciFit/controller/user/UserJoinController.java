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
import jakarta.servlet.http.Part;
import kr.smartReciFit.controller.Controller;
import kr.smartReciFit.model.user.UserDAO;

public class UserJoinController implements Controller {

	@Override
	public String requestHandler(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		System.out.println("UserJoinController진입");
		String ctx=request.getContextPath();
		
		String id=request.getParameter("id-new");
		
		if(id==null) {
			return "userJoin";
		}
		
		String pw=request.getParameter("pw-new");
		System.out.println(pw);
		String name=request.getParameter("name");
		System.out.println(name);
		String nickName=request.getParameter("nickName");
		System.out.println(nickName);
		String email=request.getParameter("email");
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
         	oFileName = extractFileName(filePart);
            sFileName =  System.currentTimeMillis() +"_"+oFileName ;
            
            filePart.write(saveDirPath.resolve(sFileName).toString());
            String fileType = filePart.getContentType();
            System.out.println("fileType= " + fileType);
        }

		profileImg=sFileName;
		
		PrintWriter out = response.getWriter();
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		try {
			//유저 가입완료 알람창 + 정보 입력 할지
			UserDAO.getInstance().UserJoin(id,pw,name,nickName,email,phone,profileImg);
			System.out.println("회원 가입 성공");
			
//			out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
//			out.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js'></script>");
//			out.println("<script>");
//			out.println("window.onload = function() {");
//			out.println("  Swal.fire({");
//			out.println("icon: 'info',");
//			out.println("title: '선호TAG를 입력하시겠습니까?',");
//			out.println("text: '마이페이지에 기록해둘 수 있습니다.',");
//			out.println("showDenyButton: true,");
//			out.println("showCancelButton: false,");
//			out.println("confirmButtonText: '네, 입력할게요',");
//			out.println("denyButtonText: '입력하지 않을래요'");
//			//out.println("confirmButtonColor: '#3CB371',");
//			//out.println("denyButtonColor: '#777777',})");
//			out.println(".then((result) => {");
//			out.println("if (result.isConfirmed) {");
//			out.println("console.log('입력하기 선택');");
//			out.println("window.location.href='" + ctx + "/userInfo.do';");
//			out.println("} else if (result.isDenied) {");
//			out.println("console.log('입력안하기 선택');");
//			out.println("  Swal.fire({");
//			out.println("icon: 'success',");
//			out.println("title: '회원 가입 성공!',");
//			out.println("text: 'SmartReciFit에 오신 것을 환영합니다.',");
//			out.println("confirmButtonColor: '#3CB371',}).then(function() {");
//			out.println("location.href='" + ctx + "/index.jsp';");
//			out.println("      });");
//			out.println("    }"); // else if 블록 닫기
//			out.println("  });"); // then 블록 닫기
//			out.println("}"); // window.onload 함수 닫기
//			out.println("</script>");
			
			out.print("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>" +
			          "<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js'></script>" +
			          "<script>" +
			          "window.onload = function() {" +
			          "  Swal.fire({" +
			          "    icon: 'info'," +
			          "    title: '선호TAG를 입력하시겠습니까?'," +
			          "    text: '마이페이지에 기록해둘 수 있습니다.'," +
			          "    showDenyButton: true," +
			          "    showCancelButton: false," +
			          "    confirmButtonText: '네, 입력할게요'," +
			          "    denyButtonText: '입력하지 않을래요'" +
//			          "    confirmButtonColor: '#3CB371'," +
//			          "    denyButtonColor: '#777777'" +
			          "  }).then((result) => {" +
			          "    if (result.isConfirmed) {" +
			          "      console.log('입력하기 선택');" +
			          "      window.location.href='" + ctx + "/userInfo.do';" +
			          "    } else if (result.isDenied) {" +
			          "      console.log('입력안하기 선택');" +
			          "      Swal.fire({" +
			          "        icon: 'success'," +
			          "        title: '회원 가입 성공!'," +
			          "        text: 'SmartReciFit에 오신 것을 환영합니다.'," +
			          "        confirmButtonColor: '#3CB371'" +
			          "      }).then(function() {" +
			          "        location.href='" + ctx + "/index.jsp';" +
			          "      });" +
			          "    }" +
			          "  });" +
			          "}" +
			          "</script>");
			
			out.println("<script>location.href='" + ctx + "/userInfo.do';</script>");
			//out.close();
			
//			return "redirect:" + ctx + "/userInfo.do";
		}catch (Exception e) {
			e.printStackTrace();
			out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
			out.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js'></script>");
			out.println("<script>");
			out.println("window.onload = function() {");
			out.println("  Swal.fire({");
			out.println("title: '회원 가입 실패!',");
			out.println("text: '오류가 발생했습니다',");
			out.println("icon: 'error,");
			out.println("confirmButtonText: '확인'}).then(function() {");
			out.println("    history.go(-1);");
			out.println("  });");
			out.println("};");
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


