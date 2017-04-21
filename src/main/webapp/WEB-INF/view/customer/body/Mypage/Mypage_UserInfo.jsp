<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">

var AuthNum

$(document).ready(function(){
	
	
	
	$('#div_modifyForm').hide()
	$('#div_authNumber').hide()
	$('#div_btn_authNumber').hide()
	
	
	
	
	//정보수정 하기 전에 비밀번호 확인
	$('#btn_check').on('click',function(){
		
		if($('#checkPassword').val() == $('#password').val()){
			$('#div_check').hide()
			$('#div_modifyForm').show()
		}
		
		if($('#checkPassword').val() != $('#password').val()){
			alert("비밀번호가 틀렸습니다.")
			$('#checkPassword').focus();
		}
		
	})
	
	
	var emailChange = false
	
	//이메일을 변경했을 경우 인증번호창 보여주기
	$('#email').on('change',function(){
		$('#div_authNumber').show()
		$('#div_btn_authNumber').show()
		emailChange = true
	})
	
	
	
	//이메일 인증번호 버튼
	$('#btn_authNumber').on('click',function(){
		
		alert($('#email').val() + " 으로 인증번호 발송")
		var email = $('#email').val()
		
		var url = "Email_Modify.do"
		var query = "email=" + email
		
		$.ajax({
			
			type:"GET"
			,url:url
			,data:query
			,dataType:"json"
			,success:function(data){
				AuthNum = data.authNum
				console.log(AuthNum)
			}
				
			,error:function(e){
					console.log(e.responseText);
			}
			
		})
		
		
	})
	
		
		
	//정보수정 완료 유효성 검사
	$('#submit').on('click',function(){
		
		//비밀번호 유효성 검사
		if($('#password').val() == ""){
			$('#txt_password').html("<font color='red'>비밀번호를 입력해주세요</font>")
			$('#password').focus()
			return false
		}
		
		if($('#password').val() != $('#password2').val()){
			$('#txt_password').html("<font color='red'>비밀번호 불일치</font>")
			$('#password2').focus()
			return false
		}
		
		if($('#password').val() == $('#password2').val()){
			$('#txt_password').html("<font color='red'>비밀번호 일치</font>")
		}
		
		
		
		
		//고객명 유효성 검사
		if($('#name').val() == ""){
			$('#txt_name').html("<font color='red'>이름을 입력해주세요</font>")
			$('#name').focus()
			return false
		}
		
		if($('#name').val() != ""){
			$('#txt_name').html("")
		}
		
		
		
		
		//전화번호 유효성 검사
		if($('#mobile').val() == "") {
			$('#txt_mobile').html("<font color='red'>전화번호를 입력해주세요</font>")
			$('#mobile').focus()
			return false
		}
		
		if($('#mobile').val() != "") {
			$('#txt_mobile').html("")
		}
		
		
		//이메일 변경 안했을때 Submit
		if(!emailChange){
			
			
			var url = "UserInfo_Modify.do"
			var formData = new FormData()
			formData.append("userid", $('#userid').val())
			formData.append("password", $('#password').val())
			formData.append("name", $('#name').val())
			formData.append("mobile", $('#mobile').val())
			formData.append("email", $('#email').val())
				
				
			$.ajax({
				
				type:"POST"
			   	,url:url
			   	,data:formData
			   	,dataType:"json"
			    ,processData: false
			    ,contentType: false
			    ,success:function(data){
			    	alert("정보 수정이 완료되었습니다.")
			    	location.href="Mypage_Main.do";
				}
				,error:function(e){
					console.log(e.responseText)
				}	
						
			})
			
		}
		
		//이메일 변경 했을때 Submit
		else {
			
			//인증번호 유효성 검사
			if($('#authNumber').val() == ""){
				$('#txt_authNumber').html("<font color='red'>인증번호를 입력해주세요</font>")
				$('#txt_authNumber').focus()
				return false
			}
			
			if($('#authNumber').val() == AuthNum){
				$('#txt_authNumber').html("<font color='red'>인증번호 일치</font>")
			}
			
			var url = "UserInfo_Modify.do"
			var formData = new FormData()
			formData.append("userid", $('#userid').val())
			formData.append("password", $('#password').val())
			formData.append("name", $('#name').val())
			formData.append("mobile", $('#mobile').val())
			formData.append("email", $('#email').val())
				
				
			$.ajax({
				
				type:"POST"
			   	,url:url
			   	,data:formData
			   	,dataType:"json"
			    ,processData: false
			    ,contentType: false
			    ,success:function(data){
			    	alert("정보 수정이 완료되었습니다.")
			    	location.href="Mypage_Main.do";
				}
				,error:function(e){
					console.log(e.responseText)
				}	
						
			})
			
			
		}
		
		
	})
	
	$('#btn_userLeave').on('click',function(){
		
		var check = confirm("탈퇴하시겠습니까?");
		var userid = $('#userid').val()
		
		if(check) {
			
			var url = "Mypage_userLeave.do"
			var query = "userid=" + userid
			
			$.ajax({
				
				type:"GET"
				,url:url
				,data:query
				,success:function(){
					
					
					
				}
			 	,error:function(e){
					console.log(e.responseText);
				}
			
				
			})
			
		}		
		
		
	})// 탈퇴 처리 끝
		
	
})

</script>
    

		<c:set var="userInfo" value="${userInfo}"/>
		
		
		<div class="col-sm-offset-2" id="div_check">
			<div class="col-lg-6 col-sm-6">
				<h5>비밀번호를 입력해주세요</h5>
				<input type="password" class="form-control" id="checkPassword">
				<br/>
				<button id="btn_check" class="btn btn-info btn-sm">
					확인
				</button>
			</div>
		</div>
		
		
		
		<div class="col-lg-10 col-sm-10" id="div_modifyForm">
			<form class="form-horizontal">
				<div class="form-group">
					<div class="col-lg-2 col-sm-2">
			    		<label class="control-label col-sm-1" for="userid">ID</label>
			    	</div>
				    <div class="col-lg-6 col-sm-6">
				        <input type="hidden" class="form-control" id="userid" value="${userInfo.userid}"><h4>${userInfo.userid}</h4>
				    </div>
			    </div>
			    
			    <div class="form-group">
			    	<div class="col-lg-2 col-sm-2">
			      		<label class="control-label col-sm-1" for="password">Password</label>
			      	</div>
				    <div class="col-lg-6 col-sm-6">          
				        <input type="password" class="form-control" id="password" value="${userInfo.password}">
				    </div>
				    <div class="col-lg-4 col-sm-4" id="txt_password">
				    
				    </div>
			    </div>
			    
			    <div class="form-group">
			    	<div class="col-lg-2 col-sm-2"></div>
				    <div class="col-lg-6 col-sm-6">          
				        <input type="password" class="form-control" id="password2" placeholder="비밀번호를 한번 더 입력해주세요">
				    </div>
			    </div>
			    
			    <div class="form-group">
			   		<div class="col-lg-2 col-sm-2">
			      		<label class="control-label col-sm-1" for="name">Name</label>
			      	</div>
			      	<div class="col-lg-6 col-sm-6">          
			    		<input type="text" class="form-control" id="name" value="${userInfo.name}">
			      	</div>
			      	<div class="col-lg-4 col-sm-4" id="txt_name">
				    
				    </div>
			    </div>
			    
			    <div class="form-group">
			   		<div class="col-lg-2 col-sm-2">
			      		<label class="control-label col-sm-1" for="mobile">Mobile</label>
			      	</div>
			      	<div class="col-lg-6 col-sm-6">          
			    		<input type="text" class="form-control" id="mobile" value="${userInfo.mobile}">
			      	</div>
			      	<div class="col-lg-4 col-sm-4" id="txt_mobile">
				    
				    </div>
			    </div>
			    
			    <div class="form-group">
			    	<div class="col-lg-2 col-sm-2">
			      		<label class="control-label col-sm-1" for="email">Email</label>
			      	</div>
			      	<div class="col-sm-6">          
			        	<input type="email" class="form-control" id="email" value="${userInfo.email}">
			      	</div>
			      	<div class="col-lg-4 col-sm-4" id="txt_email">
				    
				    </div>
			    </div>
			    
			    <div class="form-group" id="div_btn_authNumber">
			    	<div class="col-lg-2 col-sm-2">
			      		<label class="control-label col-sm-1" for="authNumber"></label>
			      	</div>
			      	<div class="col-sm-6">          
			        	<button type="button" id="btn_authNumber" class="btn btn-info btn-sm">
			        		인증번호 전송
			        	</button>
			      	</div>
			    </div>
			    
			    <div class="form-group" id="div_authNumber">
			    	<div class="col-lg-2 col-sm-2">
			      		<label class="control-label col-sm-1" for="authNumber">authNumber</label>
			      	</div>
			      	<div class="col-sm-6">          
			        	<input type="text" class="form-control" id="authNumber">
			      	</div>
			      	<div class="col-lg-4 col-sm-4" id="txt_authNumber">
				    
				    </div>
			    </div>
			   
			    <div class="form-group">        
			      	<div class="col-sm-offset-2">
				      	<div class="col-lg-6 col-sm-6">
				        	<button type="button" class="btn btn-default" id="submit">수정</button>
				        	<button type="button" class="btn btn-default" id="cancel">취소</button>
				        </div>
				        <div class="col-lg-2 col-sm-2">
				        	<button type="button" class="btn btn-default" id="btn_userLeave">탈퇴</button>
				        </div>
			      	</div>
			    </div>
	  		</form>
		</div>
	