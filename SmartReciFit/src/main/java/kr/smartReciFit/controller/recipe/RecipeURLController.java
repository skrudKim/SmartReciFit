package kr.smartReciFit.controller.recipe;

import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.smartReciFit.controller.Controller;
import kr.smartReciFit.model.recipe.AiRecipe;
import kr.smartReciFit.model.recipe.RecipeDAO;
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
		System.out.println("videoId = " + videoId);
		recipe = dao.getAiRecipeByUrl(videoId);
		if (recipe == null) {
			String aiRecipe = dao.getRecipe(videoId);
			Gson gson = new GsonBuilder().create();
			recipe = gson.fromJson(aiRecipe, AiRecipe.class);
			isExist = false;
		}
		request.setAttribute("rn", 1400);

		if (recipe.isAiRecipeBoolean()) {
			String thumbnailUrl = "https://img.youtube.com/vi/" + videoId + "/maxresdefault.jpg";
			recipe.setRecipeThumbnail(thumbnailUrl);
			request.setAttribute("timeStamp", dao.getRecipeTimeStamp(recipe.getRecipeManualTimeStamp()));
		}
		if(!isExist) {
			recipe.setAiRecipeUrl(videoId);
			dao.insertAiRecipe(recipe);
		}
		recipe.setRecipeType(RecipeType.AI);
		recipe.setRecipeManual(recipe.getRecipeManual().replaceAll("\\d\\.", ""));
		request.setAttribute("recipe", recipe);
		request.setAttribute("videoId", videoId);
		return "recipeContent";
	}

}
