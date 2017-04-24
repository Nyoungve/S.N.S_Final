<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!-- 헤더 시작 -->
<header class="row">
	<div class="header-content blur">
		<!-- 첫번째 row의 col-md-4 시작 -->

		<div class="header-content-inner col-md-4" style="margin-top: 5%;">

			<h1 id="homeHeading">
				<img alt="Stop no Show<br> 레스토랑 예약 프로그램!!" title="Stop no Show 레스토랑 예약 프로그램!!" src="img/snslogo400x400to.png"><br />
			</h1>
		</div>
		<!-- 첫번째 row의 col-md-4 끝 -->

		<!-- 첫번째 row의 col-md-8 시작 -->
		<div class="col-md-8 div_search_select">
			<form class="form-inline">
				<div style="margin-bottom: 20px">
					
			<select class ="form-control" id="sido" onchange="cityList();">	<!-- onchange로 선택이 될때마다 cityList()실행 -->
 			 <option value="">::시도선택::</option>
			</select>

				<select class ="form-control" id="city">
  				<option value="">::도시선택::</option>
				</select> 
				
					<select class="form-control">
						<option value="">인원선택</option>
						<option value="2">2명</option>
						<option value="3">3명</option>
						<option value="4">4명</option>
						<option value="5">5명</option>
					</select> 
					<select class="form-control">
						<option value="">요일선택</option>
						<option value="월">월</option>
						<option value="화">화</option>
						<option value="수">수</option>
						<option value="목">목</option>
						<option value="금">금</option>
						<option value="토">토</option>
						<option value="일">일</option>
					</select>
				</div>
				<div>
					<input type="text" class="form-control" id="type" placeholder="요리 타입을 입력해주세요.">

						<div class="input-group">
							<input type="text" class="form-control" placeholder="업체명을 입력해주세요.">
								 <span class="input-group-btn">
								<button class="btn btn-default" type="button"><span class="glyphicon glyphicon-search"></span></button>
							</span>
						</div> <!-- /input-group -->
				</div> <!-- /.row -->
		</div><!-- col-8 -->
		</form>
		
	<!-- 첫번째 row의 col-md-8 끝-->
	<!-- 헤더 첫번째 row 끝-->
	
	