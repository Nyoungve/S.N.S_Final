<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
$(function(){

	//로그인 성공
	if(${userid !=null}){
		$('#ownerRestaurantList').modal({backdrop: "static"});
	}

	//로그인 실패
	if(${loginFail != null}){
		$('#loginFail').modal();
		
	}

	
	//닫기 버튼을 눌렀을 때 다시 redirect 처리
	$('.closeBtn').on('click',function(){

		 window.location.href = "ownerLoginMain.do";
		
		
	})

	
	//로그인 성공 시 사업장 색 변화
	$('.ownerMain').on('mouseover',function(){
		
		$(this).css("background-color",'green')
		
	}).on('mouseout',function(){
		$(this).css("background-color",'')
	})
	
	
	//로그인 성공 후 사업장 제출
	$('.ownerMain').on('click',function(){
		
		//사업장 클릭 시 사업장 번호를 input type="hidden"
		var restaurant_number =$(this).find('.resNum').html()
		

		$('#restaurant_number').val(restaurant_number);
		
		
		$('#formId').submit();
	})
	
	
})

</script>