<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>S.N.S_Administrator</title>
 
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    
  <script type="text/javascript">
  
  //우편번호 찾아주는 메소드
  function findZipcode() {
		url = "findZipcode.do";
		window.open(url,"post","toolbar=no ,width=500 ,height=300 ,directories=no,status=yes,scrollbars=yes,menubar=no");
	}
	
	//이미지 업로드시 이미지를 볼 수 있게 해준다.
	function imageViewer(id, viewer) {
		
		var upload = document.getElementById(id)
		var viewDiv = document.getElementById(viewer)
		
		upload.onchange = function(e) {
			
			e.preventDefault();
			
			var file = upload.files[0], 
			reader = new FileReader();
			
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

  //버튼 이벤트들 등록
  $(function(){
	
	//레스토랑 등록을 눌렀을 때
	  $('#restaurantBtn').on('click',function(){
		  $('.menu').css("background-color", "");
		  $(this).css("background-color", "blue");
			
			
			//블랙리스트,업체관리 업체 검색창을 사라지게 한다.
			$("#div1").css("display","none");
			
			
			//후기 게시판 고객 검색창이 사라지게 한다.
			$('#div2').css("display","none");
			
			//검색되었던 테이블이 사라지게 한다.
			$('table').remove();
			
			//레스토랑 등록 폼이 나타나게 한다.
			$('#div3').css("display","");
				  
	  })

	  
	  
	  //업체관리 버튼이 눌렸을 때
	  $('#customerBtn').on('click',function(){
		$('.menu').css("background-color", "");
		$(this).css("background-color", "blue");
		
		//후기 게시판 고객 검색창이 사라지게 한다.
		$('#div2').css("display","none");
		
		//검색되었던 테이블이 사라지게 한다.
		$('table').remove();
		
		//레스토랑 등록 폼이 사라지게 한다.
		$('#div3').css("display","none");
		
		//업체 검색창이 나타나게 한다.
		$("#div1").css("display","");
		
		//업체 검색용 action 지정
		$('#formId').prop("action","owner.do");
		
	  })
	  
	  //블랙리스트 버튼이 눌렸을 때
	  $('#blacklistBtn').on('click',function(){
		$('.menu').css("background-color", "");
		$(this).css("background-color", "blue");
		
		//후기게시판 고객 검색창이 사라지게 한다.
		$('#div2').css("display","none");
		
		//검색되었던 테이블이 사라지게 한다.
		$('table').remove();
		
		//레스토랑 등록 폼이 사라지게 한다.
		$('#div3').css("display","none");
		
		//후기 검색창이 나타나게 한다.
		$("#div1").css("display","");
		
		//후기 검색용 action을 지정한다.
		$('#formId').prop("action","blackList.do");
		
		
	  })
	  
	  
	  
	  //후기 게시판 버튼이 눌렸을 때
	  $('#reviewBtn').on('click',function(){
		$('.menu').css("background-color", "");
		$(this).css("background-color", "blue");
		
		//블랙리스트,업체관리 업체 검색창을 사라지게 한다.
		$("#div1").css("display","none");
		
		//검색되었던 테이블이 사라지게 한다.
		$('table').remove();
		
		//레스토랑 등록 폼이 사라지게 한다.
		$('#div3').css("display","none");
		
		//후기 검색창이 나타나게 한다.
		$('#div2').css("display","");
		
	  })
	  
	  //고객관리에서 고객정보를 불러오면 모달창을 띄워줌
	  if(${customerDTO !=null}){
		  $('#myModal').modal({backdrop: "static"});
		  
	  }
	  
		  
	  if(${insertOk!=null}){
		  $('#insertOkModal').modal();
	  }
	  
	  $('#closeBtn').on('click',function(){
		  location.href="adminMain.do";
	  })  
  }) // document.ready 끝
  
 
  
  
  </script>
  
</head>
<body>

<!-- 기본 입력폼 시작 화면구성 2/2/8-->
<div class="container-fluid">
 
  <div class="col-md-2 btn-group-vertical">
  	<button type="button" id="restaurantBtn" class="btn btn-info menu">레스토랑 등록</button>
    <button type="button" id="customerBtn" class="btn btn-info menu">업주 관리</button>
    <button type="button" id="blacklistBtn" class="btn btn-info menu">블랙 리스트</button>
    <button type="button" id="reviewBtn" class="btn btn-info menu">후기 관리</button>
  </div>

<div class="col-md-2"></div>

<!-- 액션을 지정하지 않은 고객 관리, 블랙리스트용 form을 숨겨놓는다. 시작-->
<div id="div1" class="col-md-8" style= "display : none;">
<form class="form-inline" id="formId">
<input type="text" class="form-control" name="id" placeholder="고객 ID">
<button type="submit" class="btn">Search</button>
</form>
</div >
<!-- 액션을 지정하지 않은 고객 관리, 블랙리스트용 form을 숨겨놓는다. 끝-->


<!-- 후기 관리용 form 시작-->
<div id="div2" class="col-md-8" style= "display : none;">
<form class="form-inline" action="customerList.do">
<input type="text" class="form-control" name="id" placeholder="고객 ID">
<input type="text" class="form-control" name="company" placeholder="업체명">
<button type="submit" class="btn">Search</button>
</form>
</div >
<!-- 후기 관리용 form 끝-->


<!-- 레스토랑 등록용 form 시작 -->
<div id="div3" class="col-md-8" style= "display : none;">
	<form name="enterInfo" id="enterInfo" action="insertRestaurant.do" method="post" enctype="multipart/form-data" class="form-inline">
	<section style="border-radius: 20px; -moz-border-radius: 20px; -webkit-border-radius: 20px;  padding: 20px 20px 20px 20px; background-color: white;">
		<div class="content">
			<div class="control-group">
				<label for="" class="control-label">사업자 등록 번호</label>
				<div class="controls">
					<input type="text" name="restaurant_number"/>
				</div>
		</div>
		</div>
		<div class="content">
			<div class="control-group">
				<label for="" class="control-label">우편번호</label>
				<div class="controls">
					<input type="text" id="zipcode" name="zipcode" class="form-control" readonly="true"/>
					<input type="button" value="우편번호찾기" onClick="findZipcode()" class="btn btn-default"/>
				</div>
		</div>
		</div>
		<div class="content">
			<div class="control-group">
				<label for="" class="control-label">상세주소</label>
				<div class="controls">
					<input type="text" id="address" name="address" size="50" maxlength="50" class="form-control"/>
				</div>
		</div>
		</div>
		<div class="content">
			<div class="control-group">
				<label for="" class="control-label">수용가능 Team</label>
				<div class="controls">
					<select name="teamCount">
					<c:forEach var="i" begin="1" end="10" step="1">
					<option value="${i}">${i}팀</option>
					</c:forEach>
					</select>
					
				</div>
		</div>
		</div>
		<div class="content">
			<div class="control-group">
				<label for="" class="control-label">업체명</label>
				<div class="controls">
					<input type="text" name="e_name" class="form-control"/>
				</div>
		</div>
		</div>
		<div class="content">
			<div class="control-group">
				<label for="" class="control-label">업체 소개</label>
				<div class="controls" style=" height: 150px">
					<textarea name="r_info" class="form-control poll_write" style="resize:none; width:100%; height:100%;"></textarea>
				</div>
		</div>
		</div>
		<div class="content">
			<div class="control-group">
				<label for="" class="control-label">분류</label>
				<div class="controls">
					<input type="text" name="type" class="form-control"/>
				</div>
		</div>
		</div>
		<div class="content">
			<div class="control-group">
				<label for="" class="control-label">영업시간</label>
				<div class="controls">
					<input type="text" name="r_time" class="form-control"/>
				</div>
		</div>
		</div>
		<div class="content">
			<div class="control-group">
				<label for="" class="control-label">영업시간</label>
				<div class="controls">
					영업 시작 시간 :
					<select name="openingTime">
					<c:forEach var="i" begin="0" end="23" step="1">
					<option value="${i}">${i}</option>
					</c:forEach>
					</select>
					
					영업 마감 시간 :
					<select name="closingTime">
					<c:forEach var="i" begin="0" end="23" step="1">
					<option value="${i}">${i}</option>
					</c:forEach>
					</select>
				</div>
		</div>
		</div>
		<div class="content">
			<div class="control-group">
				<label for="" class="control-label">가맹점 식별코드</label>
				<div class="controls">
					<input type="text" name="pay_key" class="form-control"/>
				</div>
		</div>
		</div>
		<div class="content">
			<div class="control-group">
				<label for="" class="control-label">Main 이미지</label>
				<div class="controls">
					<input type="file" id="main_image" name="main_image" class="btn btn-default form-control-file" onclick="imageViewer('main_image','main_image_view')">
				</div>
				<div id="main_image_view"></div>
				
				
		</div>
		</div>
		<div class="content">
			<div class="control-group">
				<label for="" class="control-label">Detail 이미지</label>
				<div class="controls">
					<input type="file"  id="detail_image" name="detail_image"  class="btn btn-default form-control-file" onclick="imageViewer('detail_image','detail_image_view')">
				</div>
				<div id="detail_image_view"></div>
				<!-- 원래 있던 이미지를 보여준다. -->
				
			
		</div>
		</div>
		<div class="content">
			<div class="control-group">
				<label for="" class="control-label">Menu 이미지</label>
				<div class="controls">
					<input type="file"  id="menu_image" name="menu_image" class="btn btn-default form-control-file" onclick="imageViewer('menu_image','menu_image_view')">
				</div>
				
				<div id="menu_image_view"></div>
				
				
				
			
				<input type="submit" value="등록" class="btn btn-primary btn-block">
			
			
		</div>
		</div>
		</section>
	</form>

</div>
<!-- 레스토랑 등록용 form 끝 -->








</div> <!-- container -->
<!-- 기본 입력폼 끝-->



<!-- 결과 표시창 시작-->

<!-- 블랙리스트 회원 보여주는 테이블 시작--><!-- 화면 구성 2/5/5 -->
<div class="container-fluid">
<div class="col-md-2"></div>
<div class="col-md-5">

      <c:forEach var="blckCustomer" items="${blackList}">
      <table class="table table-bordered">
    <thead>
      <tr>
        <th>고객 ID</th>
        <th>NoShow</th>
        <th>Email</th>
        <th>등급전환</th>
      </tr>
    </thead>
    <tbody>
       <tr>
        <td>${blckCustomer.userid}</td>
        <td>${blckCustomer.noShowCount}</td>
        <td>${blckCustomer.email}</td>
        <td>
        <form action="noShowCount.do">
   		<input type="hidden" name="id" value="${blckCustomer.userid}">
        
        <button type="submit" class="btn">OK</button>
        </form>
        </td> 
      </tr>
       </tbody>
  	</table>
  	
  	    
      </c:forEach>
      
</div>
<div class="col-md-5"></div>
</div>
<!-- 블랙리스트 회원 보여주는 테이블 끝 -->


<!-- 업주관리 보여주는 모달 시작-->
<div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <table class="table table-bordered">
          <thead>
     		 <tr>
        	<th>고객 ID</th>
        	<th>Email</th>
       	 	<th>고객 성명</th>
    	  </tr>
   		 </thead>
          <tbody>
       <tr>
        <td>${customerDTO.userid}</td>
        <td>${customerDTO.email}</td>
        <td>${customerDTO.name}</td>
      </tr>
       </tbody>
          </table>
          
          
        </div>
        <div class="modal-body">
          <p>해당 고객 ID를 업체 ID로 등록 하시겠습니까?</p>
        </div>
        <div class="modal-footer">
           <form action="insertOwner.do">
           <input type="hidden" name="userid" value="${customerDTO.userid}">
           <input type="hidden" name="password" value="${customerDTO.password}">
           <input type="hidden" name="mobile" value="${customerDTO.mobile}">
           <input type="hidden" name="email" value="${customerDTO.email}">
           <input type="hidden" name="name" value="${customerDTO.name}">
            <div class="form-group">
    		<label for="restaurant_number">사업자 등록번호:</label>
    		<input type="text" class="form-control" id="restaurant_number" name="restaurant_number" placeholder="사업자 등록번호를 입력해주세요.">
  			</div>
          <input type="submit" class="btn btn-default">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          </form>
          
        </div>
      </div>
      
    </div>
 </div>
 
<!-- 업주 관리 보여주는 모달 시작-->


<!-- 정상적인 사업주 등록 시 모달 시작 -->
<div id="insertOkModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-body">
        <p>등록이 정상처리되었습니다.</p>
      </div>
      <div class="modal-footer">
        <button type="button" id="closeBtn" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>
<!-- 정상적인 사업주 등록 시 모달 끝 -->


<!-- 결과 표시창 끝-->

	  

</body>
</html>