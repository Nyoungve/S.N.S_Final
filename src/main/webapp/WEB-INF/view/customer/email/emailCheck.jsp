<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title> �̸��� ���� V(^_^)V !!</title>
<script type="text/javascript">
function check(){
	
	var form = document.authenform;
	var authNum = ${authNum}; //������ȣ 
	console.log(authNum+" ������ȣ?");
	
	if(!form.authnum.value){
		alert('������ȣ�� �Է��ϼ���.');
		return false;
	}
	
	if(form.authnum.value!=authNum){
		alert('Ʋ�� ������ȣ�Դϴ�. ������ȣ�� �ٽ� �Է����ּ���');
		form.authnum.value=="";
		return false;
	}
	
	if(form.authnum.value==authNum){ //authenform���� authnum�� ���� 
		console.log(authNum+" ������ȣ?");
		alert('���������Ϸ�!!');
		var formTag3 = window.opener.document.getElementById('mailCheck');
		//div �±� ������ ��ȯ���� HTMLFormElement�� �ƴ϶� HTMLCollection���� �޾ƿ��� ������ �̷��� ���� �����;��Ѵ�.
		formTag3.value="���������Ϸ�!!";
		self.close();
		return false;
	}
}
</script>

</head>
<body>
<!-- ������ȣ �Է� �޴� ��... -->
<h5>��������ȣ 7�ڸ��� �Է��ϼ����</h5>
	<div class="container">
		<form method="post" name="authenform" onsubmit="return check();">
			<input type="text" name="authnum"><br> 
			<input type="submit" value="Submit">
		</form>
	</div>
</body>
</html>