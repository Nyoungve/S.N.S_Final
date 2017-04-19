<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="kr">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>S.N.S_Owner</title>

    <!-- Bootstrap Core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic,900,900italic' rel='stylesheet' type='text/css'>

    <!-- Plugin CSS -->
   <link href="vendor/magnific-popup/magnific-popup.css" rel="stylesheet">
 
    <!-- Theme CSS -->
    <link href="css/creative.min.css" rel="stylesheet">
    	<!-- jQuery -->
    <script src="vendor/jquery/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Plugin JavaScript -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
    <script src="vendor/scrollreveal/scrollreveal.min.js"></script>
    <script src="vendor/magnific-popup/jquery.magnific-popup.min.js"></script>

    <!-- Theme JavaScript -->
    <script src="js/creative.min.js"></script>


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

	
	//
	$('.closeBtn').on('click',function(){

		 window.location.href = "ownerLoginMain.do";
		
		
	})

	
	$('.ownerMain').on('mouseover',function(){
		
		$(this).css("background-color",'green')
		
	}).on('mouseout',function(){
		$(this).css("background-color",'')
	})
	
	
	$('.ownerMain').on('click',function(){
		
		var restaurant_number =$(this).find('.resNum').html()
		
		console.log(restaurant_number)
		$('#restaurant_number').val(restaurant_number);
		
		
		$('#formId').submit();
	})
	
	
})


</script>

       
</head>

<body id="page-top">
<!-- 네비 메뉴 시작 -->
    <nav id="mainNav" class="navbar navbar-default navbar-fixed-top">
        <div class="container-fluid">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
				<a class="navbar-brand page-scroll" href="#page-top">S.N.S</a>
            </div>

            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container-fluid -->
    </nav>
<!-- 네비 메뉴 끝->

<!-- 헤더 시작 -->
    <header style=" background-image:url(img/Enterprise_header.jpg)">
        <div class="header-content row">
           <div class="header-content-inner col-md-4" >
               <h1 id="homeHeading">S.N.S<br/><small>Stop no Show<br> 레스토랑 예약<br> 프로그램!!</small></h1>
            </div>
            <div class="header-content-inner col-md-4" style="margin:0 auto">
            <form accept-charset="UTF-8" role="form" method="post" action="ownerLogin.do">
				<div class="form-group">
					<label for="username">아이디</label>
					<input name="user_id" id="username" placeholder="UserID" type="text" class="form-control" required autofocus/>
				</div>
				<div class="form-group">
					<label for="password">비밀번호</label>
					<input name="password" id="password" placeholder="Password" type="password" class="form-control" required />
				</div>
				<div class="form-group">
					<input type="submit" class="btn btn-lg btn-primary btn-block" value="Login" />
				</div>
			</form>
            </div>
        </div>
    </header>
<!-- 헤더 끝-->
    <!-- footer 추가 -->	
	<%@include file="../footer/footer.jsp"%>
    	
<!-- 업주가 로그인 성공 시 관리할 레스토랑 리스트 보여주는 모달 시작 -->    	
<div class="modal fade" id="ownerRestaurantList" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
       <b>${userid}</b> 님 환영합니다.
        </div>
        <div class="modal-body">
         <p class="bg-primary">관리하실 사업장을 선택해주세요.</p>      
          <table class="table table-bordered">
    <thead>
      <tr>
        <th>사업장 등록번호</th>
        <th>레스토랑 이름</th>
        <th>레스토랑 주소</th>
      </tr>
    </thead>
    <tbody>
     <c:forEach var="restaurant" items="${restaurants}">
    		
    		<tr class="ownerMain">
    		<td class="resNum">${restaurant.restaurant_number}</td>
    		<td>${restaurant.e_name}</td>
    		<td>${restaurant.address}</td>
    		</tr>
    		
     </c:forEach>  
    
    </tbody>
  </table>
  	<!-- 폼 태그 -->
  	<form id="formId" action="ownerMain.do" method="POST">
  	<input type="hidden" id="restaurant_number" name="restaurant_number" value="">
  	</form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default closeBtn" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
<!-- 업주가 로그인 성공 시 관리할 레스토랑 리스트 보여주는 모달 끝-->

<!-- 로그인 실패 시 보여줄 모달 시작-->
<div class="modal fade" id="loginFail" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-body">
          <p>로그인에 실패했습니다.</p>
          <p>아이디와 비밀번호를 다시한번 확인해주세요.</p>
        </div>
        <div class="modal-footer">
          <button type="button"  class="btn btn-default closeBtn" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
<!-- 로그인 실패 시 보여줄 모달 끝-->

	
</body>

</html>
    