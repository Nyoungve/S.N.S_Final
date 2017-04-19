package sns.customer.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import sns.dao.CustomerDAO;
import sns.dao.ReserveDAO;
import sns.dao.ReviewDAO;
import sns.dto.CustomerDTO;
import sns.dto.ReserveDTO;
import sns.dto.ReviewDTO;

@Controller
public class C_MyPageController {

	
	@Autowired
	private ReserveDAO reserveDao;
	
	public void setReserveDao(ReserveDAO reserveDao) {
		this.reserveDao = reserveDao;
	}

	@Autowired
	private ReviewDAO reviewDao;
	
	public void setReviewDao(ReviewDAO reviewDao) {
		this.reviewDao = reviewDao;
	}
	
	@Autowired
	private CustomerDAO customerDao;
	
	public void setCustomerDao(CustomerDAO customerDao) {
		this.customerDao = customerDao;
	}

	//고객 마이 페이지 메인으로 보내는 처리
	@RequestMapping("/Mypage_Main.do")
	public String mypage_main(HttpServletRequest request) {
		System.out.println("userid : " + request.getSession().getAttribute("userid"));
		return "customer/main/Mypage_Main";
	}
	
	//고객 예약 정보 확인 처리 (테이블 reserve)
	@RequestMapping("/Mypage_Reserve.do")
	public ModelAndView mypage_reserve(HttpServletRequest request, @RequestParam(value="end_rno", defaultValue="10") String end_rno) {
		System.out.println("Reserve page");
		System.out.println(end_rno);
		
		String userid = (String)request.getSession().getAttribute("userid");
		
		ModelAndView mav = new ModelAndView("customer/body/Mypage_Reserve");
		
		List<ReserveDTO> list = new ArrayList<ReserveDTO>();
		list = reserveDao.c_getReserveList(userid, end_rno);
		
	
		mav.addObject("reserveList", list);
		mav.addObject("end_rno", end_rno);
		return mav;
	}
	
	//고객 예약 취소 요청
	@RequestMapping("/C_reserveCancel.do")
	public String reserveCancel(@RequestParam("reserveNumber") String reserveNumber, @RequestParam("end_rno") String end_rno) {
		System.out.println("reserveCancel");
		System.out.println(reserveNumber);
		reserveDao.reserveCancel(reserveNumber);
		return "redirect:/Mypage_Reserve.do?end_rno="+end_rno;
	}

	//고객 정보수정을 위한 요청
	@RequestMapping("/Mypage_UserInfo.do")
	public ModelAndView mypage_userinfo(HttpServletRequest request) {
		String userid = (String)request.getSession().getAttribute("userid");
		
		ModelAndView mav = new ModelAndView("customer/body/Mypage_UserInfo");
		
		CustomerDTO userInfo = new CustomerDTO();
		userInfo = customerDao.getCustomer(userid);
		mav.addObject("userInfo", userInfo);
		
		return mav;
	}
	
	//고객이 후기 리스트를 가져오기 위한 요청 처리
	@RequestMapping("/Mypage_Review.do")
	public ModelAndView mypage_review(HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView("customer/body/Mypage_Review");
		
		String userid = (String)request.getSession().getAttribute("userid");
		
		List<ReviewDTO> list = new ArrayList<ReviewDTO>();
		list = reviewDao.getReviewList(userid);
		mav.addObject("reviewList", list);
		return mav;
	}
	
	
	
	//후기 등록
	@RequestMapping("/Review_Submit.do")
	public String review_submit(HttpServletRequest request, ReviewDTO reviewDTO, String end_rno) {

		String userid = (String)request.getSession().getAttribute("userid");
		
		System.out.println("코멘트 : "+reviewDTO.getComments());
		System.out.println("파일 이름 : "+reviewDTO.getReview_image().getOriginalFilename());
		System.out.println("예약번호 : "+reviewDTO.getReserveNumber());
		System.out.println("코멘트 : "+reviewDTO.getComments());
		System.out.println("평점 : "+reviewDTO.getRanking());
		
		// 사업자 등록번호와 예약날짜 가져오기
		ReserveDTO reserveDTO = reserveDao.getNum_Date(reviewDTO.getReserveNumber());
		
		reviewDTO.setRestaurant_number(reserveDTO.getRestaurant_number());
		reviewDTO.setReserve_date(reserveDTO.getReserve_date());
		reviewDTO.setUserid(userid);
		
		String path = reviewDao.upload(reviewDTO);
		
		reviewDTO.setReview_filePath(path);
		reviewDao.writeReview(reviewDTO);
		
		
		System.out.println(reviewDTO.getRanking());	
		return "redirect:Mypage_Reserve.do?end_rno=" + end_rno;
		
	}
	
	//고객 후기 삭제를 위한 요청 처리
	@RequestMapping("/Review_Delete.do")
	public String review_delete(String reserveNumber){
		System.out.println("review_delete");
		System.out.println(reserveNumber);
		
		reviewDao.deleteReview(reserveNumber);
				
		return "redirect:/Mypage_Review.do";
	}
	
	
	//review를 쓸 때 날짜를 형식에 맞춰서 바꿔주기 위한 initbinder 설정
	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}

	
}
