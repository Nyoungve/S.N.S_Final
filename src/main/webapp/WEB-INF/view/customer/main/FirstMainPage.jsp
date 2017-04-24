<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="kr">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>★S.N.S★</title>
	
	<!--플러그인 파일 첨부-->
	<%@include file="../../lib/library.jsp"%>
	
	
	
	<script type="text/javascript">
	
	//오늘 날짜 yyyy-mm-dd 형식으로 Main 페이지에서 전역변수로 가지고 있는다.
	var today = null;
	var now = new Date();
	    var year= now.getFullYear();
	var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
	var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
     
	//날짜 형식을 yyyy-mm-dd 로 만듬
    today = year + '-' + mon + '-' + day;

	
	//다음에 요청할 페이지 번호를 가지고 있는 전역변수
	var pageNum = 2;
	
	function request(restaurant_number){
		alert('request 함수 호출');
		console.log(restaurant_number)
		console.log(today)
		
		location.href="reserve.do?restaurant_number="+restaurant_number+"&today="+today;
		
	}

$(function(){
	
	//더보기 버튼
	$('#more').on('click',function(){
		
		
		var url='more.do'
		var query='pageNum='+pageNum;
		       
		console.log(query)
		
		$.ajax({
			 type:"GET"
			 ,url:url
			 ,data:query
			 ,success:function(data){
			
			  $('#portfolio').append(data); 
			  
			  //다음 요청할 페이지 번호를 1 증가시킨다.
			  pageNum = pageNum+1;
			 
			 }
			 ,error:function(e){
			  console.log(e.responseText);
			 }
		})
	})
	
	
})	
	
	
	</script>

</head>

<body id="page-top">

<!-- 로딩용 이미지 -->  
   
	<%@include file="../nav_bar/navbar.jsp"%>
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
<contents>
	
	<footer>
		<%@include file="../footer/footer.jsp"%>
	</footer>

	<%@include file="../body/modal_login.jsp"%>
	
	<!-- 내가 입력한 javascirpt -->
	<c:if test="${msg=='PwFailure'}">
			<script type="text/javascript">
				alert("로그인 비밀번호를 확인해주세요!");
				location.href="main.do"
			</script>
	</c:if>
		
	<c:if test="${msg=='IdFailure'}">
			<script type="text/javascript">
				alert("로그인 아이디를 확인해주세요!");
				location.href="main.do"
			</script>
	</c:if>
	
	<c:if test="${msg=='alert'}">
	<script type="text/javascript">
		alert("로그인 후 이용해 주세요!^^");
	</script>
	</c:if>
	
	<c:if test="${msg=='logout'}">
		<script type="text/javascript">
			alert("로그아웃 되었습니다.");
		</script>
	</c:if>
	

</body>

</html>
    