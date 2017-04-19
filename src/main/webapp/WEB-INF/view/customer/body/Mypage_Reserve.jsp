<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<script type="text/javascript">

	function imageViewer(id, viewer) {
		
		var upload = document.getElementById(id)
		var viewDiv = document.getElementById(viewer)
		
		upload.onchange = function(e) {
			e.preventDefault();
			
			var file = upload.files[0], reader = new FileReader();
			reader.onload = function(event) {
				var img = new Image();
				img.src = event.target.result;
				img.width = 300;
				viewDiv.innerHTML = '';
				viewDiv.appendChild(img);
			};
			reader.readAsDataURL(file);
	
			return false;
		};
		
	}
	
</script>

<jsp:useBean id="toDay" class="java.util.Date" />


<!-- 결과 테이블 -->

<table class="table">
	<thead>
		<tr>
			<th>예약번호</th>
			<th>예약일자</th>
			<th>업체명</th>
			<th>상태창</th>
			<th>예약취소</th>
			<th>후기</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="reserveList" items="${reserveList}">
		
			<tr>
				<td>
					${reserveList.reserveNumber}
				</td>
				<td>
					<fmt:formatDate value="${reserveList.reserve_date}" var="reserve_date" type="both" pattern="yyyy-MM-dd HH:mm" />
					${reserve_date}
				</td>
				<td>
					${reserveList.e_name}
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
					<c:if test="${reserveList.r_state==5}">
						이용완료
					</c:if>
				</td>
				<td>
					<fmt:parseDate value="${reserve_date}" var="reDay" pattern="yyyy-MM-dd HH:mm" />
					<c:if test="${reDay.time - toDay.time > 0}">
						<c:if test="${reserveList.r_state==1 or reserveList.r_state==2}">
							<form name="form_cancelReserve">
								<input type="hidden" value="${reserveList.reserveNumber}" name="reserveNumber">
								<input type="button" value="Cancel" name="btn_c_reserveCancel" class="btn btn-info btn-sm">
							</form>
						</c:if>
					</c:if>
				</td>
				<td>
					<fmt:parseDate value="${reserve_date}" var="reDay" pattern="yyyy-MM-dd HH:mm" />
					<c:if test="${reDay.time - toDay.time < 0}">
						<c:if test="${reDay.time - toDay.time > -3*(1000*60*60*24)}">
							<c:if test="${reserveList.r_state==5}">
								<c:if test="${reserveList.reviewCheck == 0}">
									<form name="form_writeReview">
										<input type="hidden" value="${reserveList.reserveNumber}" name="reserveNumber">
										<input type="button" value="Write" name="btn_write" class="btn btn-info btn-sm">
									</form>
								</c:if>
							</c:if>
						</c:if>
					</c:if>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<input type="button" id="btn_more" class="btn btn-info btn-sm" value="더 보기">



