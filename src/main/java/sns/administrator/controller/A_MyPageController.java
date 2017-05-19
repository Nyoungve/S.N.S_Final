package sns.administrator.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import exception.InsertShopException;
import sns.dao.CustomerDAO;
import sns.dao.OwnerDAO;
import sns.dao.RestaurantDAO;
import sns.dao.RestaurantuploadDAO;
import sns.dto.CustomerDTO;
import sns.dto.OwnerDTO;
import sns.dto.RestaurantDTO;
import sns.dto.RestaurantuploadDTO;

@Controller
public class A_MyPageController {

	@Autowired
	private CustomerDAO customerDao;

	public void setCustomerDao(CustomerDAO customerDao) {
		this.customerDao = customerDao;
	}


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
	
	@Autowired
	private RestaurantuploadDAO restaurantuploadDao;

	public void setRestaurantuploadDao(RestaurantuploadDAO restaurantuploadDao) {
		this.restaurantuploadDao = restaurantuploadDao;
	}


	// 업체를 등록하기 위한 처리
	@RequestMapping("/owner.do")
	public String searchCustomer(@RequestParam("id")String id,Model model){
		
		
		CustomerDTO customerDTO =customerDao.getCustomer(id);

		model.addAttribute("customerDTO", customerDTO);
				
		return "admin/administratorMainPage";
		
	}
	
	
	
	@RequestMapping("/blackList.do")
	public String searchBlackList(@RequestParam("id")String id,Model model){

		List<CustomerDTO> blackList =customerDao.getBlackList(id);
		
		model.addAttribute("blackList", blackList);
		
		
		return "admin/administratorMainPage";
	}
	
	@RequestMapping("/noShowCount.do")
	public String noShowCount(@RequestParam("id")String id){
		System.out.println("/noShowCount.do");
		customerDao.noShowCountUpdate(id);
		
		return "admin/administratorMainPage";
	}
	
	@RequestMapping("/insertOwner.do")
	public String insertOwner(OwnerDTO ownerDto,Model model) throws InsertShopException{
		
		
		try {
			
			ownerDao.insertOwner(ownerDto);
			
			
		} catch (Exception e) {
			
			throw new InsertShopException("사업주 아이디를 등록하는데 에러가 발생했습니다.사업자등록번호를 다시 한번 확인해주세요.");
			
		}
		model.addAttribute("insertOk", "insertOk");
		return "admin/administratorMainPage";
		
	}

	//관리자가 레스토랑을 등록
	@RequestMapping("/insertRestaurant.do")
	public String insertRestaurantForm(RestaurantDTO restaurantDto,Model model){
		
	System.out.println("/insertRestaurant.do");
		
		
	//reserve 테이블에서 등록
	restaurantDao.insertRestaurantForm(restaurantDto);
		
	//이미지 등록
	//파일 업로드 처리할 dto
	RestaurantuploadDTO restaurantuploadDto = new RestaurantuploadDTO();
						
	//파일 업로드 처리할 dto에 레스토랑 번호 세팅
	restaurantuploadDto.setRestaurant_number(restaurantDto.getRestaurant_number());
	System.out.println(restaurantDto.getRestaurant_number());	
						
	//각각의 파일 패스를 담는다.
	restaurantDao.upload(restaurantDto.getMain_image(), restaurantDto.getRestaurant_number(),restaurantuploadDto);
				
	restaurantDao.upload(restaurantDto.getDetail_image(), restaurantDto.getRestaurant_number(),restaurantuploadDto);
				
	restaurantDao.upload(restaurantDto.getMenu_image(), restaurantDto.getRestaurant_number(),restaurantuploadDto);
					
				
	//이미 레스토랑 이미지 파일이 있는지 없는지 확인
			
	int resultNum = restaurantuploadDao.searchNumber(restaurantDto.getRestaurant_number());
				
	System.out.println(resultNum);
				
				
				if(resultNum >=1){ //파일 정보가 있었다면 update
					
					System.out.println("파일정보 업로드");
					restaurantuploadDao.updateInfo(restaurantuploadDto);
					
				}else if(resultNum ==0){//파일 정보가 없었으므로 insert
					
					System.out.println("파일 정보 인서트");
					
					restaurantuploadDao.insertInfo(restaurantuploadDto);
				}
			
		model.addAttribute("insertOk", "insertOk");
		return "admin/administratorMainPage";
	}
	
	
	
}
