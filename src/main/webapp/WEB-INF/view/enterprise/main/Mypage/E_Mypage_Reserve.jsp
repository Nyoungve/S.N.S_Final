<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

	<jsp:useBean id="toDay" class="java.util.Date"/>
	<h1 style="color: white;">예약 현황</h1>
	<section style="border-radius: 20px; -moz-border-radius: 20px; -webkit-border-radius: 20px;  padding: 20px 20px 20px 20px; background-color: white;">
	<table border="1" class="table">
		<tr>
			<td>예약일자</td>
			<td>고객ID</td>
			<td>고객수</td>
			<td>상태창</td>
			<td>예약승인</td>
		</tr>
		<c:forEach var="reserveList" items="${reserveList}">
		<c:if test="${reserveList.r_state!=5}">
				<tr>
					<td>
						<fmt:formatDate value="${reserveList.reserve_date}" var="reserve_date" type="both" pattern="yyyy-MM-dd HH:mm"/>
						${reserve_date}
					</td>
					<td>
						${reserveList.userid}
					</td>
					<td>
						${reserveList.guestCount}
					</td>
					<td>
						<c:if test="${reserveList.r_state==1}">
							승인대기
						</c:if>
						<c:if test="${reserveList.r_state==2}">
							예약완료
						</c:if>
						<c:if test="${reserveList.r_state==3}">
							취소요청
						</c:if>
						<c:if test="${reserveList.r_state==4}">
							취소완료
						</c:if>
					</td>
					<td>
					
						<a href="E_reserveOk.do?restaurant_number=${reserveList.restaurant_number}&userid=${reserveList.userid}&reserve_date=${reserve_date}">승인</a>
						
						<a href="E_reserveCancel.do?restaurant_number=${reserveList.restaurant_number}&userid=${reserveList.userid}&reserve_date=${reserve_date}">취소</a>
					
					</td>
				</tr>
			</c:if>
		</c:forEach>
	</table>
	</section>

