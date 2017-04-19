package sns.customer.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import sns.dao.C_LoginDAO;
import sns.dto.CustomerDTO;

@Controller
public class C_LoginController {
	
	@Autowired
	private C_LoginDAO c_LoginDao;

	public void setC_LoginDao(C_LoginDAO c_LoginDao) {
		this.c_LoginDao = c_LoginDao;
	}
	
	//첫번째 메인페이지로 이동
	@RequestMapping(value="/main.do")
	public String main(){
		System.out.println("메인페이지로이동!");
		return "customer/main/FirstMainPage";//FirstMainPage.jsp로 요청
	}
	
	//고객 로그인페이지로 이동
	@RequestMapping(value="/login.do")
	public String loginForm(){
		System.out.println("고객로그인 모달폼 get으로요청");
		return "customer/body/modal_login"; //loginForm.jsp로 넘겨준다
	}
	
	
	//고객 로그인 체크
	@RequestMapping(value=("/login.do"),method= RequestMethod.POST)
	public ModelAndView loginCheck(HttpServletRequest request, @RequestParam("userid") String userid ,@RequestParam("password") String password , ModelAndView mav){
		//입력받은 userid가 DB에 저장된 userid와 같을 때 , DB에 저장된 userid와 password를 가져온다.
		System.out.println("login.do");
		System.out.println(userid);
		System.out.println(password);
		
		CustomerDTO customerDTO = c_LoginDao.selectIdPass(userid);
		
		mav.addObject("loginForm",customerDTO); //DB에 저장된 값을 뷰페이지에 넘겨준다.
		System.out.println("파라미터유저아이디: "+userid+"디비유저아이디: "+ customerDTO.getUserid()+"디비유저비번: "+customerDTO.getPassword());		
		//로그인 성공시
		try {
			if(password.equals(customerDTO.getPassword())){
				request.getSession().setAttribute("sessionUserid",true); //userid 값으로 키 값을 준다.
				if(userid!=null){
					request.getSession().setAttribute("userid",userid);
					mav.setViewName("customer/main/C_MainPage");//로그인 성공 페이지(고객메인페이지)로 넘겨준다.
					mav.addObject("msg","success");//메시지 띄워주기
				}
			}
			
			if(!password.equals(customerDTO.getPassword())){
				mav.setViewName("customer/main/FirstMainPage");//로그인 성공 페이지(고객메인페이지)로 넘겨준다.
				mav.addObject("msg","PwFailure");
			}
			
		} catch (NullPointerException e) {
			mav.setViewName("customer/main/FirstMainPage");//로그인 실패 시 다시 로그인 창을 띄워준다. 
			mav.addObject("msg","IdFailure");//로그인 실패 메시지
			
		}	
		return mav;
	}
	
	//고객 로그아웃
	@RequestMapping("/logout.do")
	public ModelAndView logOut(HttpServletRequest request, ModelAndView mav){
		request.getSession().invalidate();//session제거!
		mav.setViewName("customer/main/FirstMainPage");
		mav.addObject("msg","logout");
		return mav;
	}
	
	//레스토랑상세페이지보기 눌렀을 때 고객 로그인하고 사용하기 위해서 (세션처리를위해) 메인페이지로 이동
	@RequestMapping(value="/requestFirstMain.do")
	public ModelAndView main(HttpServletRequest request,ModelAndView mav){
		if(request.getSession().getAttribute("sessionUserid") == null){ //세션값이 없다면
			mav.addObject("msg","alert"); //로그인하고 사용해달라는 경고메시지
			mav.setViewName("customer/main/FirstMainPage"); //main.jsp페이지로
			System.out.println("레스토랑세션값없음...");
		}
		return mav;
	}
	
	//레스토랑 상세페이지로 이동
	@RequestMapping(value="/restaurantDetailView.do")
	public ModelAndView restaurantDetailView(HttpServletRequest request, ModelAndView mav){
		mav.setViewName("restaurantDetailView");//restaurantDetailView.jsp로넘겨준다.
		System.out.println("레스토랑세션값있음!");	
		return mav; 
	}
}
