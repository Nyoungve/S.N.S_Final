<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
  
	<h1 style="color: white;">예약 현황</h1>
	<section style="border-radius: 20px; -moz-border-radius: 20px; -webkit-border-radius: 20px;  padding: 20px 20px 20px 20px; background-color: white;">
	<table border="1" class="table">
		<tr>
			<td>예약일자</td>
			<td>예약번호</td>
			<td>고객ID</td>
			<td>고객수</td>
			<td>상태창</td>
			<td>예약승인</td>
			<td>예약취소</td>
		</tr>
		<c:forEach var="reserveList" items="${reserveList}">
		<fmt:formatDate value="${reserveList.reserve_date}" var="reserve_date" type="both" pattern="yyyy-MM-dd HH:mm:ss"/>
		
		<c:if test="${reserveList.r_state!=5}">
		
			
				<tr>
					<td>
						${reserve_date}
					</td>
					<td>
						${reserveList.reserveNumber}
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
						<c:if test="${reserveList.r_state==1}">
							<button name="btn_e_reserveOk" class="btn btn-info btn-sm" data-Num="${reserveList.reserveNumber}">
								예약승인
							</button>
						</c:if>
					</td>
					<td>
						<c:if test="${reserveList.r_state==3}">
							<button name="btn_e_reserveCancel" class="btn btn-info btn-sm" data-Num="${reserveList.reserveNumber}">
								예약취소
							</button>
						</c:if>
					</td>
				</tr>
			</c:if>

		</c:forEach>
	</table>
	</section>
	
	<script type="text/javascript">
	
	$(function(){
		
		$('[name="btn_e_reserveOk"]').on('click',function(){
			
			var reserveNumber = $(this).attr('data-Num')
			
			
			var url = "E_reserveOk.do"
			var query = "reserveNumber=" + reserveNumber
			
			$.ajax({
				
				type:"GET"
				,url:url
				,data:query
				,success:function(data){
					
					$('#divBox').empty();
					
					$('#divBox').html(data);
					
				}
				,error:function(e){
					console.log(e.responseText);
				}
				
			})
			
		})
		
		
		
		$('[name="btn_e_reserveCancel"]').on('click',function(){
			
			var reserveNumber = $(this).attr('data-Num')
			
			
			var url = "E_reserveCancel.do"
			var query = "reserveNumber=" + reserveNumber
			
			$.ajax({
				
				type:"GET"
				,url:url
				,data:query
				,success:function(data){
					
					$('#divBox').empty();
					
					$('#divBox').html(data);
					
				}
				,error:function(e){
					console.log(e.responseText);
				}
				
			})
			
		})
		
		
		
	})
	
	</script>

