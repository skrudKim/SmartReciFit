package kr.smartReciFit.model.user;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import kr.smartReciFit.util.Config;

public class UserInfoDAO {
	
	private UserInfoDAO() {}
	
	private static UserInfoDAO instance;
	
	public static UserInfoDAO getInstance() {
		if(instance == null) instance = new UserInfoDAO();
		return instance;
	}
	
	//info삽입하기
	
	public int insertUserInfo(int num, double mealSize, String ingredient, String cookingStyle, String cookingMethod, String eatTime) {
		SqlSession session = Config.getSession().openSession();
		UserInfo vo = new UserInfo(num, mealSize, ingredient, cookingStyle, cookingMethod, eatTime); 
		System.out.println("insertUserInfo()에서 만든 vo: "+vo.toString());
		int cnt=0;
		cnt=session.insert("insertInfo", vo);
		System.out.println("cnt: "+cnt);
		session.commit();
	    session.close();
		return cnt;
	}

	public UserInfo numGetUserInfo(int num) {
		Integer num2 = (Integer) num;
		SqlSession session = Config.getSession().openSession();
		UserInfo voInfo = session.selectOne("numGetUserInfo", num2);
		session.close();
		
		System.out.println("집어 넣은 num=" + num);
		System.out.println("가져온 UserInfo=" + voInfo);
		
		return voInfo;
	}

	public void delUserInfobyUserNum(int userNum) {
		SqlSession session = Config.getSession().openSession();
		session.selectOne("delUserInfobyUserNum", userNum);
		session.close();
		System.out.println("인포 삭제");
	}

	public int updateUserInfo(int userNum, double mealSizeInt, String ingredient, String cookingStyle,
			String cookingMethod, String eatTime) {
		SqlSession session = Config.getSession().openSession();
		Map<String, Object> userInfoMap = new HashMap<>();
		userInfoMap.put("userNum", userNum);
		userInfoMap.put("mealSizeInt", mealSizeInt);
		userInfoMap.put("ingredient", ingredient);
		userInfoMap.put("cookingStyle", cookingStyle);
		userInfoMap.put("cookingMethod", cookingMethod);
		userInfoMap.put("eatTime",eatTime);
		System.out.println(userInfoMap);
		
		int cnt= session.update("updateInfoByNum", userInfoMap);
		session.commit();
		session.close();
		System.out.println("UserInfoDAO.updateUserInfo 완료");
		return cnt;
	}

}
