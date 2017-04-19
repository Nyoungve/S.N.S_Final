<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 

<!DOCTYPE html>
<html lang="kr">

<head>

    <!--플러그인 파일 첨부-->
	<%@include file="../../lib/library.jsp"%>

	<!-- 달력 style 지정 -->	 
	<style>
	.ui-datepicker{width:100%;font-size:30px;}
	.ui-datepicker select.ui-datepicker-month{width:100%;font-size:30px;}
	.ui-datepicker select.ui-datepicker-year{width:100%;font-size:30px;}
	</style>
    
</head>

<body id="page-top">

<c:if test="${msg=='success'}">
		<script type="text/javascript">
			alert("로그인 성공!");
		</script>
</c:if>


<!-- 로딩용 이미지 -->  

	<%@include file="../nav_bar/navbar_logout.jsp"%>
	
	<header class="row">
		<div class="header-content blur">
			<div>
				<%@include file="../header/header.jsp"%>
			</div>
		</div>
	</header>
<!--  -->
	<contents>
		<%@include file="../body/body_main.jsp"%>
	</contents>
	<footer>
		<%@include file="../footer/footer.jsp"%>
	</footer>

	<%@include file="../body/modal_login.jsp"%>
	<!-- 내가 입력한 javascirpt -->
	<script type="text/javascript">
	

	
	
	
	//오늘 날짜 yyyy-mm-dd 형식으로 Main 페이지에서 전역변수로 가지고 있는다.
	var today = null;
	
	//더보기 버튼
	$('#more').on('click',function(){
		
		var url='more.do'
		var query='dum=1';
		
		$.ajax({
			 type:"GET"
			 ,url:url
			 ,data:query
			 ,success:function(data){
				
			  $('#portfolio').append(data); 
			  
			 }
			 ,error:function(e){
				 
			  console.log(e.responseText);
			  
			 }
		})
	})
	
	//레스토랑 예약 요청
	$('#restaurant1').on('click',function(){
		//alert('asdf');
	
		
		
		//오늘 날짜 구하기
		var now = new Date();
   	    var year= now.getFullYear();
    	var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
    	var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
         
    	//날짜 형식을 yyyy-mm-dd 로 만듬
        today = year + '-' + mon + '-' + day;
      
		
    	// 레스토랑의 정보를 불러 올 때 레스토랑 번호와 오늘 날짜를 보내줘야한다.
		var url="reserve.do";
		var query="restaurant_number=0505"+"&today="+today;
		
		
		$.ajax({
			 type:"GET"
			 ,url:url
			 ,data:query
			 ,success:function(data){
				
			//id가 포트폴리오인 곳 초기화
			$('#portfolio').empty();
				
			//더 찾기 버튼 없애기
			$('#moreBtn').remove();
			
			//셀렉션 태그 id= portfolio 인 곳에 data를 text 형식으로 집어 넣는다.
			  $('#portfolio').html(data); 
			  
			 }
			 ,error:function(e){
			  console.log(e.responseText);
			 }
			
		}) //ajax 종료
		
	})
	
	
	
	</script>
	<a href="restaurantDetailView.do">레스토랑 상세페이지로 이동!</a>
</body>

</html>
    