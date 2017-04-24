<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 내가 만든 로그인 폼 content까지만 등록-->
<div id="Login" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">로그인</h4>
			</div>
			<div class="modal-body">
				<form action="login.do" id="LoginForm" name="LoginForm" method="post">
					<input type="hidden" name="parentId" value="10" />
					<div class="form-group">
						<label for="username">아이디</label>
						<!-- required: 해당 input에 값을 입력하지 않고 submit 버튼을 누르면 경고창(이 입력란을 작성하세요) 발생 및 자동 포커싱 -->
						<!-- autofocus: 모달창 실행 시 자동 포커싱 -->
							<input name="userid" value='' id="userid" placeholder="UserID" type="text" class="form-control" required autofocus />
						<b><p id="id_value" style="font-size: 12px; color: red;"></p></b>
					</div>
					<div class="form-group">
						<label for="password">비밀번호</label>
							<input name="password" id="password1" value='' placeholder="Password" type="password" class="form-control" required/>
						<b><p id="pw_value" style="font-size: 12px; color: red;"></p></b>
					</div>
					<div class="form-group">
						<input type="submit" id="btnLogin" class="btn btn-lg btn-primary btn-block" value="Login" />
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
<!-- 모달 로그인 끝 -->