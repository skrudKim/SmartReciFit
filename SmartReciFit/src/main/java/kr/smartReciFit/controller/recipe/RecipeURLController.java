package kr.smartReciFit.controller.recipe;

import java.io.IOException;
import java.io.PrintWriter;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.smartReciFit.controller.Controller;
import kr.smartReciFit.model.recipe.AiRecipe;
import kr.smartReciFit.model.recipe.RecipeDAO;
import kr.smartReciFit.model.recipe.tags.CookingStyle;
import kr.smartReciFit.model.recipe.tags.EatTime;
import kr.smartReciFit.model.recipe.tags.KoreanNamedEnum;
import kr.smartReciFit.model.recipe.tags.RecipeType;

public class RecipeURLController implements Controller {

	@Override
	public String requestHandler(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String url = request.getParameter("youtube-url");
		if (url == null || url.length() == 0) {
			return "recipes";
		}
		boolean isExist = true;
		RecipeDAO dao = RecipeDAO.getInstance();
		AiRecipe recipe = null;
		String videoId = dao.getVideoId(url);
		if(videoId == null) {
			response.setContentType("text/html;charset=UTF-8");
			String ctx = request.getContextPath();
			// PrintWriter를 사용하여 HTML 및 JavaScript 생성
			PrintWriter out = response.getWriter();
			try {
				// JavaScript alert() 호출
				out.println("<script type='text/javascript'>");
				out.println("alert('youtube 링크가 아닙니다');");
				out.println("window.location.href = '"+ ctx +"/index.jsp';");
				out.println("</script>");
			} finally {
				out.close();
			}
			return "recipes";
		}
		
		System.out.println("videoId = " + videoId);
		recipe = dao.getAiRecipeByUrl(videoId);
		if (recipe == null) {
			String aiRecipe = dao.getRecipe(videoId);
			Gson gson = new GsonBuilder().create();
			recipe = gson.fromJson(aiRecipe, AiRecipe.class);
			JsonObject jsonObject = JsonParser.parseString(aiRecipe).getAsJsonObject();
			recipe.setEatTime(
					KoreanNamedEnum.getEnumByKoreanName(EatTime.class, jsonObject.get("eatTime").getAsString()));
			recipe.setCookingStyle(KoreanNamedEnum.getEnumByKoreanName(CookingStyle.class,
					jsonObject.get("cookingStyle").getAsString()));
			isExist = false;

		}

		if (recipe.isAiRecipeBoolean()) {
			String thumbnailUrl = "https://img.youtube.com/vi/" + videoId + "/maxresdefault.jpg";
			recipe.setRecipeThumbnail(thumbnailUrl);
			request.setAttribute("timeStamp", dao.getRecipeTimeStamp(recipe.getRecipeManualTimeStamp()));
		}
		recipe.setRecipeType(RecipeType.AI);
		if (!isExist) {
			recipe.setAiRecipeUrl(videoId);
			recipe.setRecipeManual(recipe.getRecipeManual().replaceAll("\\([^)]*\\)", ""));
			dao.insertAiRecipe(recipe);
		}
		recipe.setRecipeManual(recipe.getRecipeManual().replaceAll("\\d*\\.", ""));
		request.setAttribute("recipe", recipe);
		request.setAttribute("videoId", videoId);
		return "recipeContent";
	}

}
