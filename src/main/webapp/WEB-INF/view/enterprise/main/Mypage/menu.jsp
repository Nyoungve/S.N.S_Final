<%@ page language="java" contentType="text/html; charset=UTF-8" %>	
	<!-- 네비 메뉴 시작 -->
	<nav id="mainNav" class="navbar navbar-default navbar-fixed-top">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#mainNavMenu">
			        <span class="sr-only">Toggle navigation</span> Menu <i class="fa fa-bars"></i>                     
			      </button>
				<a class="navbar-brand page-scroll" href="#page-top">S.N.S</a>
			</div>
			
				${owneruserid}님 환영합니다. 사업자 등록번호: ${sessionRestaurant_number}
		<ul class="nav navbar-nav  navbar-right">
		<li id="E_Mypage_ReserveBtn">
			<a><i class="glyphicon glyphicon-cutlery"></i> 예약 정보</a>
		</li>
		<li id="E_Mypage_EnterInfoBtn">
			<a><i class="glyphicon glyphicon-list-alt"></i> 업체 정보 수정</a>
		</li>
		<li id="holidayBtn">
			<a><i class="glyphicon glyphicon-road"></i>휴일 등록</a>
		</li>
		<li id="E_Mypage_NoShowUserListBtn">
			<a><i class="glyphicon glyphicon-remove"></i> 노쇼 처리 회원목록</a>
		</li>
		<li id="E_Mypage_LogoutBtn">
			<a>로그 아웃</a>
		</li>
			</ul>
		</div>
	</nav>

 


