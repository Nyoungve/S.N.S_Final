//더보기 버튼
	$('#more').on('click',function(){
		
		var url='more.do'
		var query='dum=1';
		
		$.ajax({
			 type:"GET"
			 ,url:url
			 ,data:query
			 ,success:function(data){
				
			  $('#portfolio').append(data); 
			  
			 }
			 ,error:function(e){
			  console.log(e.responseText);
			 }
		})
	})