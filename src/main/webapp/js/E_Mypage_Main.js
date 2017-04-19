
$(function() {
	// 이벤트 등록

	var restaurant_number = $('#sessionRestaurant_number').val()
	
	// 업주 예약현황
	$(document).on('click', '#E_Mypage_ReserveBtn', function() {
			
		var url = "E_Mypage_Reserve.do"
		var query = "restaurant_number="+restaurant_number
		
			
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
				$('#divBox').append(data);

			}

			,
			error : function(e) {
				console.log(e.responseText);
			}

		})

	})

	// 업주 정보수정
	$(document).on('click', '#E_Mypage_EnterInfoBtn', function() {

		var url = "E_Mypage_EnterInfo.do"
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

		})

	})

	// 휴일 등록을 눌렀을 때
	$('#holidayBtn').on('click', function() {

		// 기존 데이터를 지워준다.
		$('#divBox').html("");

		// 달력을 세팅
		makingCalendar(defaultDate);

	})

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

	}).ajaxComplete(function() {
		$('#loadingLayout').hide();
	});

	
	// 달력 지역 세팅
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

	// 휴일 날짜 담을 공간
	var disabledDays = new Array();

	
	
	// 초기 휴일 정보 세팅
	var defaultDate = null; // 초기 달력 상태 페이지

	
	$.ajax({
		type : "GET",
		url : "holidayList.do",
		data : "restaurant_number="+restaurant_number,
		dataType : "jSON",
		success : function(data) {
			disabledDays = []
			for (var i = 0; i < data.holidays.length; i++) {

				// console.log(data.holidays[i].holiday)
				disabledDays.push(data.holidays[i].holiday);

			}

		},
		error : function(arg1) {
			console.log(arg1)
		}

	}) // ajax 종료

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
		} else if ($.inArray(date, disabledDays) >= 0) {

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
							minDate : 0,
							maxDate : '+2M',
							beforeShowDay : noBefore,
							defaultDate : defaultDate,
							onSelect : function(dateText) {

								var url = "holiday.do";

								$
										.ajax({
											type : "GET",
											url : url,
											data : "dateText=" + dateText
												+"&restaurant_number="+restaurant_number,
											dataType : "jSON",
											success : function(data) {

												// 휴일정보 초기화
												disabledDays = []

												for (var i = 0; i < data.holidays.length; i++) {

													// 휴일 정보 세팅
													disabledDays
															.push(data.holidays[i].holiday);

												}

												// 휴일이 등록되었는지 취소되었는지를 나타낸다.
												alert(data.state)

												// 기존 달력을 삭제한다.
												$("#calendar").datepicker(
														"destroy");

												// 달력 defaultDate 설정
												defaultDate = data.defaultDate

												// 달력을 다시 만든다.
												makingCalendar(defaultDate);

											} // success 메소드 종료
											,
											error : function(arg1) {
												console.log(arg1)
											}

										})

							}// onselect 종료

						}) // 데이트 피커 종료
	} // makingCalendar() 종료
}); //document.ready 종료
