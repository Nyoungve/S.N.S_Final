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
			</ul>
		</div>
	</nav>


<!-- 업주페이지에서 예약현황,정보수정,휴일등록,노쇼처리 버튼에 대한 이벤트 처리 -->
<script type="text/javascript" src="js/E_Mypage_Main.js"></script> 	