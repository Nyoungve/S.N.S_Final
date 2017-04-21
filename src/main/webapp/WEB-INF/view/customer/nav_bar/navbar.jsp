<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!-- 네이게이션 바 시작 -->
<nav id="mainNav" class="navbar navbar-inverse navbar-fixed-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
				<span class="sr-only">Toggle navigation</span> Menu <i class="fa fa-bars"></i>
			</button>
			<a class="navbar-brand page-scroll" href="#page-top" role="button"><img alt="Logo" src="img/snslogoTransparency30x30.png"></a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
					<!-- 수정부탁드려욤!!! -->
					<!-- Home 클릭시 FirstMainPage.jsp 초기 페이지로 돌아갈 수 있도록... -->
				<li><a id="home" role="button"><span class="glyphicon glyphicon-home"></span> Home</a></li>
				<li><a data-toggle="modal" data-target="#Find" role="button"><span class="glyphicon glyphicon-question-sign"></span> ID/PW 찾기</a></li>
			</ul>
			
			<ul class="nav navbar-nav navbar-right">
				<!-- 회원가입 -->
               	<!-- a태그로 login.do로 get으로 url요청 -->
                <li><a data-toggle="modal" href="join.do" data-target="#SignUp" role="button" data-backdrop="false"><span class="glyphicon glyphicon-user"></span>
						회원가입
				</a>
				
				<!-- 내가 만든 회원가입 폼 content까지만 등록-->
				<div id="SignUp"  class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
					<div class="modal-dialog modal-lg">
						<div class="modal-content">
						<!-- modal_login.jsp에  header, body, footer 작성하기 -->
						</div>
					</div>
				</div>
				</li>
				<!-- 모달 회원가입 끝 -->
                 <li> <a data-toggle="modal" data-target="#Login" role="button" data-backdrop="false" ><span class="glyphicon glyphicon-log-in"></span>
 						로그인
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

$('.Mypage_Main_Open').on('click',function() {
	
	$('body').css('height','0px');
	$('header').html('');
	
	var urlMain="Mypage_Main.do";
	var query="dup=userid";
	
	$.ajax({
		type:"GET"
		,url:urlMain
		,data:query
		,success:function(arg){
			
			//ajax로 가져온 내용을 뿌리기 전 초기화
			$('#portfolio').empty();
			
			//더보기 버튼 삭제
			$('#moreBtn').remove();
			
			//셀렉션 태그 id= portfolio 인 곳에 data를 text 형식으로 집어 넣는다.
			$('#portfolio').html(arg);
			
		}
	 	,error:function(e){
		  console.log(e.responseText);
		 }
		
	});
	
});


</script>