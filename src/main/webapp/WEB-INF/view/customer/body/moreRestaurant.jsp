<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

 
 <c:forEach var="restuarantDto" items="${restaurantDtos}">
           <!-- 레스토랑 정보 하나 시작-->
                <div id="restaurant1" class="col-md-4"  style="padding:10px;">
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