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
		return "customer/main/C_Mypage_Main";
	}
	
	//고객 예약 정보 확인 처리 (테이블 reserve)
	@RequestMapping("/Mypage_Reserve.do")
	public ModelAndView mypage_reserve(HttpServletRequest request, @RequestParam(value="reserve_rno", defaultValue="10") String reserve_rno) {
		System.out.println("Reserve page");
		System.out.println(reserve_rno);
		
		String userid = (String)request.getSession().getAttribute("userid");
		
		ModelAndView mav = new ModelAndView("customer/body/Mypage/Mypage_Reserve");
		
		List<ReserveDTO> list = new ArrayList<ReserveDTO>();
		list = reserveDao.c_getReserveList(userid, reserve_rno);
		
	
		mav.addObject("reserveList", list);
		mav.addObject("reserve_rno", reserve_rno);
		return mav;
	}
	
	//고객 예약 취소 요청
	@RequestMapping("/C_reserveCancel.do")
	public String reserveCancel(@RequestParam("reserveNumber") String reserveNumber, @RequestParam("reserve_rno") String reserve_rno) {
		System.out.println("reserveCancel");
		System.out.println(reserveNumber);
		reserveDao.reserveCancel(reserveNumber);
		return "redirect:/Mypage_Reserve.do?reserve_rno="+reserve_rno;
	}

	//고객 정보수정을 위한 요청
	@RequestMapping("/Mypage_UserInfo.do")
	public ModelAndView mypage_userinfo(HttpServletRequest request) {
		String userid = (String)request.getSession().getAttribute("userid");
		
		ModelAndView mav = new ModelAndView("customer/body/Mypage/Mypage_UserInfo");
		
		CustomerDTO userInfo = new CustomerDTO();
		userInfo = customerDao.getCustomer(userid);
		mav.addObject("userInfo", userInfo);
		
		return mav;
	}
	
	//고객이 후기 리스트를 가져오기 위한 요청 처리
	@RequestMapping("/Mypage_Review.do")
	public ModelAndView mypage_review(HttpServletRequest request, @RequestParam(value="review_rno", defaultValue="10") String review_rno) {
		System.out.println("Review page");
		System.out.println(review_rno);
		ModelAndView mav = new ModelAndView("customer/body/Mypage/Mypage_Review");
		
		String userid = (String)request.getSession().getAttribute("userid");
		
		List<ReviewDTO> list = new ArrayList<ReviewDTO>();
		list = reviewDao.getReviewList(userid, review_rno);
		mav.addObject("reviewList", list);
		mav.addObject("review_rno", review_rno);
		return mav;
	}
	
	
	
	//후기 등록
	@RequestMapping("/Review_Submit.do")
	public String review_submit(HttpServletRequest request, ReviewDTO reviewDTO, String reserve_rno) {

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
		
		String path = reviewDao.imageUpload(reviewDTO);
		
		reviewDTO.setReview_filePath(path);
		reviewDao.writeReview(reviewDTO);
		
		
		System.out.println(reviewDTO.getRanking());	
		return "redirect:Mypage_Reserve.do?reserve_rno=" + reserve_rno;
		
	}
	
	@RequestMapping("/Review_ModifyModal.do")
	public ModelAndView review_modifyModal(String reserveNumber) {
		System.out.println("review_modifyModal");
		System.out.println(reserveNumber);
		ModelAndView mav = new ModelAndView("customer/body/Mypage/Mypage_ReviewModal_Modify");
		
		ReviewDTO reviewDTO = reviewDao.getReviewInfo(reserveNumber);
		
		mav.addObject("reviewDTO", reviewDTO);
		
		return mav;
		
	}
	
	@RequestMapping("/Review_reviewModify.do")
	public String review_modifySubmit(ReviewDTO reviewDTO, String review_rno) {
		System.out.println("review_modifySubmit");
		System.out.println("코멘트 : "+reviewDTO.getComments());
		System.out.println("파일 이름 : "+reviewDTO.getReview_image().getOriginalFilename());
		System.out.println("예약번호 : "+reviewDTO.getReserveNumber());
		System.out.println("코멘트 : "+reviewDTO.getComments());
		System.out.println("평점 : "+reviewDTO.getRanking());
		
		String path = reviewDao.imageModify(reviewDTO);
		
		reviewDTO.setReview_filePath(path);
		reviewDao.modifyReview(reviewDTO);
		
		return "redirect:Mypage_Review.do?review_rno=" + review_rno;
	}
	
	//고객 후기 삭제를 위한 요청 처리
	@RequestMapping("/Review_Delete.do")
	public String review_delete(String reserveNumber, String review_rno){
		System.out.println("review_delete");
		System.out.println(reserveNumber);
		
		reviewDao.deleteReview(reserveNumber);
				
		return "redirect:/Mypage_Review.do?review_rno=" + review_rno;
	}
	
	
	//review를 쓸 때 날짜를 형식에 맞춰서 바꿔주기 위한 initbinder 설정
	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}

	
}
