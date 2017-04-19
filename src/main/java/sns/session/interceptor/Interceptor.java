package sns.session.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class Interceptor extends HandlerInterceptorAdapter{
	
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler ){
		
		try{
			//sessionUserid세션값이 널일경우 
			if(request.getSession().getAttribute("sessionUserid") == null){
				//로그인 페이지로 redirect 
				response.sendRedirect("requestFirstMain.do");
				return false; 
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		//널이 아니면 정상적으로 컨트롤러 호출 
		return true; 
	}
	
}
