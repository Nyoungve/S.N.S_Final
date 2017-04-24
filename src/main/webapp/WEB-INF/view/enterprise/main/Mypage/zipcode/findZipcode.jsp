<%@page import="java.util.ArrayList"%>
<%@page import="sns.dto.ZipcodeDTO"%>
<%@page import="java.util.List"%>
<%@page import="sns.dao.RestaurantDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
<head>
<title>★S.N.S★</title>
	
	<script>
	
		function Check() {
			if (document.zipForm.area4.value == "") {
				alert("도로명을 입력하세요");
				document.zipForm.area4.focus();
				return;
			}
			document.zipForm.submit();
		}
		
		function sendAddress(zipcode, area1, area2, area3, area4) {
			var address =area1 + " " + area2;
			if(area3 = null)
			{area3 = eval(area3);}
			
			if (area3 != null) {
				address = address + " " + area3;
			}
			address = address + " " + area4;
			
			opener.document.enterInfo.zipcode.value = zipcode;
			opener.document.enterInfo.address.value = address;
			self.close();
		}
		
	
	</script>

</head>
<body>

	우편번호찾기<br/>
	<form name="zipForm" action="findZipcode.do" method="post">
		도로명 입력 : <input name="area4" type="text">
		<input type="button" value="검색" onclick= "Check();">
		<br/>
		<c:forEach var="List" items="${zipCodeList}">
			<a href="javascript:sendAddress(
				'${List.zipcode}'
				,'${List.area1}'
				,'${List.area2}'
				,'${List.area3}'
				,'${List.area4}'
			)">
				${List.zipcode}
				${List.area1}
				${List.area2}
				${List.area3}
				${List.area4}
			</a>
		<br/>
		</c:forEach>
	</form>
	<br/>
	<a href="javascript:this.close();">닫기</a>
</body>
</html>