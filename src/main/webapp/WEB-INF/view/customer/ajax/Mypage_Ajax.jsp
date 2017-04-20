<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<script type="text/javascript">	

$(function(){
	


		//예약현황
		$('#Mypage_ReserveBtn').on('click',function() {
		
			
			var url="Mypage_Reserve.do";
			var query="dup=userid";
			
			$.ajax({
				type:"GET"
				,url:url
				,data:query
				,success:function(arg){
					
					//제목을 바꾼다.
					$('#jemok').html("<h2>예약현황</h2>")
					
					//결과 테이블을 초기화한다.
					$('#resultTable').empty();
					
					//결과 테이블을 뿌려준다.
					$('#resultTable').html(arg);
					
					
					
				},error:function(e){
				  console.log(e.responseText);
				 }
				
			});
			
		});
		
		//정보수정
		$('#Mypage_UserInfoBtn').on('click',function() {
			
			var url="Mypage_UserInfo.do"
			var query="dup=userid";
			
			$.ajax({
				type:"GET"
				,url:url
				,data:query
				,success:function(arg){
					
					//제목을 바꾼다.
					$('#jemok').html("<h2>정보수정</h2>")
					
					//결과 테이블을 초기화한다.
					$('#resultTable').empty();
					
					//결과 테이블을 뿌려준다.
					$('#resultTable').html(arg);
					
					
					
				}
			 	,error:function(e){
				  console.log(e.responseText);
				 }
				
			});
			
		});
		
		//후기목록
		$('#Mypage_ReviewBtn').on('click',function() {
			
			var url="Mypage_Review.do"
			var query="dup=userid";
			
			$.ajax({
				
				type:"GET"
				,url:url
				,data:query
				,success:function(arg){
					
					//제목을 바꾼다.
					$('#jemok').html("<h2>후기목록</h2>")
					
					//결과 테이블을 초기화한다.
					$('#resultTable').empty();
					
					//결과 테이블을 뿌려준다.
					$('#resultTable').html(arg);
					
					
				}
			 	,error:function(e){
				  console.log(e.responseText);
				 }
				
			});
			
		});
		
		// 후기 목록 더보기
		var review_rno = 10 + Number(${review_rno})
			
		$(document).on('click','#btn_reviewMore',function(){
			review_rno += 10
			var url = "Mypage_Review.do"
			var query = "review_rno="+review_rno
					
			$.ajax({
					
				type:"GET"
				,url:url
				,data:query
				,success:function(data){
							
					$('#resultTable').empty();
					
					$('#resultTable').html(data);
							
				}
					
				,error:function(e){
						console.log(e.responseText);
				}
						
			});
					
		});
		
		
		
		
		// 예약 현황 더보기
		var reserve_rno = 10 + Number(${reserve_rno})
			
		$(document).on('click','#btn_reserveMore',function(){
			reserve_rno += 10
			var url = "Mypage_Reserve.do"
			var query = "reserve_rno="+reserve_rno
					
			$.ajax({
					
				type:"GET"
				,url:url
				,data:query
				,success:function(data){
							
					$('#resultTable').empty();
					
					$('#resultTable').html(data);
							
				}
					
				,error:function(e){
						console.log(e.responseText);
				}
						
			});
					
		});
		
		
		//예약 취소
		$(document).on('click','[name="btn_c_reserveCancel"]',function(){
				var reserveNumber = $(this).parents("form").find('[name="reserveNumber"]').val()
				console.log(reserveNumber)
				var url = "C_reserveCancel.do"
				var query = "reserveNumber="+reserveNumber+"&reserve_rno="+reserve_rno
				
				$.ajax({
					
					type:"GET"
					,url:url
					,data:query
					,success:function(data){
						
						$('#resultTable').empty();
						
						$('#resultTable').html(data);
						
					}
					,error:function(e){
						console.log(e.responseText);
					}
					
				});
				
			});
		
		
		
		
		//후기 글 쓰기 버튼
		$(document).on('click','[name="btn_write"]',function(){
			
			var reserveNumber = $(this).parents("form").find('[name="reserveNumber"]').val()
			$('#rntext').val(reserveNumber)
			$("#reviewModal").modal({backdrop: "static"});
			
			
		})
		
		
		
		//후기 작성 완료
		$(document).on('click','#btn_reviewSubmit',function(){
			
				
			var formData = new FormData()
			
			formData.append("reserveNumber", $('#rntext').val())
			formData.append("review_image", $("input[name=review_image]")[0].files[0])
			formData.append("comments", $("textarea[name=comments]").val());
			formData.append("ranking", $("input[name=ranking]:checked").val())
			formData.append("reserve_rno", reserve_rno)
			
		
			
			var url = "Review_Submit.do"
			
			$.ajax({
				
		
				type:"POST"
		       	,url:url
		       	,data:formData
		        ,processData: false
		        ,contentType: false
		        ,success:function(data){
		        	
		        	$('#reviewModal').modal("hide");
		        	$('#reviewModal').find('form')[0].reset();
		        	$('#review_view').html("");
		        	$('#resultTable').empty();
		        	$('#resultTable').html(data);
		
				}
				,error:function(e){
					console.log(e.responseText)
				}	
			})
			
		})
		
		
		//후기 글 쓰기 버튼
		$(document).on('click','[name="btn_write"]',function(){
			
			var reserveNumber = $(this).parents("form").find('[name="reserveNumber"]').val()
			$('#rntext').val(reserveNumber)
			$("#reviewModal").modal({backdrop: "static"});
			
			
		})
		
		//후기 수정 쓰기 버튼
		$(document).on('click','[name="btn_reviewModify"]',function(){
			
			var reserveNumber = $(this).attr('data-Num')
			
			var url = "Review_ModifyModal.do"
			var query = "reserveNumber=" + reserveNumber
			
			$.ajax({
				
				type:"GET"
				,url:url
				,data:query
				,success:function(data){
					
					$('#modifyModal').html(data)
					$("#reviewModal_modify").modal({backdrop: "static"});
					
					
				}
				,error:function(e){
					console.log(e.responseText)
				}
				
				
			})
			
			
		})
		
		
		//후기 글 삭제
		$(document).on('click','[name="btn_reviewDelete"]',function(){
			
			var reserveNumber = $(this).attr('data-Num')
			
			var url = "Review_Delete.do"
			var query = "reserveNumber=" + reserveNumber + "&review_rno=" + review_rno
			
			$.ajax({
				
				type:"GET"
				,url:url
				,data:query
				,success:function(data){
					
					$('#resultTable').empty();
					
					$('#resultTable').html(data);
					
				}
				,error:function(e){
					console.log(e.responseText);
				}
				
			});
			
			
		})
		
		//후기 글 수정 완료
		$(document).on('click','[name="btn_reviewModify_Submit"]',function(){
			
			var formData = new FormData()
			
			formData.append("reserveNumber", $("input[name=reserveNumber]").val())
			formData.append("review_image", $("input[name=review_image]")[0].files[0])
			formData.append("comments", $("textarea[name=comments]").val());
			formData.append("ranking", $("input[name=ranking]:checked").val())
			formData.append("review_rno", review_rno)
			
			
			var url = "Review_reviewModify.do"
			
				$.ajax({
					
					
					type:"POST"
			       	,url:url
			       	,data:formData
			        ,processData: false
			        ,contentType: false
			        ,success:function(data){
			        	
			        	$('#reviewModal_modify').modal("hide");
			
					}
					,error:function(e){
						console.log(e.responseText)
					}	
				})
			
		})



})


</script>	