<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 헤더 시작 -->

<header style="background-image:url(img/header.jpg)">
	<div class="header-content blur">
		<!-- 첫번째 row의 col-md-4 시작 -->

		<div class="header-content-inner col-md-4" style="margin-top: 5%;">

			<h1 id="homeHeading">
				<img alt="Stop no Show<br> 레스토랑 예약 프로그램!!" title="Stop no Show 레스토랑 예약 프로그램!!" src="img/snslogo400x400to.png"><br/>
			</h1>
		</div>
		<!-- 첫번째 row의 col-md-4 끝 -->

		<!-- 첫번째 row의 col-md-8 시작 -->
		<div class="col-md-8 div_search_select">
		<form id="searchForm" class="form-inline" action="searchRestaurant.do" method="get">
			
			<select class ="form-control" id="sido" name="sido" onchange="cityList();">	<!-- onchange로 선택이 될때마다 cityList()실행 -->
 			 <option value="">::시도선택::</option>
			</select>

				<select class ="form-control" id="city" name="city">
  				<option value="">::도시선택::</option>
				</select> 
				
				<select class="form-control" name="guestCount">
						<option value="">인원선택</option>
						<c:forEach var="i" begin="1" end="30" step="1">
						<option value="${i}">${i}명</option>
						</c:forEach>
					</select> 
				
				
				<br>  
				
					<input type="text" class="form-control" id="type" name="type" placeholder="요리 타입을 입력해주세요.">
						<div class="input-group">
						
							<input type="text" class="form-control" id="e_name" name="e_name" placeholder="업체명을 입력해주세요.">
								 <span class="input-group-btn">
								<button class="btn btn-default" type="button" onclick="search();"><span class="glyphicon glyphicon-search"></span></button>
							
							</span>
						</div> <!-- /input-group -->
				</div> <!-- /.row -->
		<!-- col-8 -->
		</form>
		</div>
 </header>		
	<!-- 첫번째 row의 col-md-8 끝-->
	<!-- 헤더 첫번째 row 끝-->
	