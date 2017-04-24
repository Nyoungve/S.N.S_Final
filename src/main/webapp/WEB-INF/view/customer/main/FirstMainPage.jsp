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
	
	
	//레스토랑 예약정보
	function request(restaurant_number){
		alert('request 함수 호출');
		console.log(restaurant_number)
		console.log(today)
		
		location.href="reserve.do?restaurant_number="+restaurant_number+"&today="+today;
		
	}

	//시도 리스트 가져오기
	function cityList() {
		
		var snum=$("#sido").val();
		// ID가 sido인 요소의 값을 불러옴
		if(snum=="") {	                // snum에 ""가 선택되어있다면
			$("#city option").each(function() {	//ID가 city이며 option인 요소를 
				$("#city option:eq(1)").remove();	//city option의 1번째를 계속 삭제(0번째만 남기고 모두 지우게 된다) ,  eq : 지정된 index 번째의 엘리먼트 선택
			});

			//$("#city").append("<option value=''>::도시선택::</option>");	// 위의 반복문으로 모두 삭제되어 있으므로 추가해준다.
			// 위의 명령문은 바로의 위의 엘리먼트가 1이아닌 0이었을 때 사용하면 됨.
			return;
		}
		
		var url="cityList.do";
		var params="snum="+snum+"&dumi="+new Date();
		
		$.ajax({
			type:"post"
			,url:url	
			,data:params
			,dataType:"json"
			,success:function(args){
				
				$("#city option").each(function() {	//id가 city인 option요소에 적용할 반복문
					$("#city option:eq(0)").remove();	// city option의 0번째 항목이 없을때까지 0번쨰 항목을 지운다. (기존에 있는거 모두 지운다.)
				});

				 $("#city").append("<option value=''>::도시선택::</option>");	// 도시선택을 붙인다.
				 
				 for(var idx=0; idx<args.data1.length; idx++) {	// 새로 가져온 데이터를 데이터 갯수만큼 반복해서 붙여준다.
					 $("#city").append("<option value='"+args.data1[idx]+"'>"+args.data1[idx]+"</option>");	
	// append : 셀렉터로 선택된 (여기서는 id가 city인 ) 자식에게 계속 내용을 붙여준다. 기존 자식이 있다면 그 뒤에 붙여줌.
				 } 
			}
		    ,error:function(e) {
		    	alert(e.responseText);
		    }
		});
	}

	
	
$(function(){
	
	
	// 시도테이블의 리스트 가져오기
	var url="sidoList.do";
	
	//  경로 설정
	// http://localhost:8181/Srping_MVC/abc/index.jsp에서  'a.jsp'요청하면
	// http://localhost:8181/Srping_MVC/abc/a.jsp
	
	// '/a.jsp' 요청하면  http://localhost:8181/Srping_MVC/a.jsp

	var params="dumi="+new Date();
	
	$.ajax({
		type:"post"		// 포스트방식
		,url:url		// url 주소
		,data:params	//  요청에 전달되는 프로퍼티를 가진 객체
		,dataType:"json"
		,success:function(args){	//응답이 성공 상태 코드를 반환하면 호출되는 함수
			
			for(var idx=0; idx<args.data.length; idx++) { //리스트였는데 배열처럼 꺼내오게된다.
				 $("#sido").append("<option value='"+args.data[idx]+"'>"+args.data[idx]+"</option>");
				 //id가 sido인 요소선택
				 //append로 기존 셀렉터로 선택된 요소 다음에 다음내용이 들어감
				 //<option value='0'>서울</option> 이런식으로 sido의 요소안에 자식으로 들어감
   // args.data[idx] : args 는 function(args)의 인자. data는 controller.java에서 json객체에 넣어준 key(여기서는 list가 값이 된다). [idx]는 list의 몇번쨰 데이터를 가져올지 배열을 나타냄
			 }
		}
	
	    ,error:function(e) {	// 이곳의 ajax에서 에러가 나면 얼럿창으로 에러 메시지 출력
	    	alert(e.responseText);
	    }
	});
	
	
	
	
	
	
	
	
	
	
	
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
    