<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	var loginalert = localStorage.getItem("alertShown") === "true";

	var check = "${loginmsg}";
	console.log(check);

	if (!loginalert && check !== "") {
		alert("아이디 및 비밀번호가 유효하지 않습니다.");
		loginalert = true;
		localStorage.setItem("alertShown", "true"); // 알림창이 띄워진 상태를 로컬 스토리지에 저장
	}

	function validateForm() {
		alertShown = false;
		localStorage.removeItem("alertShown");
		var loginid = document.getElementById("loginid").value.trim();
		var loginpw = document.getElementById("loginpw").value.trim();
		console.log(loginid);
		console.log(loginpw);

		if (loginid === "" || loginpw === "") {
			alert("아이디와 비밀번호를 모두 입력해주세요.");
			return false;
		}
		return true;
	}

	//이름
	function nameMaxLength(e) {
		if (e.value.length > e.maxLength) {
			e.value = e.value.slice(0, e.maxLength);
		}
	}

	// 생년월일
	function birthMaxLength(e) {
		if (e.value.length > e.maxLength) {
			e.value = e.value.slice(0, e.maxLength);
		}
	}

	// 전화번호
	function telMaxLength(e) {
		if (e.value.length > e.maxLength) {
			e.value = e.value.slice(0, e.maxLength);
		}
	}
	
	/* */
	
	
	/* 비밀번호 찾기 */
	$(document).on(
			'click',
			'#findpw-btn',
			function(e) {
				console.log("click event");
				$("#findpwmodal").find(".findpw_m_body").html(`<h2>임시 비밀번호 발급</h2>
					<p>
						<strong>완료 버튼 클릭시 이메일로 전송됩니다.</strong>
					</p>
					<div class="signup-area" id="pw-name">
						<input type="text" id="pwname" name="userName" maxlength="4"
							autocomplete="off" oninput="nameMaxLength(this);" required>
						<label for="pwname">이름 :</label>
					</div>
					
					<div class="int-area">
						<input type="text" name="id" id="findpwid" autocomplete="off"
							required> <label for="loginid"> 아이디 : </label>
					</div>
					<div class="signup-area" id="pw-birth">
						<input type="text" id="pwbirth" name="userBirth" maxlength="10"
							oninput="birthMaxLength(this);" required /><label
							for="pwbirth">생년월일 8자리 ex) 19910119(숫자만 입력해주세요)</label>
					</div>

					<div class="signup-area" id="pw-tel">
						<input type="text" id="pwtel" required maxlength="12"
							name="userTel" oninput="telMaxLength(this);"> <label
							for="pwtel">전화번호 ex) 01022221111(숫자만 입력해주세요)</label>
					</div>`);
				$('#findpwmodal').addClass('show');

				// 전화번호 text 변경
				$("#pw-tel").click(
						function() {
							$("label[for='pwtel']").text("전화번호:");
							$("#pwtel").focusout(
									function() {
										if ($(this).val() == "") {
											$("label[for='pwtel']").text(
													"전화번호 ex) 01022221111 (숫자만 입력해주세요)");
										}
									});
						});

				// 생년월일 text 변경
				$("#pw-birth").click(
						function() {
							$("label[for='pwbirth']").text("생년월일:");
							$("#pwbirth").focusout(
									function() {
										if ($(this).val() == "") {
											$("label[for='pwbirth']").text(
													"생년월일 8자리 ex) 19910119 (숫자만 입력해주세요)");
										}
									});
						});

				// 생년월일

				const birthRegex = /^[0-9]*$/;

				$("#pwbirth").on(
						"input",
						function() {
							let birthvalue = $(this).val();
							birthvalue = birthvalue.trim();
							var checkbirth = (new RegExp(birthRegex))
									.test(birthvalue);
							var CheckBirth = !checkbirth;

							if (CheckBirth) {
								// 숫자가 아닌 문자가 입력된 경우, 숫자만 남기고 다른 문자는 제거
								$(this).val(birthvalue.replace(/[^0-9]/g, ""));
							} else if (birthvalue.length >= 8) {
								// 8자리 이상인 경우에만 하이픈을 추가하여 보정
								birthvalue = birthvalue.replace(
										/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');
								$(this).val(birthvalue);
							}
						});

				// 전화번호 한글 영어 방지
				const telRegex = /^[0-9]*$/;
				$("#pwtel").on(
						"input",
						function() {
							let telvalue = $(this).val();
							telvalue = telvalue.trim();
							var checktel = (new RegExp(telRegex))
									.test(telvalue);
							var CheckTel = !checktel;

							if (CheckTel) {
								$(this).val(telvalue.replace(/[^0-9]/g, ""));
							} else if (telvalue.length >= 11) {
								telvalue = telvalue
										.replace(/(\d{3})(\d{3,4})(\d{3,4})/,
												'$1-$2-$3');
								$(this).val(telvalue);
							}

						});

			});

	// 모달 닫기
	$(document).on('click', '#findpw_close_btn', function(e) {
		console.log("click event");
		$('#findpwmodal').removeClass('show');

	});
	
	
	
	
	
	
	
	
	
	
	// 아이디 찾기
	$(document).on(
			'click',
			'#findid-btn',
			function(e) {
				console.log("click event");
				$('#modal').addClass('show');

				// 전화번호 text 변경
				$("#user-tel").click(
						function() {
							$("label[for='usertel']").text("전화번호:");
							$("#usertel").focusout(
									function() {
										if ($(this).val() == "") {
											$("label[for='usertel']").text(
													"전화번호 ex) 01022221111(숫자만 입력해주세요)");
										}
									});
						});

				// 생년월일 text 변경
				$("#user-birth").click(
						function() {
							$("label[for='userbirth']").text("생년월일:");
							$("#userbirth").focusout(
									function() {
										if ($(this).val() == "") {
											$("label[for='userbirth']").text(
													"생년월일 8자리 ex) 19910119(숫자만 입력해주세요)");
										}
									});
						});

				// 생년월일

				const birthRegex = /^[0-9]*$/;

				$("#userbirth").on(
						"input",
						function() {
							let birthvalue = $(this).val();
							birthvalue = birthvalue.trim();
							var checkbirth = (new RegExp(birthRegex))
									.test(birthvalue);
							var CheckBirth = !checkbirth;

							if (CheckBirth) {
								// 숫자가 아닌 문자가 입력된 경우, 숫자만 남기고 다른 문자는 제거
								$(this).val(birthvalue.replace(/[^0-9]/g, ""));
							} else if (birthvalue.length >= 8) {
								// 8자리 이상인 경우에만 하이픈을 추가하여 보정
								birthvalue = birthvalue.replace(
										/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');
								$(this).val(birthvalue);
							}
						});

				// 전화번호 한글 영어 방지
				const telRegex = /^[0-9]*$/;
				$("#usertel").on(
						"input",
						function() {
							let telvalue = $(this).val();
							telvalue = telvalue.trim();
							var checktel = (new RegExp(telRegex))
									.test(telvalue);
							var CheckTel = !checktel;

							if (CheckTel) {
								$(this).val(telvalue.replace(/[^0-9]/g, ""));
							} else if (telvalue.length >= 11) {
								telvalue = telvalue
										.replace(/(\d{3})(\d{3,4})(\d{3,4})/,
												'$1-$2-$3');
								$(this).val(telvalue);
							}

						});

			});

	// 모달 닫기
	$(document).on('click', '#close_btn', function(e) {
		console.log("click event");
		$('#modal').removeClass('show');

	});
</script>
</head>


<body>
	<main class="main-container">
		<div class="container login-form">
			<h1>LOGIN</h1>
			<div>
				<form action="/member/login.do" method="post"
					onsubmit="return validateForm()">
					<div class="int-area">
						<input type="text" name="id" id="loginid" autocomplete="off"
							required> <label for="loginid"> UserName</label>
					</div>
					<div class="int-area">
						<input type="password" name="pw" id="loginpw" autocomplete="off"
							required> <label for="loginpw">PassWord</label>
					</div>
					<div class="btn-area">
						<button id="login-btn" type="submit">Login</button>
					</div>
				</form>
				<div class="caption">
					<div>
						<a href="/member/agreeMent.do">회원가입</a>
					</div>
					<div>
						<a id="findid-btn" href="#">아이디찾기</a>
					</div>
					<div>
						<a id="findpw-btn" href="#">비밀번호찾기</a>
					</div>
				</div>
			</div>
		</div>
		
<!--  find id -->
		<!-- 모달 -->
		<div class="modal" id="modal">
			<div class="modal_body">
				<div class="m_head">
					<div class="modal_title">아이디 찾기</div>
					<div class="close_btn" id="close_btn">X</div>
				</div>
				<div class="m_body">
					<div class="signup-area" id="user-name">
						<input type="text" id="username" name="userName" maxlength="4"
							autocomplete="off" oninput="nameMaxLength(this);" required>
						<label for="username">이름 :</label>
					</div>

					<div class="signup-area" id="user-birth">
						<input type="text" id="userbirth" name="userBirth" maxlength="10"
							oninput="birthMaxLength(this);" required /><label
							for="userbirth">생년월일 8자리 ex) 19910119(숫자만 입력해주세요)</label>
					</div>

					<div class="signup-area" id="user-tel">
						<input type="text" id="usertel" required maxlength="12"
							name="userTel" oninput="telMaxLength(this);"> <label
							for="usertel">전화번호 ex) 01022221111(숫자만 입력해주세요)</label>
					</div>
				</div>
				<div class="m_footer">
					<div class="modal_btn cancle" id="close_btn">취소</div>
					<div class="modal_btn save" id="save_btn">아이디찾기</div>
				</div>
			</div>
		</div>
		<!-- 모달 -->
<!-- find pw  -->
		<!-- 모달 -->
		<div class="modal" id="findpwmodal">
			<div class="modal_body">
				<div class="m_head">
					<div class="modal_title">비밀번호 찾기</div>
					<div class="close_btn" id="findpw_close_btn">X</div>
				</div>
				<div class="findpw_m_body">
					
				</div>
				<div class="m_footer">
					<div class="modal_btn cancle" id="findpw_close_btn">취소</div>
					<div class="modal_btn save" id="findpw_save_btn">완료</div>
				</div>
			</div>
		</div>
		<!-- 모달 -->
	</main>

	<script>
		// Ajax를 이용하여 서버에 비밀번호 요청 보내기

		$('#findpw_save_btn').click(function findId() {
			var id = document.getElementById("findpwid").value.trim();
			var name = document.getElementById("pwname").value.trim();
			var birth = document.getElementById("pwbirth").value.trim();
			var tel = document.getElementById("pwtel").value.trim();
			$.ajax({
				type : "POST",
				url : "/member/findPw.ck",
				data : {
					userName : name,
					userBirth : birth,
					userTel : tel,
					userId : id
				},
				success : function(response) {
					// 서버로부터 받은 데이터를 모달 내부에 보여주기
					$("#findpwmodal").find(".modal_body").html(response);
				},
				error : function() {
					alert("비밀번호 찾기에 실패했습니다.");
				}
			});
		})
		
		// ajax 를 이용하여 서버에 아이디 찾기 요청 보내기
		$('#save_btn').click(function findId() {
			var name = document.getElementById("username").value.trim();
			var birth = document.getElementById("userbirth").value.trim();
			var tel = document.getElementById("usertel").value.trim();
			$.ajax({
				type : "POST",
				url : "/member/findId.ck",
				data : {
					userName : name,
					userBirth : birth,
					userTel : tel
				},
				success : function(response) {
					// 서버로부터 받은 데이터를 모달 내부에 보여주기
					$("#modal").find(".modal_body").html(response);
				},
				error : function() {
					alert("아이디 찾기에 실패했습니다.");
				}
			});
		})
		
	</script>
</body>
</html>