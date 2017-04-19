package sns.mail.controller;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class EmailAuthController {
	
	//근데 왜 이메일을 두개 보낼깡... 
	@RequestMapping(value="/emailAuth.do",method=RequestMethod.GET)
	public ModelAndView emailAuth(HttpServletResponse response,HttpServletRequest request, @RequestParam("email") String email,String authNum) throws Exception{ 
		System.out.println("이메일인증 GET으로!");
		
		authNum = ""; 
		authNum = RandomNum();//전송할 인증번호,함수를 호출하여 리턴값을 authNum에 저장한다. 
		
		sendEmail(email.toString(),authNum); //sendEmail 함수를 호출한다. 
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("customer/email/emailCheck"); //emailCheck.jsp 를 호출한다. 
		mav.addObject("email",email); //입력받은 email파라미터와 
		mav.addObject("authNum",authNum); //랜덤값을 받아온 인증번호를 모델로 넘겨준다.
		
		return mav;
	}
	
	//난수 발생시키는 메소드
	public String RandomNum(){
		StringBuffer buffer = new StringBuffer();
		
		for(int i=0;i<=6;i++){
			
			int n = (int)(Math.random() *10);
			buffer.append(n);
			
		}
		return buffer.toString();
	}
	
	//sendEmail메소드
	public void sendEmail(String email, String authNum){
		
		String host = "smtp.naver.com"; //smtp 서버
		String subject = "S.N.S 메일인증번호 전달 안내 메세지입니다."; 
		String fromName = "S.N.S 관리자^^";
		String from = "kimny9307"; //보내는 메일
		String to1 = email; 
				
				
		String content="인증번호["+authNum+"]";
		
		try{
			
			Properties props = new Properties();
		
			//NAVER SMTP 사용함으로 설정 바꿔준다.
			props.put("mail.smtp.starttls.enable","true");
			props.put("mail.transport.protocol","smtp");
			props.put("mail.smtp.host",host); //호스트
			props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
			props.put("mail.smtp.port","465");
			props.put("mail.smtp.user",from); //보내는 사람 
			props.put("mail.smtp.auth","true");//인증 트루 
			
			Session mailSession = Session.getDefaultInstance(props, 
					new javax.mail.Authenticator(){
						protected PasswordAuthentication getPasswordAuthentication(){
							return new PasswordAuthentication("kimny9307","catdog241^^");//아이디와 비밀번호
						}
			});
			
			MimeMessage msg = new MimeMessage(mailSession);
			msg.setFrom(new InternetAddress(from, MimeUtility.encodeText(fromName,"UTF-8","B"))); //보내는사람설정
			
			InternetAddress[] address1 = {new InternetAddress(to1)};
			msg.setRecipients(Message.RecipientType.TO, address1);//받는사람설정
			msg.setSubject(subject); //제목설정
			msg.setSentDate(new java.util.Date()); //보내는 날짜 설정
			msg.setContent(content,"text/html;charset=euc-kr");//내용설정(HTML형식)
			
			
			Transport.send(msg); //메일보내기
			System.out.println("메세지 전송 완료");
						
		}catch(MessagingException e){
			e.printStackTrace();
		}catch(Exception e){
			e.printStackTrace();	
		}//try
	}//sendEmail
}
