<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	
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
									
									<input type="button" id="btn_modify" class="btn btn-info btn-sm" value="Modify">
									
								</td>
								
								
								<td>
									<input type="button" id="btn_delete" class="btn btn-info btn-sm" value="Delete" OnClick="window.location='/test/Review_Delete.do?comments=${reviewList.comments}&&userid=${reviewList.userid}&&write_date=${write_date}'">
								</td>
							</tr>
						</c:forEach>
				    </tbody>
			 	</table>
			 	