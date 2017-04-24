<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String contextPath = request.getContextPath(); //첫번째 경로를 가져온다
	request.setCharacterEncoding("UTF-8");
%>


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
        } else if($("#username").val() == ""){
            alert("이름를 입력하세요.");
            $(this).focus(); // 입력포커스 이동
            return false; // 함수 종료
        } else if($("#password").val() == ""){
            alert("비밀번호를 입력하세요.");
            $(this).focus();
            return false;
        } else if($("#passwordok").val() != $("#password").val()){
            alert("비밀번호가 일치하지 않습니다.");
            $(this).focus(); // 입력포커스 이동
            return false; // 함수 종료
        } else if($("#mobile").val() == ""){
            alert("전화번호를 입력해주세요.");
            $(this).focus();
            return false;
        } else if($("#email").val() == ""){
            alert("이메일을 입력해주세요.");
            $(this).focus(); // 입력포커스 이동
            return false; // 함수 종료
        } else if($("#emailCheck2").text() != "Ok"){
            alert("이메일 인증을 완료해 주세요");
            $("#userEmail").focus(); // 입력포커스 이동
            return false; // 함수 종료
        } else {
        	alert("회원가입 완료");
        }
        // 폼 내부의 데이터를 전송할 주소
        document.joinForm.action="<%=contextPath%>/join.do"
     // 제출
     document.joinForm.submit();
        
     });
	
	
	//아이디 중복 검사
	$("#userid").on('blur',function(){
		//alert("클릭!")
		 var userId = $("#userid").val();
		 var re_id = /^[a-z0-9_-]{3,16}$/; // 아이디 유효성 검사 정규화 표현식
		 if(userId == ""){
				$("#idCheck").css("font-size", "12px");
				$("#idCheck").css("color", "#ff1a1a");
				$("#idCheck").css("font-weight", "900");
	            $("#idCheck").text("아이디를 입력하세요");
	            return false; // 함수 종료
	     } else if (re_id.test($("#userid").val()) != true) { // 입력된 아이디가 정규식과 틀리다면...
	    	 	$("#idCheck").css("font-size", "12px");
				$("#idCheck").css("color", "#ff1a1a");
				$("#idCheck").css("font-weight", "900");
	    	 	$("#idCheck").text('유효한 ID를 입력해 주세요: 영문, 숫자, 언더스코어(_), 하이픈(-)이 포함된 3~16 문자');
	    	 	$(this).val("");
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
		    			$("#idCheck").css("font-size", "12px");
		    			$("#idCheck").css("color", "#ff1a1a");
		    			$("#idCheck").css("font-weight", "900");
		    			$("#idCheck").text("이미 사용중인 아이디입니다!!>..<");
		    			return false;
		    		}else{
		    			$("#idCheck").css("font-size", "12px");
		    			$("#idCheck").css("color", "#006600");
		    			$("#idCheck").css("font-weight", "900");
		    			$("#idCheck").text("Ok");
		    			$("#idIcon").attr("class", "glyphicon glyphicon-ok");
		    			$("#idIcon").css("color", "#006600");
		    			return false;
		    		}
		    	},
		    	error:function(data){
		    		if(data.customerDTO != userId){
 		    			$("#idCheck").css("font-size", "12px");
		    			$("#idCheck").css("color", "#006600");
		    			$("#idCheck").css("font-weight", "900");
		    			$("#idCheck").text("Ok");
		    			$("#idIcon").attr("class", "glyphicon glyphicon-ok");
		    			$("#idIcon").css("color", "#006600");
		    			return false; 
		    		}
		    	}
		    });
	});
	
	//이름 유효성 검사
	$("#username").on('blur',function(){
		var re_name = /^[가-힣]{2,4}$/; // 이름 유효성 검사 정규화 표현식
		if($("#username")==""){
			$("#nameCheck").css("font-size", "12px");
			$("#nameCheck").css("color", "#ff1a1a");
			$("#nameCheck").css("font-weight", "900");
			$("#nameCheck").text('이름을 입력해 주세요');
		} else if (re_name.test($("#username").val()) != true) {
			$("#nameCheck").css("font-size", "12px");
			$("#nameCheck").css("color", "#ff1a1a");
			$("#nameCheck").css("font-weight", "900");
			$("#nameCheck").text('이름은 한글만 입력 가능 합니다.');
    	 	$(this).val("");
		} else {
			$("#nameCheck").css("font-size", "12px");
			$("#nameCheck").css("color", "#006600");
			$("#nameCheck").css("font-weight", "900");
     		$("#nameCheck").text('Ok');
     		$("#nameIcon").attr("class", "glyphicon glyphicon-ok");
			$("#nameIcon").css("color", "#006600");
		}
		
	});
	
	
	//패스워드 유효성 검사
	$("#password").on('blur',function(){
		var re_pw = /^[a-z0-9_-]{6,18}$/; // 패스워드 유효성 검사 정규화 표현식
		if($("#password").val()==""){
			$("#pwCheck1").css("font-size", "12px");
			$("#pwCheck1").css("color", "#ff1a1a");
			$("#pwCheck1").css("font-weight", "900");
    	 	$("#pwCheck1").text('패스워드를 입력해 주세요');
		} else if (re_pw.test($("#password").val()) != true) { // 입력된 패스워드가 정규식과 틀리다면...
			$("#pwCheck1").css("font-size", "12px");
			$("#pwCheck1").css("color", "#ff1a1a");
			$("#pwCheck1").css("font-weight", "900");
    	 	$("#pwCheck1").text('유효한 PW를 입력해 주세요: 영문, 숫자, 언더스코어(_), 하이픈(-) 포함 6~18문자');
    	 	$(this).val("");
     	} else {
			$("#pwCheck1").css("font-size", "12px");
			$("#pwCheck1").css("color", "#006600");
			$("#pwCheck1").css("font-weight", "900");
     		$("#pwCheck1").text('Ok');
     		$("#pw1Icon").attr("class", "glyphicon glyphicon-ok");
			$("#pw1Icon").css("color", "#006600");
     	}
	});
	
	
	//입력 된 패스워드가 동일한지 검사
    $("#passwordok").on('blur',function(){
    	if($("#passwordok").val()==$("#password").val()){
    		$("#pwCheck2").css("font-size", "12px");
			$("#pwCheck2").css("color", "#006600");
			$("#pwCheck2").css("font-weight", "900");
    		$("#pwCheck2").text("Ok");
    		$("#pw2Icon").attr("class", "glyphicon glyphicon-ok");
			$("#pw2Icon").css("color", "#006600");
    	} else {
			$("#pwCheck2").css("font-size", "12px");
			$("#pwCheck2").css("color", "#ff1a1a");
			$("#pwCheck2").css("font-weight", "900");
    		$("#pwCheck2").text("패스워드가 일치 하지 않습니다.");
    		$(this).val("");
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
			    		$("#mCheck").css("font-size", "12px");
						$("#mCheck").css("color", "#006600");
						$("#mCheck").css("font-weight", "900");
						$("#mCheck").text("Ok");
						$("#mobileIcon").attr("class", "glyphicon glyphicon-ok");
			    		$("#mobileIcon").css("color", "#006600");
						$(this).val(trans_num);
					} else {
						$("#mCheck").css("font-size", "12px");
		    			$("#mCheck").css("color", "#ff1a1a");
		    			$("#mCheck").css("font-weight", "900");
						$("#mCheck").text("유효하지 않은 전화번호 입니다.");
						$(this).val("");
					}
				} else {
					$("#mCheck").css("font-size", "12px");
	    			$("#mCheck").css("color", "#ff1a1a");
	    			$("#mCheck").css("font-weight", "900");
					$("#mCheck").text("유효하지 않은 전화번호 입니다.");
					$(this).val("");
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
			$("#emailCheck1").css("font-size", "12px");
			$("#emailCheck1").css("color", "#ff1a1a");
			$("#emailCheck1").css("font-weight", "900");
			$("#emailCheck1").text("이메일을 입력해주세요.");
           return false; // 함수 종료
	    } else if (re_mail.test($("#email").val()) != true) {
	    	$("#emailCheck1").css("font-size", "12px");
			$("#emailCheck1").css("color", "#ff1a1a");
			$("#emailCheck1").css("font-weight", "900");
			$("#emailCheck1").text("유효한 E-mail을 입력해 주세요");
			$("#userEmail").val("");
			return false;
		} else {
			$("#emailIcon").attr("class", "glyphicon glyphicon-ok");
			$("#emailIcon").css("color", "#006600");
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
	    		$("#emailCheck1").css("font-size", "12px");
				$("#emailCheck1").css("color", "#006600");
				$("#emailCheck1").css("font-weight", "900");
				$("#emailCheck1").text("Ok");
	    		$("#emailcertification").show();
				$("#emailCheck").text("");
  				var AuthNum = data.authNum;
 				$("#btncodeCheck").on('click',function(){
 					if($("#authNumber").val() == 1){
 							$("#emailCheck2").css("font-size", "12px");
 							$("#emailCheck2").css("color", "#ff1a1a");
 							$("#emailCheck2").css("font-weight", "900");
 							$("#emailCheck2").text("입력하신 이메일로 발송 된 인증번호를 입력하여 주십시오.");
 							$(this).val("");
 						} else if($("#authNumber").val() != data.authNum){
 							$("#emailCheck2").css("font-size", "12px");
 							$("#emailCheck2").css("color", "#ff1a1a");
 							$("#emailCheck2").css("font-weight", "900");
 							$("#emailCheck2").text("틀린 인증번호입니다. 인증번호를 다시 입력해주세요");
 							$(this).val("");
 						} else if($("#authNumber").val() == data.authNum){
 							$("#emailCheck2").css("font-size", "12px");
 							$("#emailCheck2").css("color", "#006600");
 							$("#emailCheck2").css("font-weight", "900");
 							$("#emailCheck2").text("Ok");
 							$("#authNumberIcon").attr("class", "glyphicon glyphicon-ok");
 			    			$("#authNumberIcon").css("color", "#006600");
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
						<label for="userid">아 이 디</label>&nbsp;&nbsp;&nbsp;
						<span id="idIcon" class="glyphicon glyphicon-remove" style="color: #ff0000"></span>
						<span class="Guidance" id="idCheck"></span><br>
						<input name="userid" value='' id="userid" placeholder="아이디를 입력해주세요." type="text" class="form-joinButton" required/>
				</div>
				
				<div class="form-group">
						<label for="name">이&nbsp;&nbsp;름</label>&nbsp;&nbsp;&nbsp;
						<span id="nameIcon" class="glyphicon glyphicon-remove" style="color: #ff0000"></span>
						<span class="Guidance" id="nameCheck"></span><br>
						<input name="name" value='' id="username" placeholder="이름을 입력해 주세요" type="text" class="form-joinButton" required />
				</div>
				
				<div class="form-group">
						<label for="password">비밀번호</label>&nbsp;&nbsp;&nbsp;
						<span id="pw1Icon" class="glyphicon glyphicon-remove" style="color: #ff0000"></span>
						<span class="Guidance" id="pwCheck1"></span><br>
						<input name="password" id="password" value='' placeholder="비밀번호를 입력해주세요." type="password" class="form-joinButton" required />
				</div>
				
				<div class="form-group">
						<label for="passwordok">비밀번호 확인</label>&nbsp;&nbsp;&nbsp;
						<span id="pw2Icon" class="glyphicon glyphicon-remove" style="color: #ff0000"></span>
						<span class="Guidance" id="pwCheck2"></span><br>
						<input name="passwordok" id="passwordok" value='' placeholder="비밀번호를 다시한번 입력해주세요" type="password" class="form-joinButton" required />
				</div>
				
				<div class="form-group">
						<label for="mobile">전화번호</label>&nbsp;&nbsp;&nbsp;
						<span id="mobileIcon" class="glyphicon glyphicon-remove" style="color: #ff0000"></span>
						<span class="Guidance" id="mCheck"></span><br>
						<input name="mobile" value='' id="mobile" placeholder="전화번호를 입력해 주세요 " type="text" class="form-joinButton" required />
				</div>
				
				<div class="form-group">
						<label for="email">e-mail</label>&nbsp;&nbsp;&nbsp;
						<span id="emailIcon" class="glyphicon glyphicon-remove" style="color: #ff0000"></span>
						<span class="Guidance" id="emailCheck1"></span><br>
						<input name="email" value='' id="email" placeholder="이메일을 입력해 주세요" type="text" class="form-joinButton" required />
						<input type="button" value="이메일인증"  name="email" id="btnEmailCheck" class="btn btn-lg btn-primary btn-block-jointext">
				</div>
				
				<div id="emailcertification" class="form-group">
						<label for="authNumber">☆인증번호 7자리를 입력하세요☆</label>&nbsp;&nbsp;&nbsp;
						<span id="authNumberIcon" class="glyphicon glyphicon-remove" style="color: #ff0000"></span>
						<span class="Guidance" id="emailCheck2"></span><br>
						<input type="text" name="authNumber" id="authNumber" class="form-joinButton">
						<input type="button" value="코드 확인"  name="email" id="btncodeCheck" class="btn btn-lg btn-primary btn-block-jointext">
				</div>
								
				<div class="form-group">
						<input type="button" class="btn btn-lg btn-primary btn-block" value="회원가입" id="btnJoin"/>
				</div>
			
			</form>
			</div>
