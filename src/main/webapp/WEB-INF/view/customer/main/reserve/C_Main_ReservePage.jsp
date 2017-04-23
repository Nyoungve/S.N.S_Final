<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
     
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!--플러그인 파일 첨부-->
	<%@include file="/WEB-INF/view/lib/library.jsp"%>

<!-- 달력 style 지정 -->	 
	<style>
	.ui-datepicker{width:100%;font-size:30px;}
	.ui-datepicker select.ui-datepicker-month{width:100%;font-size:30px;}
	.ui-datepicker select.ui-datepicker-year{width:100%;font-size:30px;}
	</style>
	
	
<!-- 지도 사용을 위한 스크립트 추가 -->
<!-- parsing block 에러는 소스가 너무 커서 네트워크가 느릴 때에는 보여지지 않을 수 있다는 것을 의미 -->
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=6341df44f6867a64500e499940c61c9a&libraries=services"></script>
    
<!-- 결제 요청을 위한 스크립트 추가 -->
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.2.js"></script>

<!-- 달력 표시를 위한 스크립트 -->
<script type="text/javascript">


//오늘 날짜 yyyy-mm-dd 형식으로 Main 페이지에서 전역변수로 가지고 있는다.
var today = null;
var now = new Date();
    var year= now.getFullYear();
var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
 
//날짜 형식을 yyyy-mm-dd 로 만듬
today = year + '-' + mon + '-' + day;

//예약 시간
var reserveTime = null;

//휴일정보를 담을 배열
var arrHoliday = new Array();

//휴일 jso에서 dto들 배열을 holidays에 담는다.
var holidays = ${holidays.jsoholidays}

//holidays 배열에서 각각의 키값인 holiday의 value값을 가져와서 배열에 담는다. 
for(var i =0;i<holidays.length;i++){
	 arrHoliday.push(holidays[i].holiday)	 
}

//달력 설정
$.datepicker.regional['ko'] = {
		closeText: '닫기'
		,prevText: '이전달'
		,nextText: '다음달'
		,currentText: '오늘'
		,monthNames: ['1월(JAN)','2월(FEB)','3월(MAR)','4월(APR)','5월(MAY)','6월(JUN)','7월(JUL)','8월(AUG)','9월(SEP)','10월(OCT)','11월(NOV)','12월(DEC)']
		,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
		,dayNames: ['일','월','화','수','목','금','토']
		,dayNamesShort: ['일','월','화','수','목','금','토']
		,dayNamesMin: ['일','월','화','수','목','금','토']
		,weekHeader: 'Wk'
		,dateFormat: 'yy-mm-dd',firstDay: 0
		,isRTL: false
		,showMonthAfterYear: true
		,yearSuffix: ''};


$.datepicker.setDefaults($.datepicker.regional['ko']);




//--------------------------------------------------------초기세팅 끝--------------------------------

//-----------------------------------------------내가 등록한 메소스들 시작-------------------------------
//업주가 휴일로 등록한 날을 막는 메소드

function disableAllTheseDays(date) {

	var year= date.getFullYear();
	var mon = (date.getMonth()+1)>9 ? ''+(date.getMonth()+1) : '0'+(date.getMonth()+1);
	var day = date.getDate()>9 ? ''+date.getDate() : '0'+date.getDate();
     
	var qwer = year + '-' +mon + '-' + day
	
    for (i = 0; i < arrHoliday.length; i++) {
		
        if($.inArray(qwer, arrHoliday) != -1) {
            return [false];
        }
    }
    
    return [true];
     
}

//새로고침을 끄고 켤 전역변수
var settingValiable= null;
var settingValiableBoolean = false;

//setInterval시킬 함수
function timeBlockSetting(){
	
	var url="getAvailableButtomResultMap.do";
	var query="restaurant_number=${restaurantDto.restaurant_number}"+"&selectDay="+$('#testDatepicker').val();
	console.log(query)
	
	$.ajax({
		 type:"GET"
		 ,url:url
		 ,data:query
		 ,success:function(data){
			
			//원래 있던 버튼 표시창을 없애준다. 
			$('#buttonShow').html("");
						
			//버튼 표시창에 새로운 resultMap으로 세팅된 단추들을 보여준다.
			$('#buttonShow').append(data);
			 
			
		 }
		 ,error:function(e){
		  console.log(e.responseText);
		 }
		
	}) //ajax 종료	 		
		
}


//ajax 끝날때까지 기다리는 메소드
jQuery.fn.center = function() {
	this.css("position", "absolute");
	this.css("top", Math.max(0, (($(window).height() - $(this)
			.outerHeight()) / 2)
			+ $(window).scrollTop())
			+ "px");
	this.css("left", Math.max(0,
			(($(window).width() - $(this).outerWidth()) / 2)
					+ $(window).scrollLeft())
			+ "px");
	return this;
}


//예약신청 디비에 저장
function insertDBReserveData(imp_uid){
		console.log(imp_uid);
	
		var restaurant_number='${restaurantDto.restaurant_number}';
		var reserve_date = $( "#testDatepicker" ).val() +" "+reserveTime;
        var userid='${userid}';
        var deposit =  $('#people').val() *10000;
		var r_state = 1;
		var guestCount= $('#people').val();
		
      	var query="restaurant_number="+restaurant_number+"&userid="+userid+"&deposit="+deposit+"&r_state="+r_state+"&guestCount="+guestCount+"&reserve_date="+reserve_date;
      
     	console.log(query)
     
     	
      	 $.ajax({
        	 type:'GET'
        	,url:'reserveData.do'
        	,data:query
        	,dataType:"JSON"
        	,success:function(data){
        		
        		//예약 결과 알려주기
        		alert(data.insertOk)
        		
        		location.href="reserve.do?restaurant_number="+restaurant_number+"&today="+today;
 
       
        	} //success 종료
        	,error:function(arg1){
        		
        		
        		
        	}
        	
        }) //ajax 종료 */
       
} //test 종료



//결제를 위한 함수
function pay(){
	
	var IMP = window.IMP; // 생략가능
	IMP.init('imp99349216');

	
	IMP.request_pay({
	    pg : 'danal', // version 1.1.0부터 지원. 
	    pay_method : 'card',
	    merchant_uid : 'merchant_' + new Date().getTime(),
	    name : '주문명:결제테스트',
	    amount : $('#people').val() * 10000,
	    buyer_email : 'iamport@siot.do',
	    buyer_name : '구매자이름',
	    buyer_tel : '010-1234-5678',
	    buyer_addr : '서울특별시 강남구 삼성동',
	    buyer_postcode : '123-456'
	}, function(rsp) {
	    if ( rsp.success ) {
	        //결제완료
	    	var msg = '결제가 완료되었습니다.';
	        msg += '고유ID : ' + rsp.imp_uid;
	        msg += '상점 거래ID : ' + rsp.merchant_uid;
	        msg += '결제 금액 : ' + rsp.paid_amount;
	        msg += '카드 승인번호 : ' + rsp.apply_num;
	        
	       //결제 완료 후 DB로 요청
	       insertDBReserveData(rsp.imp_uid);
	        
	        
	    } else {
	        var msg = '결제에 실패하였습니다.';
	        msg += '에러내용 : ' + rsp.error_msg;
	    }
	    
	    alert(msg);
	    
	});

}

//데이터 값이 있는지 없는지 체크하고 값이 다 있다면 예약 신청
function checkValue(){
	  
	if( ${!sessionUserid}){
		alert('로그인 후 이용해주세요.')
		$('#Login').modal();
		return;
	}
	
	
	 if(reserveTime ==null){
		 $('#reserveTimeCheck').modal();
		 
		 return;
	 }
	  
	  if($('#people').val()==''){
		  $('#reservePeopleCheck').modal();
		 return;
	  }
	 
	  
	 $('#reserveData').html('예약 날짜 : '+$( "#testDatepicker" ).val() + '&nbsp;'+ '예약 시간 : '+  reserveTime + '&nbsp;'+' 예약 인원 : ' + $('#people').val()) 
	 
	 
	 //임시 요청 
	// insertDBReserveData();
	 
	 //결제 요청
	 pay(); 
} 

//-----------------------------------------------내가 등록한 메소스들 끝-------------------------------


//----------------------------------------------이벤트 등록 시작---------------------------------
//달력과 시간 입력 단추 설정
$(function(){
	
	//처음 포커스를 맞추는 이벤트  
	var val = $('#focusDiv').position().top;
    val = val-200;
    
	$('body,html').animate({scrollTop:val},300);
	
	
	//계속적으로 상황판 새로고침
	settingValiable = setInterval(timeBlockSetting,5000);

	//달력 만드는 소스
	$("#testDatepicker").datepicker({
		minDate: 0
		,beforeShowDay: disableAllTheseDays 
	 	,onSelect: function(dateText) {
		
	 	//날짜값이 찍히면 날짜에 대한 버튼 상황값을 resultMap으로 가져와야 한다.	
		timeBlockSetting();
	 
	 	if(settingValiableBoolean){
	 		console.log('인터벌 시작')
	 		settingValiableBoolean = false;
	 		settingValiable = setInterval(timeBlockSetting,5000);
	 		
	 	}
	 	
	 	}// onSelect 종료
			
	}) //datepicker메소드 종료
	 
	
	  
	  //시간 입력 단추 보였다 안 보였다.
	  $('#btn1').on('click',function(){
		  
		  var isHidden = $('#div1').is(":hidden");
			
			if(isHidden){
				$('#div1').show(100); //파라미터는 걸리는 시간.
			}else {
				$('#div1').hide(100);
			}
		  
	  });
	  
	   
	  //시간 입력 단추 중 하나값만 받아오기
	  $(document).on('click','.timeBlock',function(){
		
		
		if(!settingValiableBoolean){
			console.log('인터벌 종료')
		clearInterval(settingValiable);
		 settingValiableBoolean = true;
		}
		  //버튼들 초기화
		  $('.timeBlock').attr('class', 'timeBlock btn-lg');
		  
		  //클릭된 버튼만 class 추가
		  $(this).attr("class","timeBlock btn-lg btn-success");
		   
		  
		 //예약시간값을 저장 
		 reserveTime = $(this).attr("date-reserveTime");
			   
	  })
	  
	  
	  
	  //sub 단추를 눌렀을 때(예약 신청)
	  
	  $('#sub').on('click',function(){
		  
		  checkValue();
		 
		
	  })
	  
	  
	  //예약 임시 버튼
	  $('#btn3').on('click',function(){
		  
		  //예약 하기 전 value 체크
		  checkValue();
		  
	  })
	  
	  $(document).ajaxStart(function() {
	  	
	  	$('#loading').center();
	  	$('#loadingLayout').fadeTo('slow', 0.5);

	  }).ajaxComplete(function(){
	  	
	  	$('#loadingLayout').hide();
	  	
	  });

	  
})  //document.ready 끝



</script>

</head>

<body>

<!-- 로딩용 이미지 -->  

<c:if test="${!sessionUserid}">
<!-- 로그인 전일때 -->
<%@include file="../../nav_bar/navbar.jsp"%>
<%@include file="../../body/modal_login.jsp"%>	
</c:if>
	
<c:if test="${sessionUserid}">	
<!-- 로그인 후일때 -->	
<%@include file="/WEB-INF/view/customer/nav_bar/navbar_logout.jsp"%>
</c:if>	

<header class="row">
		<div class="header-content blur">
			<div>
				<%@include file="../../header/header.jsp"%>
			</div>
		</div>
</header>
	
	<focus id="focusDiv"></focus>


<ul class="nav nav-tabs">
    <li class="active"><a data-toggle="tab" href="#menu1">레스토랑 예약 정보</a></li>
    <li><a data-toggle="tab" href="#menu2">레스토랑 후기</a></li>
</ul>
  
<!-- 탭 내용들 -->  
<div class="tab-content">

<!-- menu1 시작(레스토랑 예약 정보)  -->
<div id="menu1" class="tab-pane fade in active">

<!-- 예약정보 html 시작 -->
<br/><br/>
<!-- 예약할 레스토랑 소개 시작 -->

<div class="container-fluid">
<div class="row">
<div class="col-md-6">
<img src="img/portfolio/thumbnails/1.jpg" class="img-rounded" alt="1.jpg"> 
</div>
<div class="col-md-6">
<h1>${restaurantDto.e_name}</h1>
<blockquote>
  ${restaurantDto.r_info}
</blockquote>
</div>
</div>
</div>
<!-- 예약할 레스토랑 소개 끝 -->
<hr>

<!-- 예약 정보 컨테이너 시작 -->
<form action="" method="GET" onsubmit="checkValue();">
<div class="container-fluid">

	<!-- 로딩용 이미지  시작-->
	<div id="loadingLayout"
		style="display: none; position: absolute; left: 0px; top: 0px; width: 100%; height: 100%; background: #eee; z-index: 9000;">
		<img id="loading" src="img/loading.gif" border="0">
	</div>
	<!-- 로딩용 이미지  끝-->


<!-- 데이트피커 표시 부분 -->
<div class="col-md-6"><div id="testDatepicker"></div></div>

<div class="col-md-6">
<h1>영업 및 예약시간대 </h1>
<blockquote>
${restaurantDto.r_time} 
</blockquote>
<br/>
<input type="button" id="btn1" class="btn-lg btn-info" value="시간을 입력해주세요"><br/>


<div id="div1"  style= "display : none;">
<!-- 날짜에 따른 버튼 시작 -->
<div id="buttonShow"><%@include file="ReservePageTimeButtons.jsp"%></div>
<!-- 날짜에 따른 버튼  끝-->
</div>

<select id="people" name="guestCount" class="form-control">
<option value="">인원을 선택해주세요</option>
<c:forEach var="i" begin="1" end="10" step="1">
<option value="${i}">${i}명</option>
</c:forEach>
</select>

<input type="button" id="sub" class="btn-lg btn-info btn-block" value="예약 신청"><br>
<!-- 임시 버튼 -->
<input type="button" id="btn3" value="예약 임시 버튼"> 

<div id="reserveData"></div>
</div><!-- col-md-6 -->
</div>
</form>
<!-- 예약 정보 컨테이너 끝 -->
<hr>
<!-- 메뉴판 이미지 시작-->
<div class="container-fluid">
<div class="col-md-6">
음식 사진
</div>
<div class="col-md-6">
메뉴판 사진
</div>
</div>
<!-- 메뉴판 이미지 끝-->
<hr>
<!-- 판매자 정보 시작-->
 <div class="container-fluid">
 
 <!-- 지도 표시 부분 -->
<div id="map" class="col-md-6" style="height:400px;"></div>


<div class="col-md-6">
<h1>판매자 정보</h1>
<blockquote>
<p>상호 : ${restaurantDto.e_name}</p>
<p>대표자명 : ${ownerDto.name}</p>
<p>소재지 : ${restaurantDto.address}</p>
<p>연락처 : ${ownerDto.mobile}</p>
</blockquote>
</div>
</div>

</div><!-- menu1 끝-->


<!-- menu2 시작(레스토랑 후기) -->
<div id="menu2" class="tab-pane fade">
<div class="container-fluid">

<%@include file="C_Main_Review.jsp" %>

</div><!-- container div -->

</div><!-- menu2 끝-->

</div><!-- tab-content -->


<!-- 판매자 정보 끝-->


<!-- 모달 메세지 시작-->
<div class="modal fade" id="reserveTimeCheck" role="dialog">
    <div class="modal-dialog" id="reserveTimeCheck"> 
      <!-- Modal content-->
      <div class="modal-content">
        
        <div class="modal-body">
          <p>시간 선택을 선택해주세요.</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
   
    </div>
    </div>
      
<div class="modal fade" id="reservePeopleCheck" role="dialog">
    <div class="modal-dialog"> 
      
      <!-- Modal content-->
      <div class="modal-content">
        
        <div class="modal-body">
          <p>인원 선택을 선택해주세요.</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
   
    </div>
    </div>    
<!-- 모달 메세지 끝 -->





<!-- 지도 표시를 위한 스크립트 -->
<script type="text/javascript">

var restaurantAddress='${restaurantDto.address}';


var mapContainer = document.getElementById('map'), // 지도를 표시할 div 

mapOption = {
    center: new daum.maps.LatLng(33.450701, 126.570667) // 지도의 중심좌표
    ,level: 3 // 지도의 확대 레벨
};  

//지도를 생성합니다    
var map = new daum.maps.Map(mapContainer, mapOption); 


//일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
var mapTypeControl = new daum.maps.MapTypeControl();

//지도에 컨트롤을 추가해야 지도위에 표시됩니다
//daum.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);

//지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
var zoomControl = new daum.maps.ZoomControl();
map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);

//주소-좌표 변환 객체를 생성합니다
var geocoder = new daum.maps.services.Geocoder();

geocoder.addr2coord(restaurantAddress, function(status, result) {

    // 정상적으로 검색이 완료됐으면 
     if (status === daum.maps.services.Status.OK) {

        var coords = new daum.maps.LatLng(result.addr[0].lat, result.addr[0].lng);

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new daum.maps.Marker({
            map: map,
            position: coords
        });

        
        // 인포윈도우로 장소에 대한 설명을 표시합니다
       // var infowindow = new daum.maps.InfoWindow({
       //     content: '<div style="width:150px;text-align:center;padding:6px 0;">우리회사</div>'
       // });
        //infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    }
})  
</script>

	</contents>
	
	<footer>
		<%@include file="/WEB-INF/view/customer/footer/footer.jsp"%>
	</footer>


</body>



</html>