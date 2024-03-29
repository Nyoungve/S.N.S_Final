package sns.customer.controller;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import net.sf.json.JSONObject;
import sns.dao.HolidaysDAO;
import sns.dao.OwnerDAO;
import sns.dao.ReserveDAO;
import sns.dao.RestaurantDAO;
import sns.dao.ReviewDAO;
import sns.dao.ZipcodeDAO;
import sns.dto.HolidayDTO;
import sns.dto.OwnerDTO;
import sns.dto.ReserveDTO;
import sns.dto.RestaurantDTO;
import sns.dto.ReviewDTO;
import sns.dto.SearchDTO;
import util.PageingUtil;

@Controller
public class C_MainController {

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
	private HolidaysDAO holidaysDao;
	
	public void setHolidaysDao(HolidaysDAO holidaysDao) {
		this.holidaysDao = holidaysDao;
	}


	@Autowired
	private OwnerDAO ownerDao;
	
	
	public void setOwnerDao(OwnerDAO ownerDao) {
		this.ownerDao = ownerDao;
	}
	
	@Autowired
	private ReviewDAO reviewDao;
	
	public void setReviewDao(ReviewDAO reviewDao) {
		this.reviewDao = reviewDao;
	}


	@Autowired
	private ZipcodeDAO zipcodeDao;
	
	
	public void setZipcodeDao(ZipcodeDAO zipcodeDao) {
		this.zipcodeDao = zipcodeDao;
	}



	//더보기 버튼 요청 처리
	@RequestMapping("/more.do")
	public String moreForm(@RequestParam("pageNum") int pageNum,Model model){
		
		
		
		List<RestaurantDTO> restaurantDtos = restaurantDao.selectRestaurantList(pageNum);
		
		model.addAttribute("restaurantDtos",restaurantDtos);
		
	
		
		return "customer/body/moreRestaurant";
	}
	
	
	
	//레스토랑을 클릭했을 때 레스토랑 정보를 보내주는 처리
	@RequestMapping("/reserve.do")
	public String reserveForm(@RequestParam("restaurant_number")String restaurant_number
			,@RequestParam("today")String today
			,@RequestParam(value="reviewPageNum", defaultValue="1") int reviewPageNum
			,Model model){
		
	
		//레스토랑의 정보를 가져오는 Dto 생성
		RestaurantDTO restaurantDto = restaurantDao.selectRestaurantInfo(restaurant_number);
		
	
		
		//레스토랑의 정보를 model에 세팅
		model.addAttribute("restaurantDto", restaurantDto);
		
		
		//레스토랑의 오늘 시간별 예약 현황 가져오기
		LinkedHashMap<Integer,Integer> resultMap = reserveDao.searchAvailableTeamCount(restaurant_number,today);
		
	
		//레스토랑 시간별 예약 현황을 담은 resultMap
		model.addAttribute("resultMap", resultMap);
		//오늘 날짜의 버튼 결과를 보내주므로 todayBtn은 true
		model.addAttribute("todayBtn", true);
		
		//레스토랑 휴일 정보를 json 형태로 보내준다.
		JSONObject jso = new JSONObject();
		
		//레스토랑의 휴일 정보를 가져온다.
		List<HolidayDTO> holidays = holidaysDao.selectListHoliday(restaurant_number);
		
		jso.put("jsoholidays", holidays);
		
		model.addAttribute("holidays", jso);
		
		
		
		//업주 정보를 보내준다.
		OwnerDTO ownerDto = ownerDao.getOwnerInfo(restaurant_number);
		
		model.addAttribute("ownerDto", ownerDto);
		
		
		//리뷰 페이지 페이징 처리
		model.addAttribute("reviewPageNum", reviewPageNum);
		int totalReviewCount = reviewDao.getTotalReviewCount(restaurant_number);
		model.addAttribute("totalReviewCount", totalReviewCount);
		
		//리뷰 세팅
		settingReviewList(totalReviewCount,model,reviewPageNum,restaurant_number);
		
		
		return "customer/main/reserve/C_Main_ReservePage";
		
	}

	
	@RequestMapping("/changeReviewList.do")
	public String changeReviewList(String restaurant_number,int reviewPageNum,Model model){
		System.out.println(restaurant_number);
		System.out.println(reviewPageNum);
		
		int totalReviewCount = reviewDao.getTotalReviewCount(restaurant_number);
		model.addAttribute("totalReviewCount", totalReviewCount);
		
	
		settingReviewList(totalReviewCount, model, reviewPageNum,restaurant_number);
		
		
		return "customer/main/reserve/C_Main_Review";
	}
	
	public void settingReviewList(int totalReviewCount,Model model,int reviewPageNum,String restaurant_number){
		
		int pageSize = 5;
		
		int startRow = (reviewPageNum - 1) * pageSize + 1;//한 페이지의 시작글 번호
        
        int endRow = reviewPageNum * pageSize;
        
       if(totalReviewCount>0){
      	List<ReviewDTO> reviewDtos = reviewDao.getReviewList(restaurant_number,startRow,endRow);
      	model.addAttribute("reviewDtos", reviewDtos);
       }
      	
       PageingUtil.pageing(model,totalReviewCount,pageSize,reviewPageNum,5);
	}
	
	
	//레스토랑 예약 시 날짜가 선택되었을 때 날짜에 대한 버튼 상황을 resultMap으로 보내주는 요청 처리
	@RequestMapping("/getAvailableButtomResultMap.do") 
	public String getAvailableButtomResultMap(@RequestParam("restaurant_number")String restaurant_number
			,@RequestParam("selectDay")String selectDay
			,Model model){
	
		//레스토랑의 teamCount를 보내준다.
		//레스토랑의 정보를 가져오는 Dto 생성
		RestaurantDTO restaurantDto = restaurantDao.selectRestaurantInfo(restaurant_number);
		//레스토랑의 정보를 model에 세팅
		model.addAttribute("restaurantDto", restaurantDto);
		
		
		//날짜에 따른 예약상황이 담긴 결과맵을 가져온다.
		LinkedHashMap<Integer,Integer> resultMap = reserveDao.searchAvailableTeamCount(restaurant_number,selectDay);
		
		//모델에 세팅
		model.addAttribute("resultMap", resultMap);
		
		//찍힌 날짜가 오늘이면 model에 todayBtn은 true를 만들어준다.
		compareTodaySelectDay(selectDay,model);	
		
		return "customer/main/reserve/ReservePageTimeButtons";
	}
	
	
	
	
	
	//고객의 예약 정보를 reserve테이블에 넣는 처리
	@RequestMapping(value="/reserveData.do",method = RequestMethod.POST, produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String insertReserveData(ReserveDTO reserveDto,BindingResult bindingResult,HttpServletResponse resp)
									throws Exception{
		
		resp.setContentType("text/html;charset=UTF-8");
			
		JSONObject jso = new JSONObject();
			
		
		//예약 테이블에 넣기전에 restaurant의 팀 카운트를 세어본다.
		RestaurantDTO restaurantDto = restaurantDao.selectRestaurantInfo(reserveDto.getRestaurant_number());
		int restaurant_teamCount= restaurantDto.getTeamCount();
		
		int reserveSituationNum = reserveDao.reserveSituationNum(reserveDto);
		
		
		
		if(restaurant_teamCount <= reserveSituationNum){ //이미 포화상태 
			
			jso.put("insertOk", false);
			
			return jso.toString();
		}
		
		
		//예약 테이블에 넣는다.
		int resultNum =reserveDao.insertReserveData(reserveDto);
		
		if(resultNum == 1 ){
			//정상처리
			jso.put("insertOk", true);
			
			int reserveNumber = reserveDao.getReserveNumber(reserveDto);
			
			jso.put("reserveNumber", reserveNumber);
			
			
		}else{
			//그 외의 상황
			throw new Exception();
		}
		
	
		return jso.toString();
	}
	
	
	//결제 취소시 예약 테이블 내용 삭제
	@RequestMapping(value="/deleteReserveData.do",method = RequestMethod.POST, produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String deleteReserveData(@RequestParam("reserveNumber") int reserveNumber,HttpServletResponse resp)
									throws Exception{
		
		
		resp.setContentType("text/html;charset=UTF-8");
			
		JSONObject jso = new JSONObject();
			
		reserveDao.deleteReserveData(reserveNumber);
		
		jso.put("deleteOk", true);
		
		return jso.toString();
	}
	
	
	
	
	
	
	
	public void compareTodaySelectDay(String selectDay,Model model){
		//오늘과 선택된 날을 비교
				Date today = new Date();
				SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
				String fmtToday = transFormat.format(today);
				
				if(selectDay.equals(fmtToday)){
					System.out.println("오늘날짜 버튼 만들어주고 있다.");
					model.addAttribute("todayBtn", true);
				}
			
	}
	
	//검색 시도 보내주기
	
	//produces="text/plain;charset=UTF-8" 한글 처리가 안될때 써주면 좋다.
		@RequestMapping(value = "/cityList.do", method = RequestMethod.POST, produces="text/plain;charset=UTF-8")
		@ResponseBody
		public String cityList(HttpServletResponse resp, @RequestParam("snum")String city) throws Exception {
			
			resp.setContentType("text/html; charset=UTF-8");
			
			List<String> list = null;

			try {
				list = zipcodeDao.getListData("city.listCity", city);
			} catch (Exception e) {
				System.out.println(e.toString());
			}

			JSONObject jso = new JSONObject();
			jso.put("data1", list);
			return jso.toString();
			
		}
	
	
		@RequestMapping(value = "/sidoList.do", method = RequestMethod.POST)
		public void sidoList(HttpServletResponse resp) throws Exception {
			
			System.out.println("sido");
			List<String> list = null;

			try {
				
				list = zipcodeDao.getListData("city.listSido");
				
			} catch (Exception e) {
				System.out.println(e.toString());
			}
			
			JSONObject jso = new JSONObject(); // JASON 객체생성
			jso.put("data", list); // jason은 map구조(키,값), data라는 key로 list데이터를 주입했다.

			resp.setContentType("text/html;charset=utf-8");
			
			PrintWriter out = resp.getWriter(); //writer 는 2byte 씩, stream은 1byte 씩
			
			// app ---> response 통로방향 
			
			out.print(jso.toString()); // out.print 내용을 ajax의 dataType이 jason에게 데이터 쏴줌
			
			
		}
	
	
		//검색된 레스토랑 정보 보내주기
		@RequestMapping("/searchRestaurant.do")
		public String searchRestaurant(@RequestParam("sido")String sido, @RequestParam("city") String city
									,@RequestParam(value="guestCount",defaultValue="1") int guestCount
									,@RequestParam("type") String type
									,@RequestParam("e_name")String e_name
									,Model model,HttpSession session){
			
			
			StringBuffer sb = new StringBuffer();
			
			sb.append(sido);
			
			if(city !=null){
				sb.append(" ");
				sb.append(city);
			}
			
			SearchDTO searchDto = new SearchDTO();
			searchDto.setAddress(sb.toString());
			searchDto.setGuestCount(guestCount);
			searchDto.setType(type);
			searchDto.setE_name(e_name);
			
			
			List<RestaurantDTO> restaurantDtos = restaurantDao.searchRestaurant(searchDto);
			System.out.println(restaurantDtos);
			
			model.addAttribute("restaurantDtos", restaurantDtos);
			model.addAttribute("searchClick", true);
			
			if(session.getAttribute("sessionUserid") !=null){
				return "customer/main/C_MainPage";
			}
			
			
			System.out.println("정상종료");
			return "customer/main/FirstMainPage";
		}
		
		
		
		
	
	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}

	
}
