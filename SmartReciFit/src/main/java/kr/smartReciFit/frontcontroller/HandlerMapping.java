package kr.smartReciFit.frontcontroller;

import java.util.HashMap;

import kr.smartReciFit.controller.Controller;
import kr.smartReciFit.controller.admin.AdminMainController;
import kr.smartReciFit.controller.admin.AdminManagerUserController;
import kr.smartReciFit.controller.admin.AdminRecipeController;
import kr.smartReciFit.controller.admin.AdminRecipeDeleteController;
import kr.smartReciFit.controller.admin.AdminReviewController;
import kr.smartReciFit.controller.admin.AdminUserController;
import kr.smartReciFit.controller.admin.ReviewAdminDeleteController;
import kr.smartReciFit.controller.admin.SearchReviewAdminBoardController;
import kr.smartReciFit.controller.board.CommentAddController;
import kr.smartReciFit.controller.board.CommentDeleteController;
import kr.smartReciFit.controller.board.CommentUpdateController;
import kr.smartReciFit.controller.board.EventBoardController;
import kr.smartReciFit.controller.board.EventDetailController;
import kr.smartReciFit.controller.board.LikeController;
import kr.smartReciFit.controller.board.RankingController;
import kr.smartReciFit.controller.board.ReviewController;
import kr.smartReciFit.controller.board.ReviewDeleteController;
import kr.smartReciFit.controller.board.ReviewDetailController;
import kr.smartReciFit.controller.board.ReviewUpdateController;
import kr.smartReciFit.controller.board.ReviewUpdateProcessController;
import kr.smartReciFit.controller.board.ReviewWriteController;
import kr.smartReciFit.controller.board.ReviewWriteProcessController;
import kr.smartReciFit.controller.board.SearchRecipesController;
import kr.smartReciFit.controller.board.SearchReviewBoardController;
import kr.smartReciFit.controller.recipe.CreateRecipeController;
import kr.smartReciFit.controller.recipe.RecipeContentController;
import kr.smartReciFit.controller.recipe.RecipeConverterController;
import kr.smartReciFit.controller.recipe.RecipeFilterController;
import kr.smartReciFit.controller.recipe.RecipeURLController;
import kr.smartReciFit.controller.recipe.RecipesController;
import kr.smartReciFit.controller.recipe.SaveRecipeController;
import kr.smartReciFit.controller.user.CheckIdController;
import kr.smartReciFit.controller.user.CheckNickNameController;
import kr.smartReciFit.controller.user.LinkSocialLoginController;
import kr.smartReciFit.controller.user.LoginCheckController;
import kr.smartReciFit.controller.user.MailSend;
import kr.smartReciFit.controller.user.LoginSuccessController;
import kr.smartReciFit.controller.user.CheckEmailController;
import kr.smartReciFit.controller.user.CheckEmailDoubleController;
import kr.smartReciFit.controller.user.CheckIdController;
import kr.smartReciFit.controller.user.CheckNickNameController;
import kr.smartReciFit.controller.user.GetSocialStatusController;
import kr.smartReciFit.controller.user.LinkSocialLoginController;
import kr.smartReciFit.controller.user.UserJoinController;
import kr.smartReciFit.controller.user.UserResetPwController;
import kr.smartReciFit.controller.user.VaildIdAjaxController;

import kr.smartReciFit.controller.user.LogOutController;
import kr.smartReciFit.controller.user.LoginCheckController;
import kr.smartReciFit.controller.user.LoginSuccessController;
import kr.smartReciFit.controller.user.MailSend;
import kr.smartReciFit.controller.user.MainController;
import kr.smartReciFit.controller.user.NicknameInputFormController;
import kr.smartReciFit.controller.user.SaveSocialLoginInfo;
import kr.smartReciFit.controller.user.UnlinkButtonController;
import kr.smartReciFit.controller.user.UserContentController;
import kr.smartReciFit.controller.user.UserDelController;
import kr.smartReciFit.controller.user.UserFindController;
import kr.smartReciFit.controller.user.UserFindIdController;
import kr.smartReciFit.controller.user.UserFixController;
import kr.smartReciFit.controller.user.UserFixMoveController;
import kr.smartReciFit.controller.user.UserInfoController;
import kr.smartReciFit.controller.user.UserJoinController;
import kr.smartReciFit.controller.user.VaildIdAjaxController;
import kr.smartReciFit.controller.user.UserInfoFixController;

public class HandlerMapping {
	private HashMap<String, Controller> mappings;

	public HandlerMapping() {
		mappings = new HashMap<String, Controller>();
		
		//회원가입 관련 맵핑
		mappings.put("/userJoin.do",  new UserJoinController());
		mappings.put("/checkId.do",  new CheckIdController());
		mappings.put("/checkNickName.do",  new CheckNickNameController());
		mappings.put("/vaildIdAjax.do",  new VaildIdAjaxController());
		mappings.put("/mailSend.do",  new MailSend());
		mappings.put("/userDel.do",  new UserDelController());
		//마이페이지 관련 맵핑
		mappings.put("/userContent.do",  new UserContentController());
		mappings.put("/userFixMove.do",  new UserFixMoveController());
		mappings.put("/userFix.do",  new UserFixController());
		mappings.put("/userInfo.do",  new UserInfoController());
		mappings.put("/userInfoFix.do",  new UserInfoFixController());
		//mappings.put("/userMyBoard.do",  new UserMyBoardController());
		//mappings.put("/userMyComent.do",  new UserMyComentController());
		
		mappings.put("/userFind.do",  new UserFindController());
		mappings.put("/checkEmail.do",  new CheckEmailController());
		mappings.put("/checkEmailDouble.do",  new CheckEmailDoubleController());
		mappings.put("/userFindId.do",  new UserFindIdController());
		mappings.put("/userResetPw.do",  new UserResetPwController());
		
		// 로그인 관련 작업 (나경)
		// 로그인아웃 관련 맵핑
		mappings.put("/login.do", new LoginCheckController());
		mappings.put("/logout.do", new LogOutController());
		mappings.put("/main.do", new MainController());
		mappings.put("/loginSuccess.do", new LoginSuccessController());
		mappings.put("/saveSocialLoginInfo.do", new SaveSocialLoginInfo());
		mappings.put("/linkSocial.do", new LinkSocialLoginController());
		mappings.put("/nicknameInputForm.do", new NicknameInputFormController());
		mappings.put("/unLinkButton.do", new UnlinkButtonController());
		
		

		// 관리자 게시판 (나경)
		
		mappings.put("/adminMain.do", new AdminMainController());
		mappings.put("/userList.do", new AdminUserController()); // 전체 회원 목록
		mappings.put("/adminUser.do", new AdminManagerUserController()); // 관리자/운영 회원 목록
		mappings.put("/deleteUser.do", new AdminUserController());
		mappings.put("/adminUser.do", new AdminUserController()); // 관리자/운영 회원 목록
		mappings.put("/adminReview.do", new AdminReviewController()); // 리뷰 정보 관리
		mappings.put("/adminRecipe.do", new AdminRecipeController());
		mappings.put("/adminRecipeDelete.do", new AdminRecipeDeleteController()); // 레시피 삭제

		
		
		
		
		mappings.put("/reviewAdminDelete.do", new ReviewAdminDeleteController());
		mappings.put("/searchReviewAdminBoard.do", new SearchReviewBoardController());
		
		// 랭킹 후기 게시판 작업(명보)
		mappings.put("/ranking.do", new RankingController());
		mappings.put("/reviews.do", new ReviewController());
		mappings.put("/reviewDetail.do", new ReviewDetailController());
		mappings.put("/commentAdd.do", new CommentAddController());
		mappings.put("/commentUpdate.do", new CommentUpdateController());
		mappings.put("/commentDelete.do", new CommentDeleteController());
		mappings.put("/reviewWrite.do", new ReviewWriteController());
		mappings.put("/reviewWriteProcess.do", new ReviewWriteProcessController());
		mappings.put("/reviewUpdate.do", new ReviewUpdateController());
		mappings.put("/reviewUpdateProcess.do", new ReviewUpdateProcessController());
		mappings.put("/reviewDelete.do", new ReviewDeleteController());
		mappings.put("/like.do", new LikeController());
		mappings.put("/searchRecipes.do", new SearchRecipesController());
		mappings.put("/searchReviewBoard.do", new SearchReviewBoardController());
		mappings.put("/events.do", new EventBoardController());
		mappings.put("/eventDetail.do", new EventDetailController());
		mappings.put("/createRecipe.do", new CreateRecipeController());
		mappings.put("/searchReviewAdminBoard.do",new SearchReviewAdminBoardController());
		// 레시피 페이지
		mappings.put("/recipes.do", new RecipesController());
		mappings.put("/recipeFilter.do", new RecipeFilterController());
		mappings.put("/recipeURL.do", new RecipeURLController());
		mappings.put("/recipeContent.do", new RecipeContentController());
		mappings.put("/recipeConverter.do", new RecipeConverterController());
		mappings.put("/saveRecipe.do", new SaveRecipeController());

	}

	public Controller getController(String key) {
		return mappings.get(key);
	}
}