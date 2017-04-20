package sns.enterprise.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import net.sf.json.JSONObject;
import sns.dao.HolidaysDAO;
import sns.dao.ReserveDAO;
import sns.dao.RestaurantDAO;
import sns.dao.RestaurantuploadDAO;
import sns.dao.ZipcodeDAO;
import sns.dto.HolidayDTO;
import sns.dto.ReserveDTO;
import sns.dto.RestaurantDTO;
import sns.dto.RestaurantuploadDTO;
import sns.dto.ZipcodeDTO;

@Controller
public class E_MyPageController {

	@Autowired
	private RestaurantDAO restaurantDao;
	
	public void setRestaurantDao(RestaurantDAO restaurantDao) {
		this.restaurantDao = restaurantDao;
	}

	@Autowired
	private ReserveDAO reserveDao;
	
	public void setReserveDao(ReserveDAO reserveDao) {
		this.reserveDao = reserveDao;
	}

	
	@Autowired
	private ZipcodeDAO zipcodeDao;
	
	public void setZipcodeDao(ZipcodeDAO zipcodeDao) {
		this.zipcodeDao = zipcodeDao;
	}


	
	@Autowired
	private RestaurantuploadDAO restaurantuploadDao;
	
	public void setRestaurantuploadDao(RestaurantuploadDAO restaurantuploadDao) {
		this.restaurantuploadDao = restaurantuploadDao;
	}


	//업주 마이 페이지
	@RequestMapping(value="/ownerMypageMain.do",method = RequestMethod.POST)
	public String enterpriseForm(String restaurant_number,HttpSession session){
	
		
	session.setAttribute("sessionRestaurant_number", restaurant_number);
		
		return "enterprise/main/Mypage/enterprise_Main";
		
	}
	
	
	//업주가 예약현황을 보는 것.
	@RequestMapping("/E_Mypage_Reserve.do")
	public ModelAndView mypage_reserve(@RequestParam(value="end_rno", defaultValue="20") String end_rno,HttpSession session) {
		
		
		
		ModelAndView mav = new ModelAndView("enterprise/main/Mypage/E_Mypage_Reserve");
		
		String restaurant_number =(String)session.getAttribute("sessionRestaurant_number");
		
		List<ReserveDTO> list = reserveDao.e_getReserveList(restaurant_number, end_rno);
		mav.addObject("reserveList", list);
		
		return mav;
	}
	
	
	
	//업주 회원정보 수정 시 초기 정보를 알려주는 처리
	@RequestMapping("/E_Mypage_EnterInfo.do")
	public ModelAndView mypage_enterInfo(String restaurant_number) {
		
		ModelAndView mav = new ModelAndView("enterprise/main/Mypage/E_Mypage_EnterInfo");
		RestaurantDTO restaurantDto = restaurantDao.getE_info(restaurant_number);
		mav.addObject("restaurantDto", restaurantDto);
		
		List<Integer> timeBlock = new ArrayList<>();
		
		for(int i=0;i<23;i++){
			
			timeBlock.add(i);
			
		}
		
		
		//타입 블럭을  보내준다.
		mav.addObject("timeBlock", timeBlock);
	
		//등록된 이미지를 보여준다.
		RestaurantuploadDTO restaurantuploadDTO = restaurantuploadDao.selectImageList(restaurant_number);
		
		
		if(restaurantuploadDTO!=null){
		//등록된 이미지 경로를 보내준다.
		mav.addObject("restaurantuploadDTO", restaurantuploadDTO);
		}
		
		
		return mav;
	}
	
	
	
	@RequestMapping("/findZipcode.do")
	public ModelAndView findZipcode(@RequestParam(value="area4", defaultValue="a") String area4) {
		
		ModelAndView mav = new ModelAndView("enterprise/main/Mypage/zipcode/findZipcode");
		
		List<ZipcodeDTO> zipCodeList = new ArrayList<ZipcodeDTO>();
		zipCodeList = zipcodeDao.zipcodeRead(area4);
		mav.addObject("zipCodeList", zipCodeList);
		return mav;
	}
	
	
	
	//업주 회원정보 수정정보 insert처리
	@RequestMapping("/E_insertInfo.do")
	public ModelAndView insertEnterInfo(RestaurantDTO restaurantDto) {
		
		
		System.out.println(restaurantDto);
		
		//레스토랑 정보 입력
		restaurantDao.updateInfo(restaurantDto);
		
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
		
		
		ModelAndView mav = new ModelAndView("enterprise/main/Mypage/enterprise_Main");
		
		
		return mav;
	}

	
	
	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}

	
	
	//휴일처리시작
	@Autowired
	private HolidaysDAO holidaysDao;
	
	
	public void setHolidaysDao(HolidaysDAO holidaysDao) {
		this.holidaysDao = holidaysDao;
	}

	//초기에 휴일정보를 보내주는 메소드
	@RequestMapping(value= "/holidayList.do", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String ListHoliday(@RequestParam("restaurant_number")String restaurant_number,HttpServletResponse resp){
		
		resp.setContentType("text/html;charset=UTF-8");
		
		JSONObject jso = new JSONObject();
		
		List<HolidayDTO> holidays = holidaysDao.selectListHoliday(restaurant_number);
		
		 Date d = new Date();
		 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		 
		jso.put("defaultDate",sdf.format(d));
		jso.put("holidays", holidays);		
		return jso.toString();
		
		
		
	}
	
	
	// 업주가 달력을 클릭한 경우 휴일을 등록할 것인지 휴일을 삭제할 것인지 처리하는 메소드
	@RequestMapping(value= "/holiday.do", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String insertHoliday(@RequestParam("dateText")String dateText,@RequestParam("restaurant_number")String restaurant_number,HttpServletResponse resp){
		
		resp.setContentType("text/html;charset=UTF-8");
		
		//결과값을 보내줄
		JSONObject jso = new JSONObject();
		
		// 홀리데이 비디에 있는지 비교
		int resultNum =holidaysDao.compareholiday(dateText, restaurant_number);
		
		
		if(resultNum==1){ //디비에 이미 휴일로 등록되어 있음.
			
			
		    holidaysDao.deleteHoliday(dateText, restaurant_number);
			jso.put("state", "휴일 등록이 취소되었습니다.");
		    
		}else if(resultNum ==0){ //디비에 휴일이 등록되어 있지 않음.
			
			
			holidaysDao.insertHoliday(dateText, restaurant_number);
			
			jso.put("state", "휴일 등록이 완료되었습니다.");
		}
	
		List<HolidayDTO> holidays = holidaysDao.selectListHoliday(restaurant_number);
		
		//내가 달력을 넘긴 경우 유지 값
		jso.put("defaultDate", dateText);
		
		//휴일 목록
		jso.put("holidays", holidays);
	
		return jso.toString();
		
		
	}
	

	// 노쇼회원 리스트를 보내주는 처리 E_Mypage_NoShowUserList.do
	@RequestMapping("/E_Mypage_NoShowUserList.do")
	public String noShowList(String restaurant_number,Model model){
		
		List<ReserveDTO> noShowList =reserveDao.noShowList(restaurant_number);
		
		//노쇼 리스트 세팅
		model.addAttribute("noShowList", noShowList);
		
		
		
		return "enterprise/main/Mypage/E_Mypage_noShowListPage";
	}
	
	//업주가 노쇼 회원들을 등록하는 처리​
	@RequestMapping(value="/noShowSave.do",method=RequestMethod.POST)
	@ResponseBody
	public String noShowSave(@RequestBody Map<String,Object> params){
		System.out.println("/noShowSave.do");
		
		
		Map<String,Object> resultMap = new HashMap<>();
		
		
		return "enterprise/main/Mypage/E_Mypage_noShowListPage";
	}
	
	
	
	
}
