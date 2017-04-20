<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

	<jsp:useBean id="toDay" class="java.util.Date"/>

<h1 style="color: white;">노쇼 리스트</h1>
<p style="color: white;">마감 전에 노쇼 회원 처리를 해주세요.</p>
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
      <input type="radio" name="radio${noShow.reserveNumber}" data-reserveNumber="${noShow.reserveNumber}" value="y">이용 완료
    				</label>
   				 <label class="radio-inline">
      <input type="radio" name="radio${noShow.reserveNumber}" data-reserveNumber="${noShow.reserveNumber}" value="n">노쇼 고객
    				</label>
    
					</td>
					
				</tr>
		
		</c:forEach>
		</tbody>
	</table>
	<input type="button" id="noShowBtn" value="저장">
	</section>

<script type="text/javascript">

//보낼 데이터를 저장할 맵 생성
var map = new Map();

function check(){
	
}


$(function(){
	
	$('input[type=radio]').on('click',function(){
		
		var reserveNumber =$(this).attr('data-reserveNumber')
		console.log(reserveNumber)
		var ynCheck = $(this).val();
		console.log(ynCheck)

		
		map.set(reserveNumber,ynCheck)
		
		console.log(map)
		
	})
	
	
	$('#noShowBtn').on('click',function(){
		
		var url="noShowSave.do"
		var json_data = JSON.stringify(map);
		
		
		 $.ajax({
			type : "post",
			url : url,
			data : json_data,
			dataType:"json",
			success : function(data) {

				// 기존 결과 값이 있으면 없애준다.
				//$('#divBox').html("");

				// 기존에 불러온 캘린더가 있으면 없애준다.
				//$("#calendar").datepicker("destroy");

				// 처리된 데이터를 뿌려준다.
				//$('#divBox').html(data);
				
				console.log(data)
				

			}

			,
			error : function(e) {
				console.log(e.responseText);
			}

			
			
			
			
			
		})
 		
	})
	

})

</script>
    