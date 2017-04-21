package sns.customer.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TestController {

	
	
	@RequestMapping("/test.do")
	public String form(HttpSession session,Model model){
		
		session.setAttribute("test1", "김");
		
		model.addAttribute("test2", "123");
		
		return "test2";
	}
	
	
	@RequestMapping("/sessionSet.do")
	public String sessionset(HttpSession session){
		session.invalidate();
		return "test2";
	}
	
	
}
