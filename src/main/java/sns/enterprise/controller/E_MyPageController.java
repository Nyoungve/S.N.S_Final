package sns.enterprise.controller;

import java.io.BufferedReader;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import net.sf.json.JSONObject;
import sns.dao.CustomerDAO;
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

	@Autowired
	private CustomerDAO customerDao;
	
	public void setCustomerDao(CustomerDAO customerDao) {
		this.customerDao = customerDao;
	}


	//업주가 로그인에 성공했고 관리할 레스토랑을 클릭한 상태의 마이 페이지
	@RequestMapping(value="/ownerMypageMain.do",method = RequestMethod.POST)
	public String enterpriseForm(String restaurant_number,String owneruserid,HttpSession session,Model model){
	
	//아이디 보내주기
	model.addAttribute("owneruserid", owneruserid);	
		
	//세션에 설정	
	session.setAttribute("sessionRestaurant_number", restaurant_number);
	
	
		return "enterprise/main/Mypage/enterprise_Main";
		
	}
	
	
	//업주가 예약현황을 보는 것.
	@RequestMapping("/E_Mypage_Reserve.do")
	public ModelAndView mypage_reserve(HttpSession session) {
		
		ModelAndView mav = new ModelAndView("enterprise/main/Mypage/E_Mypage_Reserve");
		
		String restaurant_number =(String)session.getAttribute("sessionRestaurant_number");
		
		List<ReserveDTO> list = reserveDao.e_getReserveList(restaurant_number);
		System.out.println(list);
		mav.addObject("reserveList", list);
		
		return mav;
	}
	
	@RequestMapping("/E_reserveOk.do")
	public String reserveOk(String reserveNumber) {
		System.out.println("reserveOk");
		reserveDao.e_reserveOk(reserveNumber);
		return "redirect:/E_Mypage_Reserve.do";
	}
	
	@RequestMapping("/E_reserveCancel.do")
	public String reserveCancel(String reserveNumber) {
		System.out.println("reserveCancel");
		reserveDao.e_reserveCancel(reserveNumber);
		return "redirect:/E_Mypage_Reserve.do";
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
		
		
		
		int reserveCheckNum = reserveDao.reserveCheck(dateText,restaurant_number);
		
		if(reserveCheckNum>0){
			System.out.println("예약사항존재");
			List<HolidayDTO> holidays = holidaysDao.selectListHoliday(restaurant_number);
			//내가 달력을 넘긴 경우 유지 값
			jso.put("defaultDate", dateText);
			//휴일 목록
			jso.put("holidays", holidays);
			jso.put("state", "예약된 사항이 존재합니다. 관리자에게 문의바랍니다.");
			return  jso.toString();
		}
		
		
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
	public String noShowSave(HttpServletRequest request){
		
		System.out.println("/noShowSave.do");
		
		//넘어온 json 데이터를 받는 처리
		StringBuffer json = new StringBuffer();
		String line=null;
		
		try {
			BufferedReader reader = request.getReader();
			while((line =reader.readLine()) !=null){
				json.append(line);
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		//string 타입을 json 타입으로
		org.json.JSONObject jso = new org.json.JSONObject(json.toString());
		
		
		Iterator<String> jsoIterator = jso.keys();
		
		while(jsoIterator.hasNext()){
			
			//jsoKeyName은 reserveNumber
			String jsoKeyName = jsoIterator.next();
			System.out.println(jsoKeyName);
			
			//jsoValue는 Y,N 상태
			String jsoValue= (String)jso.get(jsoKeyName);
			System.out.println(jsoValue);
			
			
			if(jsoValue.equals("n")){ //안 온 사람 확정
				
				//reserve 테이블에서 r_state를 6으로 만든다.
				reserveDao.updateNotComePeople(jsoKeyName);
				
				
				//예약 번호에 해당하는 고객 아이디를 가져온다.
				String userid= reserveDao.selectId(jsoKeyName);
				
				
				//customer 테이블에서 NoShowCount를 1 증가 시킨다.
				customerDao.updateNoShowPlusone(userid);
				
			}else if(jsoValue.equals("y")){ //온 사람 확정
				
				//reserve 테이블에서 r_state를 5으로 만든다.
				reserveDao.updateComePeople(jsoKeyName);
				
			}
			
		} //while 문 종료

		return "enterprise/main/Mypage/E_Mypage_noShowListPage";
	}
	
	
	
	//로그아웃
	@RequestMapping("/ownerlogout.do")
	public String logout(HttpSession session){
		//세션 삭제
		session.invalidate();
		
		return "redirect:ownerLoginMain.do";
	}
	
	
	@RequestMapping("/mainAgain.do")
	public String mainAgain(){
		
		return "enterprise/main/Mypage/enterprise_Main";
	}
	
	
	
}
