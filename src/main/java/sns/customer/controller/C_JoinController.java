package sns.customer.controller;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import net.sf.json.JSONObject;
import sns.dao.C_JoinDAO;
import sns.dto.CustomerDTO;

@Controller
public class C_JoinController {
	
	@Autowired
	private C_JoinDAO c_JoinDAO;

	public void setC_JoinDAO(C_JoinDAO c_JoinDAO) {
		this.c_JoinDAO = c_JoinDAO;
	}

	@RequestMapping(value="/join.do", method =RequestMethod.GET)
	public String joinForm(){
		System.out.println("고객 회원가입 모달폼 get으로요청");
		return "customer/body/modal_join"; //modal_join.jsp로 넘겨준다.
	}
	
	//아이디중복검사
	@RequestMapping(value="/idCheck.do",method=RequestMethod.POST, produces ="text/plain;charset=UTF-8")
	@ResponseBody 
	public String loginCheck(HttpServletResponse response, @RequestParam(value="userid") String userid, ModelAndView mav) throws Exception{
		
		System.out.println("id중복검사");
		response.setContentType("text/html; charset=UTF-8");
		CustomerDTO customerDTO = c_JoinDAO.idCheck(userid);
		JSONObject jso = new JSONObject();
		jso.put("customerDTO", customerDTO.getUserid()); //key값과 value값을 정해서 서버로 보내준다. json타입으로!
		System.out.println("입력받은userid: "+userid+" , DB userid: "+ customerDTO.getUserid());
		
		mav.setViewName("customer/body/modal_join");//joinForm.jsp로 이동 
		return jso.toString();
	}
	
	//회원정보 DB에 저장!
	@RequestMapping(value="/join.do", method= RequestMethod.POST)
	public ModelAndView joinSuccess(@RequestParam("userid") String userid, CustomerDTO customerDTO, ModelAndView mav){
		System.out.println("post로요청");
		
		int resultNum = c_JoinDAO.joinCustomer(customerDTO);
		mav.addObject("joinForm", resultNum);
		mav.addObject("joinMsg","joinSuccess");
		if(resultNum ==1){
			System.out.println("DB저장성공!");
			mav.setViewName("forward:/main.do"); //메인페이지로 다시 이동. customer/body/joinSuccess
		}
		return mav;//joinSuccess 페이지로 이동
	}
	
	
}
