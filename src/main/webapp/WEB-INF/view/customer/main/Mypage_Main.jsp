<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>S.N.S</title>

<!-- 플러그인 -->
<%@include file="../../lib/library.jsp"%>

</head>
<body>
	<!-- 불러오기 -->
	<%@include file="../nav_bar/navbar_logout.jsp"%>
	<%@include file="../header/header.jsp"%>
	
	
	<section id="reviewSection" style="height: 100% ">
    	<div class="container">
			<div class="col-lg-2 col-sm-2"></div>
			<div id="jemok" class="col-lg-10 col-sm-10"><h2>마이페이지</h2></div>
	  		<div id="resultTable" class="col-lg-10 col-sm-10"></div>
		</div>
	</section>

	<!-- 불러오기 -->
	<%@include file="../footer/footer.jsp"%>
	<%@include file="../ajax/Mypage_Ajax.jsp"%>
</body>
</html>