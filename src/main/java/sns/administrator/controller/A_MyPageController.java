package sns.administrator.controller;

import java.util.LinkedList;
import java.util.List;
import java.util.Stack;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import exception.InsertShopException;
import sns.dao.CustomerDAO;
import sns.dao.OwnerDAO;
import sns.dto.CustomerDTO;
import sns.dto.OwnerDTO;

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
		customerDao.noShowCountUpdate(id);
		
		return "admin/administratorMainPage";
	}
	
	@RequestMapping("/insertShop.do")
	public String insertShop(OwnerDTO ownerDto,Model model) throws InsertShopException{
		
		
		try {
			
			ownerDao.insertShop(ownerDto);
			
			
		} catch (Exception e) {
			
			throw new InsertShopException("사업주 아이디를 등록하는데 에러가 발생했습니다.사업자등록번호를 다시 한번 확인해주세요.");
			
		}
		
		
		model.addAttribute("insertOk", "ok");
		return "admin/administratorMainPage";
		
	}

	
}
