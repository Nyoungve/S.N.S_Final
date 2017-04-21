<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!-- 업주가 로그인 성공 시 관리할 레스토랑 리스트 보여주는 모달 시작 -->    	
<div class="modal fade" id="ownerRestaurantList" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
       <b>${userid}</b> 님 환영합니다.
        </div>
        <div class="modal-body">
         <p class="bg-primary">관리하실 사업장을 선택해주세요.</p>      
          <table class="table table-bordered">
    <thead>
      <tr>
        <th>사업장 등록번호</th>
        <th>레스토랑 이름</th>
        <th>레스토랑 주소</th>
      </tr>
    </thead>
    <tbody>
     <c:forEach var="restaurant" items="${restaurants}">
    		
    		<tr class="ownerMain">
    		<td class="resNum">${restaurant.restaurant_number}</td>
    		<td>${restaurant.e_name}</td>
    		<td>${restaurant.address}</td>
    		</tr>
    		
     </c:forEach>  
    
    </tbody>
  </table>
  	<!-- 로그인 성공 후 레스토랑을 선택하면 숨겨진 폼 태그를 sumbit한다 -->
  	<form id="formId" action="ownerMypageMain.do" method="POST">
  	<input type="hidden" id="restaurant_number" name="restaurant_number" value="">
  	</form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default closeBtn" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
<!-- 업주가 로그인 성공 시 관리할 레스토랑 리스트 보여주는 모달 끝-->