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

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import sns.dao.C_JoinDAO;
import sns.dto.CustomerDTO;

import net.sf.json.JSONObject;


@Controller
public class EmailAuthController {
	
	//-->  id/pw 를 찾기 위한 dao 등록!!! 
	@Autowired
	private C_JoinDAO c_JoinDAO;

	public void setC_JoinDAO(C_JoinDAO c_JoinDAO) {
		this.c_JoinDAO = c_JoinDAO;
	} 
	
	//근데 왜 이메일을 두개 보낼깡...
	@RequestMapping(value="/emailAuth.do",method=RequestMethod.POST, produces ="text/plain;charset=UTF-8")
	@ResponseBody 
	public String emailAuth(HttpServletResponse response,HttpServletRequest request, @RequestParam("email") String email,String authNum, ModelAndView mav) throws Exception{ 
		System.out.println("이메일인증 POST으로!");
		response.setContentType("text/html; charset=UTF-8");
		
		authNum = ""; 
		authNum = RandomNum();//전송할 인증번호,함수를 호출하여 리턴값을 authNum에 저장한다.
		
		sendEmail(email.toString(),authNum); //sendEmail 함수를 호출한다. 
		
		JSONObject jso = new JSONObject();
		jso.put("authNum", authNum); //key값과 value값을 정해서 서버로 보내준다. json타입으로!

		mav.setViewName("forward:/join.do"); //modal_join.jsp 를 호출한다.
		return jso.toString();
	}
	
	//아이디 찾기 폼 띄우기. 
	@RequestMapping(value="/findId.do",method = RequestMethod.GET)
	public String findIdForm(){
		System.out.println("아이디찾기 get으로요청 : 뷰페이지 띄우기!");
		return "/customer/body/modal_findId"; //jsp로 넘겨준다
	}
	
	//아이디 찾기 : 사용자 이메일을 입력받아서, 이메일이 맞는 아이디와 이름을 찾아와서 보여준다. JSON 형식으로 반환하기.
	@RequestMapping(value="/findId.do",method=RequestMethod.POST, produces ="text/plain;charset=UTF-8")
	@ResponseBody 
	public String findId(HttpServletResponse response, @RequestParam(value="email") String email ,ModelAndView mav) throws Exception{
		System.out.println("id찾기!POST로!");
		response.setContentType("text/html; charset=UTF-8");
		CustomerDTO customerDTO = c_JoinDAO.idFind(email);
		JSONObject jso = new JSONObject();
		try{
			if(email.equals(customerDTO.getEmail())){ //DB의 userid와 입력받은 userid가 같을경우
				System.out.println("존재하는 이메일입니다. ");
				jso.put("customerEmail", customerDTO.getEmail()); //key값과 value값을 정해서 서버로 보내준다. json타입으로!
				jso.put("customerUserid", customerDTO.getUserid());
				return jso.toString();
			}	
		}catch(NullPointerException e){
			System.out.println(e + ": 존재하지 않는 이메일입니다.");
			mav.setViewName("/customer/body/modal_findId");//findId.jsp로 이동 
		}
		return jso.toString();
	}
	
	//비밀번호 발급창 띄우기. 
	@RequestMapping(value="/passwordIssue.do",method = RequestMethod.GET)
	public String findPass(){
		System.out.println("임시 비번 발급 get으로요청 : 뷰페이지 띄우기!");
		return "/customer/body/modal_passwordIssue"; //jsp로 넘겨준다
	}
	

	//아이디와 이메일을 입력받는다.
	//임시 비밀번호 발급받기 버튼을 누르면 임시 비밀번호를 이메일로 발송하고 
	//데이터베이스에는 발급 받은 임시 비밀번호를 update시킨다. 
	//임시 비밀번호 발급 : 아이디와 이메일을 입력받아서 이메일로 임시 비밀번호를 발급한다. 전송한다. 
	@RequestMapping(value="/passwordIssue.do",method=RequestMethod.POST, produces ="text/plain;charset=UTF-8")
	@ResponseBody 
	public String passwordIssue(HttpServletResponse response, @RequestParam(value="userid") String userid ,@RequestParam(value="email") String email ,String passIssue, ModelAndView mav,CustomerDTO customerDTO) throws Exception{
		
		System.out.println("임시password발급하기!!");
		response.setContentType("text/html; charset=UTF-8");
		//임시비밀번호 발급!
		passIssue = RandomNum();
		
		//난수로 임시비밀번호를 셋팅시킨다.
		customerDTO.setPassword(passIssue); 
		
		//해당이메일의 userid와 email을 가져온다. 
		CustomerDTO selectUserid = c_JoinDAO.idFind(email);
		
		//셋팅시킨 정보를 update()에 넣어준다.
		int resultNum = c_JoinDAO.PasswordIssue(customerDTO); //이메일을 입력받아서 난수 password로 바꿔준다.
		
		JSONObject jso = new JSONObject();
	
		try{
			if(resultNum>0){ //업데이트 시킨 행의 개수가 0개 이상일 경우
				//DB에 저장된 userid와 입력받은 userid가 같고, DB에 저장된 email과 입력받은 email이 같은 경우에만
				if(userid.equals(selectUserid.getUserid())&&email.equals(customerDTO.getEmail())){ //업데이트 되었을 경우!
					//System.out.println("존재하는 이메일입니다. ");
					//☆sendEamilPassIssue()메서드하면 alert로 데이터 전송이 되지 않는다... what the...
					sendEmailPassIssue(email.toString(), passIssue); //임시비밀번호를 이메일로 보낸다.
					jso.put("customerPass", customerDTO.getPassword()); //업데이트 되어진 임시비밀번호확인
					jso.put("customerEmail", customerDTO.getEmail()); //key값과 value값을 정해서 서버로 보내준다. json타입으로!
					jso.put("customerUserid", customerDTO.getUserid()); 
					//return jso.toString();
				}else{
					//System.out.println("아이디와 이메일이 일치하지 않습니다.");
					jso.put("alert1", "아이디와 이메일을 한번 더 확인해 주세요!");
					return jso.toString();
				}
			}
			else{ //업데이트 되지않았을 경우....!
				jso.put("alert2", "존재하지 않는 이메일 입니다!"); 
				return jso.toString();
			}
		}catch(NullPointerException e){
			System.out.println(e);
		}
		//mav.setViewName("email/passwordIssue");//joinForm.jsp로 이동 
		return jso.toString();
	}

	//sendEmailPassIssue메소드(임시비밀번호 발급메시지)
	public void sendEmailPassIssue(String email, String password) throws Exception{	
		String host = "smtp.naver.com"; //smtp 서버
		String subject = " --> S.N.S [임시비밀번호 발급] 메시지 입니다. "; 
		String fromName = "S.N.S 관리자^^";
		String from = "kimny9307"; //보내는 메일
		String to1 = email; 
					
		String content="임시비밀번호["+password+"]";
		
		try{
			Properties props = new Properties();
		
			//NAVER SMTP 사용함으로 설정 바꿔준다.
			props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.transport.protocol", "smtp");
			props.put("mail.smtp.host", host); //호스트
			props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
			props.put("mail.smtp.port", "465");
			props.put("mail.smtp.user", from); //보내는 사람 
			props.put("mail.smtp.auth", "true");//인증 트루 
			
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
			System.out.println("임시 비번 발급 완료!");
						
		}catch(MessagingException e){
			e.printStackTrace();
		}catch(Exception e){
			e.printStackTrace();	
		}//try
	}//sendEmail
		
		
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

