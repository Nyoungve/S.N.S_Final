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
$(document).ready(function(){	
 	$("#emailcertification").hide();
	$("#btnJoin").click(function(){
        // 태크.val() : 태그에 입력된 값
        // 태크.val("값") : 태그의 값을 변경 
		if($("#userid").val() == ""){
            alert("아이디를 입력하세요.");
            $(this).focus(); // 입력포커스 이동
            return false; // 함수 종료
        }
        if($("#username").val() == ""){
            alert("이름를 입력하세요.");
            $(this).focus(); // 입력포커스 이동
            return false; // 함수 종료
        }
        if($("#password").val() == ""){
            alert("비밀번호를 입력하세요.");
            $(this).focus();
            return false;
        }
        if($("#passwordok").val() != $("#password").val()){
            alert("비밀번호가 일치하지 않습니다.");
            $(this).focus(); // 입력포커스 이동
            return false; // 함수 종료
        }
        if($("#mobile").val() == ""){
            alert("전화번호를 입력해주세요.");
            $(this).focus();
            return false;
        }
        if($("#email").val() == ""){
            alert("이메일을 입력해주세요.");
            $(this).focus(); // 입력포커스 이동
            return false; // 함수 종료
        }
        if($("#emailCheck").text() != "이메일 인증이 완료되었습니다."){
            alert("이메일 인증이 완료되지 않았습니다.");
            $("#userEmail").focus(); // 입력포커스 이동
            return false; // 함수 종료
        }
        // 폼 내부의 데이터를 전송할 주소
        document.joinForm.action="<%=contextPath%>/join.do"
     // 제출
     document.joinForm.submit();
        
     });
	var pattern = /^[가-힣]{2,4}$/; // 이름 유효성 검사 정규화 표현식
	
	//아이디 중복 검사
	$("#userid").on('blur',function(){
		//alert("클릭!")
		 var userId = $("#userid").val();
		 var re_id = /^[a-z0-9_-]{3,16}$/; // 아이디 유효성 검사 정규화 표현식
		 if(userId == ""){
				$("#idCheck").css("font-size", "14px");
				$("#idCheck").css("color", "#ff1a1a");
				$("#idCheck").css("font-weight", "900");
	            $("#idCheck").text("아이디를 입력하세요");
	            $(this).focus(); // 입력포커스 이동
	            return false; // 함수 종료
	     } else if (re_id.test($("#userid").val()) != true) { // 입력된 아이디가 정규식과 틀리다면...
	    	 	$("#idCheck").css("font-size", "14px");
				$("#idCheck").css("color", "#ff1a1a");
				$("#idCheck").css("font-weight", "900");
	    	 	$("#idCheck").text('유효한 ID를 입력해 주세요: 영문, 숫자, 언더스코어(_), 하이픈(-)이 포함된 3~16 문자');
	    	 	$(this).val("");
				$(this).focus();
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
		    		console.log(data.customerDTO);
		  			console.log(userId);
		    		if(data.customerDTO){ //DB에서 넘어온 데이터가 입력폼에 입력받은 데이터와 같다면 
		    			$("#idCheck").css("font-size", "14px");
		    			$("#idCheck").css("color", "#ff1a1a");
		    			$("#idCheck").css("font-weight", "900");
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
		    			$("#idCheck").css("font-size", "14px");
		    			$("#idCheck").css("color", "#006600");
		    			$("#idCheck").css("font-weight", "900");
		    			//span에 값넣기
		    			$("#idCheck").text("사용가능한 아이디 입니다!(^*^)☆");
		    			return false; 
		    		}
		    	}
		    });
	});
	
	//패스워드 유효성 검사
	$("#password").on('blur',function(){
		var re_pw = /^[a-z0-9_-]{6,18}$/; // 패스워드 유효성 검사 정규화 표현식
		if (re_pw.test($("#password").val()) != true) { // 입력된 패스워드가 정규식과 틀리다면...
			$("#pwCheck1").css("font-size", "14px");
			$("#pwCheck1").css("color", "#ff1a1a");
			$("#pwCheck1").css("font-weight", "900");
    	 	$("#pwCheck1").text('유효한 PW를 입력해 주세요: 영문, 숫자, 언더스코어(_), 하이픈(-) 포함 6~18문자');
    	 	$(this).val("");
			$(this).focus();
     	} else {
			$("#pwCheck1").css("font-size", "14px");
			$("#pwCheck1").css("color", "#006600");
			$("#pwCheck1").css("font-weight", "900");
     		$("#pwCheck1").text('사용 가능한 패스워드 입니다.');
     	}
	});
	
	
	//입력 된 패스워드가 동일한지 검사
    $("#passwordok").on('blur',function(){
    	if($("#passwordok").val()==$("#password").val()){
    		$("#pwCheck2").css("font-size", "14px");
			$("#pwCheck2").css("color", "#006600");
			$("#pwCheck2").css("font-weight", "900");
    		$("#pwCheck2").text("패스워드가 일치합니다.");
    	} else {
			$("#pwCheck2").css("font-size", "14px");
			$("#pwCheck2").css("color", "#ff1a1a");
			$("#pwCheck2").css("font-weight", "900");
    		$("#pwCheck2").text("패스워드가 일치 하지 않습니다.");
    		$(this).val("");
			$(this).focus();
    	}
    });
	
	//전화번호 유효성 검사
	$("#mobile").on('keydown',function(e){
			// 숫자만 입력받기
			var trans_num = $(this).val().replace(/-/gi, '');
			var k = e.keyCode;
			if (trans_num.length >= 11 && ((k >= 48 && k <= 126) || (k >= 12592 && k <= 12687 || k == 32 || k == 229 || (k >= 45032 && k <= 55203)))) {
				e.preventDefault();
			}
		}).on('blur',function() {
			if ($(this).val() == '')
				return;
			var trans_num = $(this).val()
					.replace(/-/gi, '');
			if (trans_num != null && trans_num != '') {
				if (trans_num.length == 11 || trans_num.length == 10) {
					var regExp_ctn = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})([0-9]{3,4})([0-9]{4})$/;
					if (regExp_ctn.test(trans_num)) {
						trans_num = trans_num.replace(
							/^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?([0-9]{3,4})-?([0-9]{4})$/,"$1-$2-$3");
						$("#mCheck").text("");
						$(this).val(trans_num);
					} else {
						$("#mCheck").css("font-size", "14px");
		    			$("#mCheck").css("color", "#ff1a1a");
		    			$("#mCheck").css("font-weight", "900");
						$("#mCheck").text("유효하지 않은 전화번호 입니다.");
						$(this).val("");
						$(this).focus();
					}
				} else {
					$("#mCheck").css("font-size", "14px");
	    			$("#mCheck").css("color", "#ff1a1a");
	    			$("#mCheck").css("font-weight", "900");
					$("#mCheck").text("유효하지 않은 전화번호 입니다.");
					$(this).val("");
					$(this).focus();
				}
			}
		});
	
	
	
	
	//이메일 인증
	$("#btnEmailCheck").click(function(){
		
		var userEmail = $("#email").val();
		var re_mail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/; //이메일 유효성 검사 정규화 표현식
		 
		//버튼 누르면 새창 띄워주기 (인증번호받는 페이지) email을 파라미터 값으로 넘겨주므로 넘겨주어라 제발 ㅠㅠ 
/* 		var settings = 'toolbar=0, status=0, menubar=0, scrollvars=yes, height=500, width=600';
		var target='emailAuth.do?email='+userEmail; */
		
		if(userEmail == ""){
			$("#emailCheck").css("font-size", "14px");
			$("#emailCheck").css("color", "#ff1a1a");
			$("#emailCheck").css("font-weight", "900");
			$("#emailCheck").text("이메일을 입력해주세요.");
			$("#email").focus(); // 입력포커스 이동
           return false; // 함수 종료
	    } else if (re_mail.test($("#email").val()) != true) {
	    	$("#emailCheck").css("font-size", "14px");
			$("#emailCheck").css("color", "#ff1a1a");
			$("#emailCheck").css("font-weight", "900");
			$("#emailCheck").text("유효한 E-mail을 입력해 주세요");
			$("#userEmail").val("");
			$("#email").focus(); // 입력포커스 이동
			return false;
		} 
		//GET방식으로 emailAuth.do로 메일보내고 인증번호를 받아온다.
		console.log(userEmail);
		 $.ajax({
			type:"POST"
	     	,url:"<%=contextPath%>/emailAuth.do"
     		,data:{
	    		"email":$("#email").val()
	    	}
     		,dataType:"json"
	    	,success:function(data){ //이메일인증 데이터보내기 eventSuccess
	    		alert("데이터보내기 성공!");
	    		$("#emailcertification").show();
				$("#emailCheck").text("");
  				var AuthNum = data.authNum;
 				$("#authNumber").on('blur',function(){
 					if($("#authNumber").val() == 1){
 							$("#emailCheck").css("font-size", "14px");
 							$("#emailCheck").css("color", "#ff1a1a");
 							$("#emailCheck").css("font-weight", "900");
 							$("#emailCheck").text("입력하신 이메일로 발송 된 인증번호를 입력하여 주십시오.");
 							$(this).val("");
 							$(this).focus();
 						} else if($("#authNumber").val() != data.authNum){
 							$("#emailCheck").css("font-size", "14px");
 							$("#emailCheck").css("color", "#ff1a1a");
 							$("#emailCheck").css("font-weight", "900");
 							$("#emailCheck").text("틀린 인증번호입니다. 인증번호를 다시 입력해주세요");
 							$(this).val("");
 							$(this).focus();
 						} else if($("#authNumber").val() == data.authNum){
 							$("#emailCheck").css("font-size", "14px");
 							$("#emailCheck").css("color", "#006600");
 							$("#emailCheck").css("font-weight", "900");
 							$("#emailCheck").text("이메일 인증이 완료되었습니다.");
 						}
 				});
	    	} 
	    	,error:function(data){
	    		alert("데이터보내기실패...ㅠㅠ");
	    	}
		 });
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
			
			<!-- 회원가입 입력 폼 -->
			<form name="joinForm" method="post">
				<input type="hidden" name="parentId" value="10" /> 
				
				<div class="form-group">
						<label for="userid">아 이 디</label><br>
						<input name="userid" value='' id="userid" placeholder="아이디를 입력해주세요." type="text" class="form-joinButton" required/>
				</div>
				
				<!-- 입력된 아이디 중복검사 후 결과 출력 -->
				<div class="form-group">
						<span id="idCheck"></span>
				</div>
				
				<div class="form-group">
						<label for="name">이&nbsp;&nbsp;름</label><br>
						<input name="name" value='' id="username" placeholder="이름을 입력해 주세요" type="text" class="form-joinButton" required />
				</div>
				
				<div class="form-group">
						<label for="password">비밀번호</label><br>
						<input name="password" id="password" value='' placeholder="비밀번호를 입력해주세요." type="password" class="form-joinButton" required />
				</div>
				
				<!-- 입력된 패스워드 유효성 검사 결과 출력 -->
				<div class="form-group">
						<span id="pwCheck1"></span>
				</div>
				
				<div class="form-group">
						<label for="passwordok">비밀번호 확인</label><br>
						<input name="passwordok" id="passwordok" value='' placeholder="비밀번호를 다시한번 입력해주세요" type="password" class="form-joinButton" required />
				</div>
				
				<!-- 상단에 입력된 패스워드와 동일한지 검사 후 결과 출력 -->
				<div class="form-group">
						<span id="pwCheck2"></span>
				</div>
				
				<div class="form-group">
						<label for="mobile">전화번호</label><br>
						<input name="mobile" value='' id="mobile" placeholder="전화번호를 입력해 주세요 " type="text" class="form-joinButton" required />
				</div>
				
				<!-- 입력된 전화번호 유효성 검사결과 출력 -->
				<div class="form-group">
						<span id="mCheck"></span>
				</div>
				
				<div class="form-group">
						<label for="E-mail">e-mail</label><br>
						<input name="email" value='' id="email" placeholder="이메일을 입력해 주세요" type="text" class="form-joinButton" required />
						<input type="button" value="이메일인증"  name="email" id="btnEmailCheck" class="btn btn-lg btn-primary btn-block-jointext">
				</div>
				
				<div id="emailcertification" class="form-group">
						<label for="authNumber">☆인증번호 7자리를 입력하세요☆</label><br>
						<input type="text" name="authNumber" id="authNumber" class="form-joinButton">
				</div>
				
				<!-- 입력된 이메일 및 인증번호 유효성 검사결과 출력 -->
				<div class="form-group">
						<span id="emailCheck"></span>
				</div>
								
				<div class="form-group">
						<input type="button" class="btn btn-lg btn-primary btn-block" value="회원가입" id="btnJoin"/>
				</div>
			
			</form>
			</div>
</body>
</html>