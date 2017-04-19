<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>



<script type="text/javascript">


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

</script>


	<h1 style="color: white;">업체정보 페이지</h1>
	
	<form:form commandName="restaurantDto" name="enterInfo" id="enterInfo" action="E_insertInfo.do" method="post" enctype="multipart/form-data" class="form-inline">
	<section style="border-radius: 20px; -moz-border-radius: 20px; -webkit-border-radius: 20px;  padding: 20px 20px 20px 20px; background-color: white;">
		<div class="content">
			<div class="control-group">
				<label for="" class="control-label">사업자 등록 번호</label>
				<div class="controls">
					<form:input type="text" path="restaurant_number" readonly="true"/>
				</div>
		</div>
		</div>
		<div class="content">
			<div class="control-group">
				<label for="" class="control-label">우편번호</label>
				<div class="controls">
					<form:input type="text" path="zipcode" class="form-control" readonly="true"/>
					<input type="button" value="우편번호찾기" onClick="findZipcode()" class="btn btn-default"/>
				</div>
		</div>
		</div>
		<div class="content">
			<div class="control-group">
				<label for="" class="control-label">상세주소</label>
				<div class="controls">
					<form:input type="text" path="address" size="50" maxlength="50" class="form-control"/>
				</div>
		</div>
		</div>
		<div class="content">
			<div class="control-group">
				<label for="" class="control-label">수용가능 Team</label>
				<div class="controls">
					<form:input type="text" path="teamCount" class="form-control"/>
				</div>
		</div>
		</div>
		<div class="content">
			<div class="control-group">
				<label for="" class="control-label">업체명</label>
				<div class="controls">
					<form:input type="text" path="e_name" class="form-control"/>
				</div>
		</div>
		</div>
		<div class="content">
			<div class="control-group">
				<label for="" class="control-label">업체 소개</label>
				<div class="controls" style=" height: 150px">
					<form:textarea path="r_info" class="form-control poll_write" style="resize:none; width:100%; height:100%;"></form:textarea>
				</div>
		</div>
		</div>
		<div class="content">
			<div class="control-group">
				<label for="" class="control-label">분류</label>
				<div class="controls">
					<form:input type="text" path="type" class="form-control"/>
				</div>
		</div>
		</div>
		<div class="content">
			<div class="control-group">
				<label for="" class="control-label">영업시간</label>
				<div class="controls">
					<form:input type="text" path="r_time" class="form-control"/>
				</div>
		</div>
		</div>
		<div class="content">
			<div class="control-group">
				<label for="" class="control-label">영업시간</label>
				<div class="controls">
					<form:select path="openingTime" class="form-control">
					<form:options items="${timeBlock}"></form:options>
					</form:select>~
					<form:select path="closingTime" class="form-control">
					<form:options items="${timeBlock}"></form:options>	
					</form:select>
				</div>
		</div>
		</div>
		<div class="content">
			<div class="control-group">
				<label for="" class="control-label">가맹점 식별코드</label>
				<div class="controls">
					<form:input type="text" path="pay_key" class="form-control"/>
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
				
				<!-- 원래 있던 이미지를 보여준다. -->
				<img alt="" src="${restaurantuploadDTO.m_path}"/>
				${restaurantuploadDTO.m_path}
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
				<img alt="" src="${restaurantuploadDTO.d_path1}"/>
				${restaurantuploadDTO.d_path1}
		</div>
		</div>
		<div class="content">
			<div class="control-group">
				<label for="" class="control-label">Menu 이미지</label>
				<div class="controls">
					<input type="file"  id="menu_image" name="menu_image" class="btn btn-default form-control-file" onclick="imageViewer('menu_image','menu_image_view')">
				</div>
				
				<div id="menu_image_view"></div>
				<!-- 원래 있던 이미지를 보여준다. -->
				<img alt="" src="${restaurantuploadDTO.mn_path}"/>
				${restaurantuploadDTO.mn_path}
				
			<div class="content" style="margin-top: 20px; text-align: right;">
				<input type="submit" value="등록" class="btn btn-default">
			</div>
			
		</div>
		</div>
		</section>
	</form:form>	