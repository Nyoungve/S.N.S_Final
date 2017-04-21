<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!-- 네이게이션 바 시작 -->
<nav id="mainNav" class="navbar navbar-inverse navbar-fixed-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
				<span class="sr-only">Toggle navigation</span> Menu <i class="fa fa-bars"></i>
			</button>
			<a class="navbar-brand page-scroll" href="#page-top"><img alt="Logo" src="img/snslogoTransparency30x30.png"></a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
					<!-- Home 클릭시 index3.jsp 초기 페이지로 돌아갈 수 있도록... -->
				<li><a id="home"><span class="glyphicon glyphicon-home"></span> Home</a></li>
				<li class="dropdown">
                 	<!-- MyPage버튼 -->
					<a class="dropdown-toggle Mypage_Main_Open" data-toggle="dropdown" href="#"> MyPage <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a id="Mypage_ReserveBtn"><span class="glyphicon glyphicon-book"></span> 예약현황</a></li>
						<li><a id="Mypage_UserInfoBtn"><span class="glyphicon glyphicon-cog"></span> 정보수정</a></li>
						<li><a id="Mypage_ReviewBtn"><span class="glyphicon glyphicon-list-alt"></span> 후기목록</a></li>
					</ul>
				</li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
			<li>
			<span style="font-size:20px;background-color:white;"><b>${userid}</b>님 환영합니다.</span>
            </li>
            <li>
                    <!-- Logout버튼 --> 
                    <a href="logout.do"  role="button" data-backdrop="false" ><span class="glyphicon glyphicon-log-out"></span>
 						로그아웃
					</a>
			</li>
			</ul>		
					
		</div>
	</div>
</nav>


<script type="text/javascript">	

$('#home').click( function() {
	location.href="main.do";
});



</script>