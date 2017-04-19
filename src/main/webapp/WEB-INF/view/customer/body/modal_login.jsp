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

	<!-- 모달 ID/PW찾기 시작 -->
<div class="modal fade" id="Find" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">찾으시는 것을 선택해 주세요</h4>
			</div>
			<div class="modal-body">
				<form accept-charset="UTF-8" role="form" method="post" action="">
					<div class="form-group">
						<input type="button" class="btn btn-lg btn-primary btn-block"
							data-toggle="modal" data-target="#FindID" value="ID찾기">
					</div>
					<div class="form-group">
						<input type="button" class="btn btn-lg btn-primary btn-block"
							data-toggle="modal" data-target="#FindPW" value="비밀번호 찾기" />
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
</div>
<!-- 모달 ID/PW찾기 끝 -->

	<!-- 모달 ID찾기 시작 -->
<div class="modal fade" id="FindID" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">ID찾기</h4>
			</div>
			<div class="modal-body">
				<form accept-charset="UTF-8" role="form" method="post" action=""
					id="IDSearch">
					<div class="form-group">
						<input type="type" class="form-control" placeholder="이름을 입력해주세요."
							id="id" required autofocus>
					</div>
					<div class="form-group">
						<input type="type" class="form-control"
							placeholder="E-mail을 입력해주세요." id="email" required>
					</div>
					<div class="form-group">
						<input type="submit" class="btn btn-lg btn-primary btn-block"
							value="ID 찾기" /><br>
						<p class="" id="IDResult"></p>
					</div>
				</form>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 모달 ID찾기 끝 -->

	<!-- 모달 PW찾기 시작  -->
<div class="modal fade" id="FindPW" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">PW찾기</h4>
			</div>
			<div class="modal-body">
				<form accept-charset="UTF-8" role="form" method="post" action=""
					id="PWSearch">
					<div class="form-group">
						<input type="type" class="form-control" placeholder="이름을 입력해주세요."
							id="name" required autofocus>
					</div>
					<div class="form-group">
						<input type="type" class="form-control" placeholder="ID를 입력해주세요."
							id="id" required>
					</div>
					<div class="form-group">
						<input type="type" class="form-control"
							placeholder="E-mail을 입력해주세요." id="email" required>
					</div>
					<div class="form-group">
						<input type="submit" class="btn btn-lg btn-primary btn-block"
							value="PW 찾기" /><br>
						<p id="PWResult"></p>
					</div>
				</form>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 모달 PW찾기 끝 -->

	<!-- 모달 회원가입 시작 -->
<div class="modal fade" id="SignUp" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">회원가입</h4>
			</div>
			<div class="modal-body">
				<form accept-charset="UTF-8" role="form" method="post" action="" id="SignUp">
					<div class="form-group">
						<label for="userid">아 이 디</label><br>
						<input name="userid" value='' id="userid" placeholder="아이디를 입력해주세요." type="text" class="form-joinButton" required autofocus />
						<input type="button" class="btn btn-lg btn-primary btn-block-jointext" value="ID Check" data-toggle="modal" data-target="#IDCheck">
					</div>
					<div class="form-group">
						<label for="password">비밀번호</label><br>
						<input name="password" id="password1" value='' placeholder="비밀번호를 입력해주세요." type="password" class="form-joinButton" required />
					</div>
					<div class="form-group">
						<label for="password1">비밀번호 확인</label><br>
						<input name="password1" id="password2" value='' placeholder="비밀번호를 다시한번 입력해주세요" type="password" class="form-joinButton" required />
					</div>
					<div class="form-group">
						<label for="name">이&nbsp;&nbsp;름</label><br>
						<input name="name" value='' id="name" placeholder="이름을 입력해 주세요" type="text" class="form-joinButton" required />
					</div>
					<div class="form-group">
						<label for="mobile">전화번호</label><br>
						<input name="mobile" value='' id="mobile" placeholder="전화번호를 입력해 주세요 " type="text" class="form-joinButton" required />
					</div>
					<div class="form-group">
						<label for="E-mail">e-mail</label><br>
						<input name="E-mail" value='' id="E-mail" placeholder="이메일을 입력해 주세요" type="text" class="form-joinButton" required />
						<input type="button" class="btn btn-lg btn-primary btn-block-jointext" value="Send Code" data-toggle="modal" data-target="#Code">
					</div>
					<div class="form-group">
						<label for="code">인증번호</label><br>
						<input name="code" value='' id="code" placeholder="이메일로 받은 인증코드를 입력해 주세요" type="text" class="form-joinButton" required />
					</div>
					<div class="form-group">
						<input type="submit" class="btn btn-lg btn-primary btn-block" value="회원가입" />
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
<!--  모달 회원가입 끝 -->

	<!-- 모달 IDCheck 시작  -->
<div class="modal fade" id="IDCheck" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">ID Check</h4>
			</div>
			<div class="modal-body">
				<div style="align-content: center">
	<!--ID Check  성공시 출력 -->
					<p>사용할 수 있는 ID 입니다.</p>
	<!--ID Check  실패시 출력 -->
					<p>
						중복되는 ID 입니다. <br> 다시 입력해 주세요.
					</p>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
<!-- 모달 IDCheck 시작 -->

	<!-- 모달 인증코드 발송 시작  -->
<div class="modal fade" id="Code" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">인증코드</h4>
			</div>
			<div class="modal-body">
				<div style="align-content: center">
					<p>인증코드가 발송되었습니다.</p>
					<p>입력하신 E-mail을 확인해 주세요.</p>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
<!--  모달 인증코드 발송 끝 -->
