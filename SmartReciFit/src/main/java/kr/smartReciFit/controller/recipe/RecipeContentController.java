package kr.smartReciFit.controller.recipe;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.smartReciFit.controller.Controller;
import kr.smartReciFit.model.recipe.Recipe;
import kr.smartReciFit.model.recipe.RecipeDAO;
import kr.smartReciFit.model.recipe.tags.RecipeType;

public class RecipeContentController implements Controller{

	@Override
	public String requestHandler(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int recipeNum = Integer.parseInt(request.getParameter("rn"));
		RecipeDAO dao = RecipeDAO.getInstance();
		RecipeType recipeType = RecipeDAO.getInstance().getRecipeType(recipeNum);
		Recipe recipe = null;
		if(recipeType == RecipeType.API) {
			recipe = dao.getApiRecipeByRecipeNum(recipeNum);
		}else if(recipeType == RecipeType.AI) {
			recipe = dao.getAiRecipeByRecipeNum(recipeNum);
		}else if(recipeType == RecipeType.USER) {
			recipe = dao.getUserRecipeByRecipeNum(recipeNum);
		}
		recipe.setRecipeManual(recipe.getRecipeManual().replaceAll("\\d\\.", ""));
		request.setAttribute("recipe", recipe);
		return "recipeContent";
	}

}
