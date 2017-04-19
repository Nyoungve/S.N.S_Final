<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    

		<c:set var="userInfo" value="${userInfo}"/>
		
		<div class="col-lg-10 col-sm-10">
			<form class="form-horizontal">
				<div class="form-group">
					<div class="col-lg-2 col-sm-2">
			    		<label class="control-label col-sm-1" for="userid">ID</label>
			    	</div>
				    <div class="col-lg-8 col-sm-8">
				        <input type="hidden" class="form-control" id="userid" value="${userInfo.userid}"><h4>${userInfo.userid}</h4>
				    </div>
			    </div>
			    
			    <div class="form-group">
			    	<div class="col-lg-2 col-sm-2">
			      		<label class="control-label col-sm-1" for="password">Password</label>
			      	</div>
				    <div class="col-lg-8 col-sm-8">          
				        <input type="password" class="form-control" id="password" value="${userInfo.password}">
				    </div>
			    </div>
			    
			    <div class="form-group">
			    	<div class="col-lg-2 col-sm-2"></div>
				    <div class="col-lg-8 col-sm-8">          
				        <input type="password" class="form-control" id="password2" placeholder="">
				    </div>
			    </div>
			    
			    <div class="form-group">
			   		<div class="col-lg-2 col-sm-2">
			      		<label class="control-label col-sm-1" for="name">Name</label>
			      	</div>
			      	<div class="col-lg-8 col-sm-8">          
			    		<input type="text" class="form-control" id="name" value="${userInfo.name}">
			      	</div>
			    </div>
			    
			    <div class="form-group">
			   		<div class="col-lg-2 col-sm-2">
			      		<label class="control-label col-sm-1" for="mobile">Mobile</label>
			      	</div>
			      	<div class="col-lg-8 col-sm-8">          
			    		<input type="text" class="form-control" id="mobile" value="${userInfo.mobile}">
			      	</div>
			    </div>
			    
			    <div class="form-group">
			    	<div class="col-lg-2 col-sm-2">
			      		<label class="control-label col-sm-1" for="email">Email</label>
			      	</div>
			      	<div class="col-sm-8">          
			        	<input type="email" class="form-control" id="email" value="${userInfo.email}">
			      	</div>
			    </div>
			   
			    <div class="form-group">        
			      	<div class="col-sm-offset-2">
				      	<div class="col-lg-8 col-sm-8">
				        	<button type="submit" class="btn btn-default" id="submit">수정</button>
				        	<button type="button" class="btn btn-default">취소</button>
				        </div>
				        <div class="col-lg-2 col-sm-2">
				        	<button type="button" class="btn btn-default" id="leave">탈퇴</button>
				        </div>
			      	</div>
			    </div>
	  		</form>
		</div>
	