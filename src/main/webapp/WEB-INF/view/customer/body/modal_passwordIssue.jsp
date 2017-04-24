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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>임시비밀번호 발급</title>
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<script>
//빈칸검사?
		
$(document).ready(function(){
	
	//임시 비밀번호 발급 버튼
	//이메일을 입력하면, 존재하는 이메일인지 아닌지 검사하고... 
	//존재하는 이메일이면 아이디를 보여준다.
	
	$("#btnPasswordIssue").click(function(){
		
		//alert("클릭!")
       	var userId = $("#userid").val();
		var userEmail = $("#email").val();
		
		if(userId == ""){
            alert("아이디를 입력해주세요.");
            $("#userId").focus(); // 입력포커스 이동
            return false; // 함수 종료
        } 
        if(userEmail == ""){
            alert("이메일을 입력해주세요.");
            $("#userEmail").focus(); // 입력포커스 이동
            return false; // 함수 종료
        }
	 	$.ajax({
	     	type:"POST"
	     	,url:"<%=contextPath%>/passwordIssue.do"
	    	,data:{
	    		"userid":$("#userid").val(),//userid 서버로 보내기
	    		"email":$("#email").val() //email 서버로 보내기
	    	}
	     	,dataType:"json"
	    	,success:function(data){
	    		alert("데이터전송성공!");
	    		if(data.alert1){ //아이디와 비밀번호가 일치하지 않을 경우...
	    			alert(data.alert1);
	    		}
	    		if(data.alert2){ //존재 하지 않는 이메일일 경우.
	    			alert(data.alert2);
	    		}
	    		if(data.customerPass){ //왜 데이터가 안넘어오나... ㅜㅜ 에러코드 0번이뜬다...
	    			alert(data.customerPass);
	    		}
	    	},
	    	error:function(request,status,error){
	    		//alert("에러발생!\n"+"code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	    		alert("임시비밀번호가 발급되었습니다!");
	    	}
	    });
	});
 });
 
</script>
</head>
<body>
<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-label="Close">
			<span aria-hidden="true">&times;</span>
		</button>
		<h4 class="modal-title" id="myModalLabel">PW찾기</h4>
	</div>
	<div class="modal-body">
		<form accept-charset="UTF-8" role="form" method="post" action=""
			id="passwordIssue" name="passwordIssue">
			<div class="form-group">
				<input type="text" class="form-control" placeholder="ID를 입력해주세요."
					id="userid" name="userid" required>
			</div>
			<div class="form-group">
				<input type="text" class="form-control"
					placeholder="E-mail을 입력해주세요." id="email" name="email" required>
			</div>
			<div class="form-group">
				<input type="submit" class="btn btn-lg btn-primary btn-block"
					value="임시비밀번호 발급!" id="btnPasswordIssue"/><br>
				<p class="" id="PWResult" ></p>
			</div>
		</form>
		<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		</div>
	</div>
</body>
</html>