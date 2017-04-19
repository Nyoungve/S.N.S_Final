package sns.administrator.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class A_MainController {

	
	@RequestMapping("/adminMain.do")
	public String adminMain(){
		return "administratorMainPage";
	}
	
	
}
