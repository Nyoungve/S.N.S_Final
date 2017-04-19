<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String contextPath = request.getContextPath(); //첫번째 경로를 가져온다
	request.setCharacterEncoding("UTF-8");
%>
<html>
<head>
<title>회원가입</title>

<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<script>
//빈칸검사?
		
$(document).ready(function(){	
	
	$("#btnJoin").click(function(){
        // 태크.val() : 태그에 입력된 값
        // 태크.val("값") : 태그의 값을 변경 
        var userId = $("#userid").val();
        var userName = $("#username").val();
        var userPw = $("#password").val();
        var userPwOK = $("#passwordok").val();
        var userMobile = $("#mobile").val();
        var userEmail = $("#email").val();
        var userEmailCheck = $("#mailCheck").val();
        
        if(userId == ""){
            alert("아이디를 입력하세요.");
            $("#userId").focus(); // 입력포커스 이동
            return false; // 함수 종료
        }
        if(userName == ""){
            alert("이름를 입력하세요.");
            $("#userName").focus(); // 입력포커스 이동
            return false; // 함수 종료
        }
        if(userPw == ""){
            alert("비밀번호를 입력하세요.");
            $("#userPw").focus();
            return false;
        }
        if(userPw != userPwOK){
            alert("비밀번호가 일치하지 않습니다.");
            $("#userIdOK").focus(); // 입력포커스 이동
            return false; // 함수 종료
        }
        if(userMobile == ""){
            alert("전화번호를 입력해주세요.");
            $("#userMobile").focus();
            return false;
        }
        if(userEmail == ""){
            alert("이메일을 입력해주세요.");
            $("#userEmail").focus(); // 입력포커스 이동
            return false; // 함수 종료
        }
        if(userEmailCheck != "메일인증완료!!" || userEmailCheck == ""){
            alert("이메일 인증이 완료되지 않았습니다.");
            $("#userEmail").focus(); // 입력포커스 이동
            return false; // 함수 종료
        }
        // 폼 내부의 데이터를 전송할 주소
        document.joinForm.action="<%=contextPath%>/join.do"
     // 제출
     document.joinForm.submit();	
        
     });
	
	//아이디 중복 검사
	$("#btnIdCheck").click(function(){
		//alert("클릭!")
		 var userId = $("#userid").val();
		 if(userId == ""){
	            alert("아이디를 입력하세요.");
	            $("#userId").focus(); // 입력포커스 이동
	            return false; // 함수 종료
	     }
		 console.log(userId+"consolelog");
		 $.ajax({
		     	type:"POST"
		     	,url:"<%=contextPath%>/idCheck.do"
		    	,data:{
		    		"userid":$("#userid").val()
		    	}
		     	,dataType:"json"
		    	,success:function(data){
		    		//alert(data);
		    		console.log(data.customerDTO);
		  			console.log(userId);
		    		//alert("데이터보내기 성공!");
		    		if(data.customerDTO){ //DB에서 넘어온 데이터가 입력폼에 입력받은 데이터와 같다면 
		    			//alert("이미 사용중인 아이디입니다!! >_<!! ");
		    			
		    			//span에 값넣기
		    			$("#idCheck").text("이미 사용중인 아이디입니다!!>..<");
		    			
		    			return false;
		    		}else{
		    			//이쪽으로 안넘어오고 바로 에러 페이지로 간당...ㅠㅠ
		    			//alert("사용가능한 아이디입니다~^^*")
		    			return false;
		    		}
		    	},
		    	error:function(data){
		    		if(data.customerDTO != userId){
		    			//alert("사용가능한 아이디 입니다!(^*^)☆")
		    			
		    			//span에 값넣기
		    			$("#idCheck").text("사용가능한 아이디 입니다!(^*^)☆");
		    			
		    			return false; 
		    		}
		    	}
		    });
	});
	
	
	//이메일 인증
	$("#btnEmailCheck").click(function(){
		
		var userEmail = $("#email").val();
		 
		//버튼 누르면 새창 띄워주기 (인증번호받는 페이지) email을 파라미터 값으로 넘겨주므로 넘겨주어라 제발 ㅠㅠ 
		var settings = 'toolbar=0, status=0, menubar=0, scrollvars=yes, height=500, width=600';
		var target='emailAuth.do?email='+userEmail;
		
		if(userEmail == ""){
	           alert("이메일을 입력해주세요.");
	           $("#userEmail").focus(); // 입력포커스 이동
	           return false; // 함수 종료
	    }
		
		//GET방식으로 emailAuth.do로 메일보내고 인증번호를 받아온다. 
		var params ="email="+userEmail;
		console.log(userEmail);
		 $.ajax({
			type:"GET"
	     	,url:"<%=contextPath%>/emailAuth.do"
     		,data:params
	    	,success:eventSuccess //이메일인증 데이터보내기
	    	,error:function(data){
	    		alert("데이터보내기실패...ㅠㅠ");
	    	}
		 });
		 
		 //이메일인증
		 function eventSuccess(data){
			 alert("데이터보내기 성공!");
			 //데이터보내기 성공하면 또 요청해서 또 이메일 인증한다. 
			 window.open('emailAuth.do?'+params,'emailCheck',settings);
			 //var frmObj = document.joinForm; 
			 //var url = 'emailAuth.do'
			 //window.showModalDialog('emailAuth.do?'+params,window.self,settings);
			// window.open(url,'emailCheck',settings);
		
		 }
		 
	}); 
 });
 
</script>

</head>
<body>
	<!-- 내가만든 모달 회원가입 폼 -->
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">회원가입</h4>
			</div>
			
			<div class="modal-body">
			
			<%-- <form accept-charset="UTF-8" role="form" method="post" action="" id="Validation"> --%>	
			<!-- 회원가입 입력 폼 -->
			<form name="joinForm" method="post">
				<input type="hidden" name="parentId" value="10" /> 
				
				<!-- 아이디: <input type="text" id="userid" name="userid" /><input type="button" value="ID중복검사" id="btnIdCheck"/><br/><br> -->
				<div class="form-group">
						<label for="userid">아 이 디</label><br>
						<input name="userid" value='' id="userid" placeholder="아이디를 입력해주세요." type="text" class="form-joinButton" required/>
						<input type="button" class="btn btn-lg btn-primary btn-block-jointext" value="IDCheck" id="btnIdCheck">
				</div>
				
				<!-- 사용가능한지 검사 -->
				<div class="form-group">
						<span id="idCheck" style="color:red;"></span>
				</div>
				
				<!-- 이름: <input type="text" name="name" id="username" /><br/> -->
				<div class="form-group">
						<label for="name">이&nbsp;&nbsp;름</label><br>
						<input name="name" value='' id="username" placeholder="이름을 입력해 주세요" type="text" class="form-joinButton" required />
				</div>
				
				<!-- 패스워드:<input type="password" name="password" id="password"/><br/>  -->
				<div class="form-group">
						<label for="password">비밀번호</label><br>
						<input name="password" id="password" value='' placeholder="비밀번호를 입력해주세요." type="password" class="form-joinButton" required />
				</div>
				
				<!-- 패스워드확인: <input type="password" name="passwordok" id="passwordok"><br/> -->
				<div class="form-group">
						<label for="passwordok">비밀번호 확인</label><br>
						<input name="passwordok" id="passwordok" value='' placeholder="비밀번호를 다시한번 입력해주세요" type="password" class="form-joinButton" required />
				</div>
				
				<!-- 전화번호: <input type="text" name="mobile" id="mobile"/><br/> -->
				<div class="form-group">
						<label for="mobile">전화번호</label><br>
						<input name="mobile" value='' id="mobile" placeholder="전화번호를 입력해 주세요 " type="text" class="form-joinButton" required />
				</div>
				
				<!-- 이메일:<input type="text" name="email" id="email"/> -->
				<div class="form-group">
						<label for="E-mail">e-mail</label><br>
						<input name="email" value='' id="email" placeholder="이메일을 입력해 주세요" type="text" class="form-joinButton" required />
						<!-- <input type="button" value="이메일인증" name="email" id="btnEmailCheck"/><br/>-->
						<input type="button" value="이메일인증"  name="email" id="btnEmailCheck" class="btn btn-lg btn-primary btn-block-jointext">
				</div>
				
				<!-- 메일인증확인: <input type="text" name="mailCheck" id="mailCheck"/><br> -->
				<div class="form-group">
						<label for="code">☆메일인증여부☆</label><br>
						<input type="text" name="mailCheck" id="mailCheck"/>
				</div>
				
				<!-- <input type="submit" value="등록" id="btnJoin"/> -->
				<div class="form-group">
						<input type="submit" class="btn btn-lg btn-primary btn-block" value="회원가입" id="btnJoin"/>
				</div>
			
			</form><%-- </form> --%>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
</body>
</html>