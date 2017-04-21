var holidaysDaysarr = new Array(); // 휴일 날짜 담을 공간

// 초기 달력 상태 페이지
var defaultDate = null; 
// 레스토랑 넘버
var restaurant_number = $('#sessionRestaurant_number').val();

//달력 지역 세팅
$.datepicker.regional['ko'] = {
	monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월',
			'10월', '11월', '12월' ],
	monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월',
			'9월', '10월', '11월', '12월' ],
	dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
	dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
	dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
	weekHeader : 'Wk',
	dateFormat : 'yy-mm-dd',
	firstDay : 0,
	isRTL : false,
	showMonthAfterYear : true,
	yearSuffix : ''
};

$.datepicker.setDefaults($.datepicker.regional['ko']);


//업주 휴일 정보를 가져오는 ajax
$.ajax({
	type : "GET",
	url : "holidayList.do",
	data : "restaurant_number="+restaurant_number,
	dataType : "jSON",
	success : function(data) {
		holidaysDaysarr = []
		for (var i = 0; i < data.holidays.length; i++) {

			// console.log(data.holidays[i].holiday)
			holidaysDaysarr.push(data.holidays[i].holiday);

		}

	},
	error : function(arg1) {
		console.log(arg1)
	}

}) // ajax 종료
//=======================================초기 달력 설정 끝=======================================

//=======================================document.ready=======================================
$(function() {
		
//	======================================= 업주가 예약현황을 눌렀을 때 시작=======================================
	// 업주 예약현황
	$(document).on('click', '#E_Mypage_ReserveBtn', function() {
		
		alert('예약현황')
		var url = "E_Mypage_Reserve.do"
		var query = "restaurant_number="+restaurant_number
		
		//예약현황 가져오는 ajax	
		$.ajax({

			type : "GET",
			url : url,
			data : query,
			success : function(data) {

				// 기존 결과 값이 있으면 없애준다.
				$('#divBox').html("");

				// 기존에 불러온 캘린더가 있으면 없애준다.
				$("#calendar").datepicker("destroy");

				// 처리된 데이터를 뿌려준다.
				$('#divBox').html(data);

			}

			,
			error : function(e) {
				console.log(e.responseText);
			}

		}) //ajax 끝

	}) //업주 예약 현황 끝
//	======================================= 업주가 예약현황을 눌렀을 때 끝 =======================================
	

//=======================================업주가 정보수정을 눌렀을 때 시작=======================================	
	// 업주 정보수정
	$(document).on('click', '#E_Mypage_EnterInfoBtn', function() {

		var url = "E_Mypage_EnterInfo.do"
		var query = "restaurant_number="+restaurant_number

		//정보 수정 시 레스토랑 초기 정보를 가져오는 ajax
		$.ajax({

			type : "POST",
			url : url,
			data : query,
			success : function(data) {

				// 기존 데이터를 지워준다.
				$('#divBox').html("");

				// 기존에 불러온 캘린더가 있으면 없애준다.
				$("#calendar").datepicker("destroy");

				// 처리된 데이터를 뿌려준다.
				$('#divBox').append(data);

			}

			,
			error : function(e) {
				console.log(e.responseText);
			}

		})//ajax 끝
			
		}) //업주 정보수정 끝

//=======================================업주가 정보수정을 눌렀을 때 끝=======================================
		  
//======================================= 노쇼 리스트를 눌렀을 때 시작=======================================	
	//노쇼리스트를 눌렀을 때 확정 처리
		$(document).on('click','#E_Mypage_NoShowUserListBtn',function(){
			alert('노쇼리스트');
			var restaurant_number = $('#sessionRestaurant_number').val()
			
				var url = "E_Mypage_NoShowUserList.do"
				var query = "restaurant_number="+restaurant_number
				
				$.ajax({

					type : "POST",
					url : url,
					data : query,
					success : function(data) {

						// 기존 데이터를 지워준다.
						$('#divBox').html("");

						// 기존에 불러온 캘린더가 있으면 없애준다.
						$("#calendar").datepicker("destroy");

						// 처리된 데이터를 뿌려준다.
						$('#divBox').append(data);

					}

					,
					error : function(e) {
						console.log(e.responseText);
					}

				})//ajax 종료 

		}) //노쇼 리스트 눌렀을 때 이벤트 종료
		
//=======================================노쇼 리스트를 눌렀을 때 끝=======================================
		
//=======================================로그 아웃버튼을 눌렀을 때 시작=======================================	
	$(document).on('click','#E_Mypage_LogoutBtn',function(){
		
		alert('로그아웃');
		location.href="ownerlogout.do";
		
		
		
	})
		
//=======================================로그 아웃버튼을 눌렀을 때 끝=======================================		
		
//=======================================휴일버튼 눌렀을 때 시작=======================================
	
	
	
	// 휴일 등록을 눌렀을 때
	$('#holidayBtn').on('click', function() {

		alert('휴일등록클릭')
		// 기존 데이터를 지워준다.
		$('#divBox').html("");
		
		// 달력을 세팅
		makingCalendar(defaultDate);

	})

	
//=======================================휴일버튼 눌렀을 때  끝=======================================

//=======================================ajax를 동기식으로 만드는 자바 스크립트 시작=======================================
	// ajax 끝날때까지 기다리는 메소드
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

	$(document).ajaxStart(function() {
		
		$('#loading').center();
		$('#loadingLayout').fadeTo('slow', 0.5);

	}).ajaxComplete(function(){
		
		$('#loadingLayout').hide();
		
	});
	
//==========================================ajax를 동기식으로 만드는 자바 스크립트 끝======================================

//==========================================업주 예약 승인 처리 시작===================================================
	
	
	
	
//==========================================업주 예약 승인 처리 끝====================================================
//==========================================업주 예약 승인 처리 시작===================================================
	
	
	
	
	
//==========================================업주 예약 승인 처리 끝====================================================
	
}); //document.ready 종료
//=======================================ajax를 동기식으로 만드는 자바 스크립트 끝=======================================	


//=======================================내가 설정한 함수들=======================================
// 이전 날짜 막기 + 배열에 있는 값 색상 변경
function noBefore(dateStr) { // date == 모든 날짜

	var dd = dateStr.getDate();
	var mm = dateStr.getMonth() + 1;
	var yyyy = dateStr.getFullYear();

	if (dd < 10) {
		dd = '0' + dd
	}

	if (mm < 10) {
		mm = '0' + mm
	}

	var date = yyyy + '-' + mm + '-' + dd;

	if (dateStr <= new Date()) {
		return [ false ];
	} else if ($.inArray(date, holidaysDaysarr) >= 0) {

		return [ true, "Highlighted" ];

	} else if (dateStr > new Date()) {

		return [ true ];

	}

} // noBefore(dateStr) 종료


// 달력 만드는 메소드
function makingCalendar(defaultDate) {

	$("#calendar").datepicker(
					{
						inline : true,
						constrainInput : true,
						changeMonth : false,
						changeYear : false,
						maxDate : '+2M',
						beforeShowDay : noBefore,
						defaultDate : defaultDate,
						onSelect : function(dateText) {

							var url = "holiday.do";

							$.ajax({
										type : "GET",
										url : url,
										data : "dateText=" + dateText
											+"&restaurant_number="+restaurant_number,
										dataType : "jSON",
										success : function(data) {

											// 휴일정보 초기화
											holidaysDaysarr = []

											for (var i = 0; i < data.holidays.length; i++) {

												// 휴일 정보 세팅
												holidaysDaysarr.push(data.holidays[i].holiday);

											}

											// 휴일이 등록되었는지 취소되었는지를 나타낸다.
											alert(data.state)

							
											// 기존 달력을 삭제한다.
											$("#calendar").datepicker("destroy");
											
											// 달력 defaultDate 설정
											defaultDate = data.defaultDate
														
											makingCalendar(defaultDate)

										} // success 메소드 종료
										,
										error : function(arg1) {
											console.log(arg1)
										}

									})
								
						}// onselect 종료

					}) // 데이트 피커 종료
} // makingCalendar() 종료

