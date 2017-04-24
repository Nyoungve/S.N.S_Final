<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	
		  		<table class="table">
					<thead>
						<tr>
					        <th>작성일자</th>
					        <th>평점</th>
					        <th>업체명</th>
					        <th>후기글</th>
					        <th>수정</th>
					        <th>삭제</th>
				      	</tr>
				    </thead>
				    <tbody>
				        <c:forEach var="reviewList" items="${reviewList}">
							<tr>
								<td>
									<fmt:formatDate value="${reviewList.write_date}" var="write_date" type="both" pattern="yyyy-MM-dd"/>
									${write_date}
								</td>
								<td>${reviewList.ranking}</td>
								<td>${reviewList.e_name}</td>
								<td>${reviewList.comments}</td>
								<td>
									<button name="btn_reviewModify" class="btn btn-info btn-sm" data-Num="${reviewList.reserveNumber}">
										Modify
									</button>
								</td>
								<td>
									<button name="btn_reviewDelete" class="btn btn-info btn-sm" data-Num="${reviewList.reserveNumber}">
										Delete
									</button>
								</td>
							</tr>
						</c:forEach>
				    </tbody>
			 	</table>
			 	<input type="button" id="btn_reviewMore" class="btn btn-info btn-sm" value="더 보기">
			 	