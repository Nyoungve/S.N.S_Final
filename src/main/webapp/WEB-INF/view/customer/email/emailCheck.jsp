<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title> 이메일 인증 V(^_^)V !!</title>
<script type="text/javascript">
function check(){
	
	var form = document.authenform;
	var authNum = ${authNum}; //인증번호 
	console.log(authNum+" 인증번호?");
	
	if(!form.authnum.value){
		alert('인증번호를 입력하세요.');
		return false;
	}
	
	if(form.authnum.value!=authNum){
		alert('틀린 인증번호입니다. 인증번호를 다시 입력해주세요');
		form.authnum.value=="";
		return false;
	}
	
	if(form.authnum.value==authNum){ //authenform안의 authnum의 값이 
		console.log(authNum+" 인증번호?");
		alert('메일인증완료!!');
		var formTag3 = window.opener.document.getElementById('mailCheck');
		//div 태그 때문에 반환값이 HTMLFormElement가 아니라 HTMLCollection으로 받아오기 때문에 이렇게 값을 가져와야한다.
		formTag3.value="메일인증완료!!";
		self.close();
		return false;
	}
}
</script>

</head>
<body>
<!-- 인증번호 입력 받는 폼... -->
<h5>☆인증번호 7자리를 입력하세요☆</h5>
	<div class="container">
		<form method="post" name="authenform" onsubmit="return check();">
			<input type="text" name="authnum"><br> 
			<input type="submit" value="Submit">
		</form>
	</div>
</body>
</html>