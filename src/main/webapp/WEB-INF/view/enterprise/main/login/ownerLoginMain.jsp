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

	<!-- 필요한 라이브 파일들 -->
   <%@include file="/WEB-INF/view/lib/library.jsp" %>
   
   <!-- 로그인 처리 시(성공,실패) 필요한 자바스크립트 -->
    <%@include file="E_Main_LoginEvent.jsp" %>   
       
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
    <header style="background-image:url(img/Enterprise_header.jpg)">
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
	<%@include file="../../footer/footer.jsp"%>
    	
	<!-- 로그인 성공 모달 -->
	<%@include file="LoginSuccess_Modal.jsp" %>
	
	<!-- 로그인 실패 모달 -->
	<%@include file="LoginFail_Modal.jsp" %>
	
</body>

</html>
    