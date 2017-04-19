<%@ page language="java" contentType="text/html; charset=UTF-8" %>
 
 <!-- Modal -->
	  <div class="modal fade" id="myModal" role="dialog">
	    <div class="modal-dialog">
	    
	      <!-- Modal content-->
	      <div class="modal-content">
	        <div class="modal-header">
	          <button type="button" class="close" data-dismiss="modal">&times;</button>
	          <h4>후기 작성</h4>
	        </div>
	        <div class="modal-body" style="padding:40px 50px;">
	          <form role="form" id="writeForm" method="post" enctype="multipart/form-data">
	            <div class="form-group">
	            	<input type="hidden" id="rntext" name="reserveNumber" value="">
	              	<h4>이미지</h4>
	              	<div id="review_view"></div>
	              	<br/>
	              	<input type="file" class="form-control" id="review_image" name="review_image" onclick="imageViewer('review_image','review_view')">
	              	<br/>
	              	<textarea class="form-control" rows="5" name="comments"></textarea>
	              	<br/>
	              	<c:forEach var="i" begin="1" end="5" step="1">
	              		<label class="radio-inline">
      						<input type="radio" value="${i}" name="ranking"><c:out value="${i}"/>
    					</label>
    				</c:forEach>
	            </div>
	            
	            <button type="button" class="btn btn-success btn-block" id="btn_reviewSubmit">작성 완료</button>
	          </form>
	        </div> 
	      </div>
	      
	    </div>
	  </div> 