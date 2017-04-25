<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
				</li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
			<li>
			<p class="navbar-text"><b>${userid}</b>님 환영합니다.</p>
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


//드랍 다운을 누르면 마이 페이지 전환
$('.Mypage_Main_Open').on('click',function() {
	
	location.href="Mypage_Main.do";
	
});

</script>