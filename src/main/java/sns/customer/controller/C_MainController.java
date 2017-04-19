package sns.customer.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

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
import sns.dto.HolidayDTO;
import sns.dto.OwnerDTO;
import sns.dto.ReserveDTO;
import sns.dto.RestaurantDTO;

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



	//더보기 버튼 요청 처리
	@RequestMapping("/more.do")
	public String moreForm(){
		return "moreRestaurant";
	}
	
	
	
	//레스토랑을 클릭했을 때 레스토랑 정보를 보내주는 처리
	@RequestMapping("/reserve.do")
	public String reserveForm(@RequestParam("restaurant_number")String restaurant_number
			,@RequestParam("today")String today
			,Model model){
		
		//레스토랑의 정보를 가져오는 Dto 생성
		RestaurantDTO restaurantDto = restaurantDao.selectRestaurantInfo(restaurant_number);
		
		
		//레스토랑의 정보를 model에 세팅
		model.addAttribute("restaurantDto", restaurantDto);
		
		
		//레스토랑의 오늘 시간별 예약 현황 가져오기
		LinkedHashMap<Integer,Integer> resultMap = reserveDao.searchAvailableTeamCount(restaurant_number,today);
		
	
		//레스토랑 시간별 예약 현황을 담은 resultMap
		model.addAttribute("resultMap", resultMap);
		
		
		
		//레스토랑 휴일 정보를 json 형태로 보내준다.
		JSONObject jso = new JSONObject();
		
		//레스토랑의 휴일 정보를 가져온다.
		List<HolidayDTO> holidays = holidaysDao.selectListHoliday(restaurant_number);
		
		jso.put("jsoholidays", holidays);
		
		model.addAttribute("holidays", jso);
		
		
		
		//업주 정보를 보내준다.
		OwnerDTO ownerDto = ownerDao.getOwnerInfo(restaurant_number);
		
		model.addAttribute("ownerDto", ownerDto);
		
		
		return "ReservePage";
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
		
		
		return "ReservePageTimeButtons";
	}
	
	
	
	
	
	//고객의 예약 정보를 reserve테이블에 넣는 처리
	@RequestMapping(value="/reserveData.do",method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String insertReserveData(ReserveDTO reserveDto,BindingResult bindingResult,HttpServletResponse resp){
		
		
		resp.setContentType("text/html;charset=UTF-8");
			
		JSONObject jso = new JSONObject();
			
		
		int resultNum =reserveDao.insertReserveData(reserveDto);
		
		if(resultNum == 1 ){
			
			jso.put("insertOk", "예약이 정상처리되었습니다.");
		}else{
			jso.put("insertOk", "예약이 완료되지 않았습니다.");
		}
		
		
		
		return jso.toString();
	}
	
	
	
	
	
	
	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}

	
}
