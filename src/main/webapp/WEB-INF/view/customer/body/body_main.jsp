<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	
	
<!-- 레스토랑 표시부분 시작 -->

    <section class="no-padding well">
       
      
        <div class="container-fluid" id="portfolio">
         
      ${restuarantDto.m_path}
           <div class="row no-gutter popup-gallery">
         
           <c:forEach var="restuarantDto" items="${restaurantDtos}">
           <!-- 레스토랑 정보 하나 시작-->
                <div class="col-md-4"  style="padding:10px;">
                    <div class="portfolio-box">
                    <div class="ih-item square effect13 left_to_right">
                    <a href="javascript:request('${restuarantDto.restaurant_number}')">
                        <div class="img"><img src="img/${restuarantDto.m_path}" class="img-responsive" alt="레스토랑 메인 이미지"></div>
                        <div class="info">
				          <h3>${restuarantDto.e_name}</h3>
       			          <p>${restuarantDto.type}</p>
				        </div>
				     </a>
				     
				     </div>
                        <div class="well">
                       <c:forEach begin="1" end="${restuarantDto.avgRanking}" step="1">
                       <span class="glyphicon glyphicon-star" style="font-size:40px;"></span>
                       </c:forEach>
                        
                       <c:forEach begin="1" end="${5- restuarantDto.avgRanking}" step="1">
                       <span class="glyphicon glyphicon-star-empty"  style="font-size:40px;"></span>
                       </c:forEach>
                        
                      
                        <font size="40px;">${restuarantDto.avgRanking}점</font>
                        </div> 
                    </div>
                </div>
                </c:forEach>
         <!-- 레스토랑 정보 하나 끝-->
         		              
                
                 </div>
            </div>
   
    </section>
    
  <!-- 레스토랑 표시부분 끝 -->  
   
   <!-- 더보기 표시부분 (조건 : 보여줄 레스토랑이 6개 이상인 경우)-->
    <div id="moreBtn" class="container-fluid">
     <div class="col-md-5"></div>
     <div id="more" class="btn btn-info btn-lg col-md-2">
          <span class="glyphicon glyphicon-chevron-down"></span> 더보기
     </div>
     <div class="col-md-5"></div>
     </div>
     
     <br/><br/><br/>  
  	
     <div class="container text-center">
         <div class="call-to-action">
             <a href="download/file" class="btn btn-info btn-xl sr-button"><h1>업체 신청 Click!!</h1></a>
         </div>
     </div>
     