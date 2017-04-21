<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 버튼 표시 시작-->


<h3><mark>Lunch</mark></h3> 


<!-- 점심예약정보를 뿌려주는 맵  시작-->
<c:forEach var="i" items="${resultMap}">

<!-- 점심에 가능한 인원 availteamLunch -->
<c:set var="availteamLunch" value="${restaurantDto.teamCount - i.value}"></c:set>

<c:if test="${i.key<14}">


<c:choose>

<c:when test="${availteamLunch<=0}">
<input type="button" class="btn btn-lg btn-primary disabled" value="${i.key}:00" data-reserveDate="${sysdate}" date-reserveTime="${i.key}:00:00">
${availteamLunch}
</c:when>

<c:otherwise>
<input type="button" class="timeBlock btn-lg" value="${i.key}:00" data-reserveDate="${sysdate}" date-reserveTime="${i.key}:00:00">
${availteamLunch}
</c:otherwise>

</c:choose>
</c:if>



</c:forEach> 
<!-- 점심예약정보를 뿌려주는 맵 끝-->

<br>----------------------------------<br>

<h3><mark>Dinner</mark></h3> 

<!-- 저녁예약정보를 뿌려주는 맵 시작-->
<c:forEach var="i" items="${resultMap}">

<!-- 저녁에 가능한 인원 availteamDinner -->

<c:set var="availteamDinner" value="${restaurantDto.teamCount - i.value}"></c:set>


<c:if test="${i.key>=14}">

<c:choose>

<c:when test= "${availteamDinner<=0}" >
<input type="button" class="btn btn-lg btn-primary disabled" value="${i.key}:00" data-reserveDate="${sysdate}" date-reserveTime="${i.key}:00:00">
${availteamDinner}
</c:when>


<c:otherwise>
<input type="button" class="timeBlock btn-lg" value="${i.key}:00" data-reserveDate="${sysdate}" date-reserveTime="${i.key}:00:00">
${availteamDinner}
</c:otherwise>

</c:choose>

</c:if>

</c:forEach> 
<!-- 저녁예약정보를 뿌려주는 맵 끝-->

<!-- 버튼 표시 끝-->
