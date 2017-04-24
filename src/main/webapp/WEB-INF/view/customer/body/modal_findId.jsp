<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String contextPath = request.getContextPath(); //첫번째 경로를 가져온다
	request.setCharacterEncoding("UTF-8");
%>

<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<script>
//빈칸검사?
$(document).ready(function(){
	//아이디 찾기 버튼
	//이메일을 입력하면, 존재하는 이메일인지 아닌지 검사하고... 
	//존재하는 이메일이면 아이디를 보여준다.
	$("#btnFindId").click(function(){
		//alert("클릭!")
        var userEmail = $("#email").val();
        if(userEmail == ""){
            alert("이메일을 입력해주세요.");
            $("#userEmail").focus(); // 입력포커스 이동
            return false; // 함수 종료
        }
		 $.ajax({
		     	type:"POST"
		     	,url:"<%=contextPath%>/findId.do"
		    	,data:{
		    		"email":$("#email").val() //이메일 꺼내오기
		    	}
		     	,dataType:"json"
		    	,success:function(data){
		    		//alert("데이터보내고 받아오기? 성공!");
		    		if(data.customerEmail!=null&&data.customerUserid!=null){
			    		alert("귀하의 아이디는, ["+ data.customerUserid +"] 입니다!");
		    		}else{
		    			alert("존재하지않는 이메일 입니다.")
		    		}
		    	},
		    	error:function(request,status,error){
		    		alert("에러발생!\n"+"code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    	}
		    });
	});
 });
</script>


	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-label="Close">
			<span aria-hidden="true">&times;</span>
		</button>
		<h4 class="modal-title" id="myModalLabel">ID찾기</h4>
	</div>
	<div class="modal-body">
		<form accept-charset="UTF-8"  name="findId" role="form" method="post" action=""
			id="IDSearch">
			<div class="form-group">
				<input type="text" class="form-control"
					placeholder="E-mail을 입력해주세요." id="email" name="email" required>
			</div>
			<div class="form-group">
				<input type="submit" class="btn btn-lg btn-primary btn-block" id="btnFindId"
					value="ID 찾기" /><br>
				<p class="" id="IDResult"></p>
			</div>
		</form>
		<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		</div>
	</div>

