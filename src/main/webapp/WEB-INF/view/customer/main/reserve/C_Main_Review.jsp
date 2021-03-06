<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 



<div id="reviewBox">
<c:forEach var="reviewDto" items="${reviewDtos}">
<!-- 레스토랑 후기 1개 시작 -->
<div class="row well">
<div class="col-lg-4">
<img alt="후기 이미지" class="img-responsive" src="img/${reviewDto.review_filePath}" width="220px" height="150px"/>

</div>
<div class="col-lg-6">
<c:forEach var="i" begin="1" end="${reviewDto.ranking}" step="1">
<span class="glyphicon glyphicon-star"  style="font-size:20px;"></span>
</c:forEach>
<c:forEach var="i" begin="1" end="${5 - reviewDto.ranking}" step="1">
<span class="glyphicon glyphicon-star-empty"  style="font-size:20px;"></span>
</c:forEach>
<br>
<blockquote>${reviewDto.comments}</blockquote>
</div>
<div class="col-lg-2">
<p>작성자 : ${reviewDto.userid}</p>
<fmt:formatDate value="${reviewDto.write_date}" var="write_date" type="both" pattern="yyyy-MM-dd"/>
<p>등록일 :${write_date}</p>
</div>
</div>
<!-- 레스토랑 후기 1개 끝 -->
</c:forEach>
</div>

<div id="pagingBlock">
<c:if test="${ totalReviewCount > 0}">

<c:if test="${startPage >wantPageBlock}">
   
     <a href='javascript:void(0);' onClick='getReviewList(${startPage - wantPageBlock}); return false'>[이전]</a>
</c:if>

<c:forEach var="i" begin="${startPage}" end="${endPage}">
   
    <a href='javascript:void(0);' onClick='getReviewList(${i}); return false'>
    
    <c:if test="${ i== reviewPageNum}">
    <b>[${i}]</b>
    </c:if>
    <c:if test="${ i != reviewPageNum}">
    [${i}]
    </c:if>
    
    </a>
</c:forEach>

<c:if test="${endPage < blockCount}">
   
     <a href='javascript:void(0);' onClick='getReviewList(${startPage + wantPageBlock}); return false'>[다음]</a>
     
</c:if>
</c:if>
</div>