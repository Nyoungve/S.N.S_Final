<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

	<jsp:useBean id="toDay" class="java.util.Date"/>

<h1 style="color: white;">예약 현황</h1>
	<section style="border-radius: 20px; -moz-border-radius: 20px; -webkit-border-radius: 20px;  padding: 20px 20px 20px 20px; background-color: white;">
	<table border="1" class="table">
		<thead>
		<tr>
			<td>예약일자</td>
			<td>고객ID</td>
			<td>고객수</td>
			
			<td>확정(Y/N)</td>
		</tr>
		</thead>
		<tbody>
		<c:forEach var="noShow" items="${noShowList}">
		
				<tr>
					<td><!-- 예약일자 -->
					<fmt:formatDate value="${noShow.reserve_date}" var="reserve_date" type="both" pattern="yy-MM-dd HH:mm"/>
						${reserve_date}
					</td>
					<td><!-- 고객ID -->
					${noShow.userid}	
						
					</td>
					<td><!-- 고객수 -->
					${noShow.guestCount}
					
					</td>
					<td><!-- 승인창 -->
					<label class="radio-inline">
      <input type="radio" name="optradio">Option 1
    				</label>
   				 <label class="radio-inline">
      <input type="radio" name="optradio">Option 2
    				</label>
    
					
					</td>
					
				</tr>
		
		</c:forEach>
		</tbody>
	</table>
	<input type="button" value="저장">
	</section>
    