package kr.smartReciFit.controller.recipe;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.smartReciFit.controller.Controller;
import kr.smartReciFit.model.recipe.Recipe;
import kr.smartReciFit.model.recipe.RecipeDAO;

public class RecipeContentController implements Controller{

	@Override
	public String requestHandler(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int recipeNum = Integer.parseInt(request.getParameter("rn"));
		Recipe recipe = RecipeDAO.getInstance().getRecipeByRecipeNum(recipeNum);
		recipe.setRecipeManual(recipe.getRecipeManual().replaceAll("\\d\\.", ""));
		request.setAttribute("recipe", recipe);
		return "recipeContent";
	}

}
