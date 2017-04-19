<%@ page language="java" contentType="text/html; charset=UTF-8" %>


<section id="reviewSection" style="height: 100% ">
    	<div class="container">
		<div class="col-lg-2 col-sm-2"></div>
		<div id="jemok" class="col-lg-10 col-sm-10"><h2>마이페이지</h2></div>
		
		<div id="menuList" class="col-lg-2 col-sm-2">
			<div class="row"><br/></div>

		</div>
  		<div id="resultTable" class="col-lg-10 col-sm-10"></div>
		</div>
</section>
	
<script type="text/javascript">	



$(function(){
	


		//예약현황
		$('#Mypage_ReserveBtn').on('click',function() {
		
			
			var urlMain="Mypage_Main.do";
			var url="Mypage_Reserve.do";
			var query="dup=userid";
			
			$.ajax({
				type:"GET"
				,url:urlMain
				,data:query
				,success:function(arg){
					
					//ajax로 가져온 내용을 뿌리기 전 초기화
					$('#portfolio').empty();
					
					//더보기 버튼 삭제
					$('#moreBtn').remove();
					
					//셀렉션 태그 id= portfolio 인 곳에 data를 text 형식으로 집어 넣는다.
					$('#portfolio').html(arg);
					
				}
			 	,error:function(e){
				  console.log(e.responseText);
				 }
				
			});
			
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
		
		// 예약 현황 더보기
		var end_rno = 10 + Number(${end_rno})
			
		$('#btn_more').on('click',function(){
			end_rno += 10
			var url = "Mypage_Reserve.do"
			var query = "end_rno="+end_rno
					
			$.ajax({
					
				type:"GET"
				,url:url
				,data:query
				,success:function(data){
							
					$('#resultTable').empty();
					
					$('#resultTable').append(data);
							
				}
					
				,error:function(e){
						console.log(e.responseText);
				}
						
			});
					
		});
		
		//예약 취소
		$('[name="btn_c_reserveCancel"]').on('click',function(){
				var reserveNumber = $(this).parents("form").find('[name="reserveNumber"]').val()
				var url = "C_reserveCancel.do"
				var query = "reserveNumber="+reserveNumber+"&end_rno="+end_rno
				
				$.ajax({
					
					type:"GET"
					,url:url
					,data:query
					,success:function(data){
						
						$('#resultTable').empty();
						
						$('#resultTable').append(data);
						
					}
					,error:function(e){
						console.log(e.responseText);
					}
					
				});
				
			});
		
		
		
		//정보수정
		
		$('#Mypage_UserInfoBtn').on('click',function() {
		
			alert("정보수정클릭")
			
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
		
		
		//후기수정
		$('#Mypage_ReviewBtn').on('click',function() {
		
			alert("후기버튼클릭")
			
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
		
		//후기 글 쓰기 버튼
		$('[name="btn_write"]').on('click',function(){
			alert("글쓰기 버튼 클릭")
			var reserveNumber = $(this).parents("form").find('[name="reserveNumber"]').val()
			$('#rntext').val(reserveNumber)
			$("#myModal").modal({backdrop: "static"});
			
		})
		
		
		//후기 작성 완료
		$('#btn_reviewSubmit').on('click',function(){
			var formData = new FormData()
			
			formData.append("reserveNumber", $('#rntext').val())
			formData.append("review_image", $("input[name=review_image]")[0].files[0])
			formData.append("comments", $("textarea[name=comments]").val());
			formData.append("ranking", $("input[name=ranking]").val())
			formData.append("end_rno", end_rno)
			
			console.log(formData)
			
			var url = "Review_Submit.do"
			
			$.ajax({
				type:"POST"
		       	,url:url
		       	,data:formData
		        ,processData: false
		        ,contentType: false
		        ,success:function(){
		        	
		        	$("#myModal").modal("hide");
					
				}
				,error:function(e){
					console.log(e.responseText)
				}	
			})
			
		})


})
</script>	
	
	
	