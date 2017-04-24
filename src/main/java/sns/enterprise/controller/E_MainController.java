package sns.enterprise.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import sns.dao.OwnerDAO;
import sns.dao.RestaurantDAO;
import sns.dto.RestaurantDTO;

@Controller
public class E_MainController {

	@Autowired
	private OwnerDAO ownerDao;
	
	public void setOwnerDao(OwnerDAO ownerDao) {
		this.ownerDao = ownerDao;
	}


	@Autowired
	private RestaurantDAO restaurantDao;
	

	public void setRestaurantDao(RestaurantDAO restaurantDao) {
		this.restaurantDao = restaurantDao;
	}

	//업주 로그인 페이지 보내주기
	@RequestMapping("/ownerLoginMain.do")
	public String loginForm(){
		
		return "enterprise/main/login/ownerLoginMain";
	}
	
	
	//업주 로그인 요청 처리
	@RequestMapping("/ownerLogin.do")
	public String loginlogic(@RequestParam("user_id")String user_id,@RequestParam("password")String password,Model model
								,HttpSession session){
		
			
		//디비에서 아이디와 패스워드에 해당하는게 있는지 확인
		String owneruserid=ownerDao.searchIdPw(user_id,password);
		
			if(owneruserid != null){
				
				//세션에 아이디 저장
				session.setAttribute("owneruserid", owneruserid);
				
				model.addAttribute("sessionUserid", true);
				
				//업주의 레스토랑 사업자 등록번호 리스트를 구해온다.
				List<String> ownerRestaurantNumberList =ownerDao.ownerRestaurantNumberList(owneruserid);
		
				//업주의 사업자 등록번호 리스트로부터 레스토랑 정보들을 구해온다.
				List<RestaurantDTO> restaurants =restaurantDao.getRestaurants(ownerRestaurantNumberList);
				
				//모델에 업주의 레스토랑들 dto를 보낸다.
				model.addAttribute("restaurants", restaurants);
				
			}else{
				
				System.out.println("로그인 실패");
				model.addAttribute("sessionUserid", false);
			}
		
		
			
			return "enterprise/main/login/ownerLoginMain";
	}
	
	
}
