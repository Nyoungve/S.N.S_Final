package sns.mail.controller;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import net.sf.json.JSONObject;

@Controller
public class Mypage_EmailController {
	
	@RequestMapping(value="/Email_Modify.do", produces ="text/plain;charset=UTF-8")
	@ResponseBody
	public String emailAuth(HttpServletResponse response, String email){
		
		response.setContentType("text/html; charset=UTF-8");
		
		String authNum = RandomNum();
		
		sendEmail(email,authNum);
		
		JSONObject jso = new JSONObject();
		jso.put("authNum", authNum);
		
		return jso.toString();
		
	}
	
	public String RandomNum(){
		StringBuffer buffer = new StringBuffer();
		
		for(int i=0;i<=6;i++){
			
			int n = (int)(Math.random() *10);
			buffer.append(n);
			
		}
		return buffer.toString();
	}
	
	
	public void sendEmail(String email, String authNum){
		String host = "smtp.naver.com";
		final String user = "lucete1104"; //이메일 아이디
		final String password= "bchan1104"; //이메일 비밀번호
		String to = email;
				
				
		String content="인증번호["+authNum+"]";
		
		try{
			Properties props = new Properties();
			props.put("mail.smtp.host", host);
			props.put("mail.smtp.auth", "true");
			
			Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator(){
				protected PasswordAuthentication getPasswordAuthentication(){
					return new PasswordAuthentication(user,password);
				}
				
			} );
			
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(user));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
			
			//subject
			message.setSubject("S.N.S 인증번호 발송");
			
			//Text
			message.setText("[인증번호 : " + authNum +"]");
			
			//send
			
			Transport.send(message);
			System.out.println("메세지 전송 완료");
						
		} catch(Exception e){
			e.printStackTrace();
		}//try
		
		
	}//sendEmail

}
