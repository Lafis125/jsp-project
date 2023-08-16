<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<script>


const idregExp = /^[a-z]+[a-z0-9]{5,19}$/; // g 플래그 제거

$(function() {
    var debouncedTest = _.debounce(function(id) {
	    	console.log("debounce check");
            $("#checkIdDiv").removeClass("alert-warning alert-success alert-danger");
            
            var IDCHECK = (new RegExp(idregExp)).test(id);
			var NonIDCHECK= !IDCHECK; 	// true >> false , false >> true
            
            
            if (NonIDCHECK) {
                $("#checkIdDiv").text("아이디는 6~20자 사이로, 첫 글자는 영문 소문자로 시작하며, 이어지는 글자는 영문 소문자와 숫자만 사용 가능합니다.").addClass("alert-warning");
            } else{
	        	console.log("load check ID");
	            $("#checkIdDiv").load("/member/idCheck.ck?idcheck=" + id, function(result) {
	                if (result.indexOf("가능한") > 0) {
	                    $("#checkIdDiv").text("사용 가능한 아이디 입니다.").addClass("alert-success");
	                } else {
	                    $("#checkIdDiv").text("중복된 아이디 입니다.").addClass("alert-danger");
	                }
	        });
        }
         console.log("실행 종료");
    }, 1000);

    // 아이디 입력 필드에 이벤트 리스너 추가
    $("#userid").on("input", function() {
    	console.log("input function");
        var id = $(this).val().trim(); // 아이디 값 받아오기 및 공백 제거
        debouncedTest(id); // 아이디 중복 체크 함수 호출 (debounce 적용)
    });
});

</script>


</head>
<body>
	<main class="main-container">
		<div class="container signup-form">
			<h2>회원가입</h2>
			<div>
				<form name="signup_form" action="/member/signUp.do" method="post"
					onsubmit="return signUpCheck()">
					<div class="signup-area">
						<input type="text" id="username" name="userName" maxlength="6"
							autocomplete="off" oninput="nameMaxLength(this);" required>
						<label for="username">이름 :</label>
					</div>

					<div class="signup-area">
						<input type="text" id="userid" name="userId" required
							maxlength="20" autocomplete="off" oninput="idMaxLength(this);">
						<label for="userid">ID :</label>
						<div class="alert alert-warning" id="checkIdDiv">아이디는 6~20자 사이로, 첫 글자는 영문 소문자로 시작하며, 이어지는 글자는 영문 소문자와 숫자만 사용 가능합니다.</div>
					</div>

					<div class="signup-area">
						<input type="password" id="userpassword" name="userPw" required
							maxlength="20" autocomplete="off"> <label
							for="userpassword" oninput="pwMaxLength(this);">Password:</label>
						<div class="alert alert-warning" id="checkPwDiv">비밀번호는 8~20자 사이로, 최소 6자 이상의 영문(소문자 또는 대문자)과 최소 2자 이상의 숫자를 포함해야 합니다.</div>
					</div>

					<div class="signup-area">
						<input type="text" id="userbirth" name="userBirth" maxlength="10"
							oninput="birthMaxLength(this);" required /><label
							for="userbirth">생년월일 8자리 ex) 19910119 (숫자만 입력해주세요)</label>
					</div>

					<div class="gender-area">
						<div class="gender-text">
							<span>성별 :</span>
						</div>
						<div class="gender-field">
							<label for="male">남성</label> <input type="radio" id="male"
								name="userGender" value="남자"> <label for="female">여성</label>
							<input type="radio" id="female" name="userGender" value="여자">
						</div>
					</div>


					<div class="signup-area">
						<input type="text" id="usertel" required maxlength="13"
							name="userTel" oninput="telMaxLength(this);"> <label
							for="usertel">전화번호 ex) 01022221111 (숫자만 입력해주세요)</label>
					</div>


					<div class="email-form">
						<div class="email-formsz">
							<input type="text" id="useremail" name="userEmail" maxlength="30"
								oninput="emailMaxLength(this);" required> <label
								for="useremail">Email:</label>
						</div>
						<div class="dec">&#64;</div>
						<input class="box" id="domain-txt" name="domain2" type="text" /> <select
							class="box" id="domain-list" name="domain">
							<option value="type">직접 입력</option>
							<option value="naver.com">naver.com</option>
							<option value="google.com">google.com</option>
							<option value="hanmail.net">hanmail.net</option>
							<option value="nate.com">nate.com</option>
							<option value="kakao.com">kakao.com</option>
						</select>
					</div>



					<div class="address-area">
						<div class="address-form">
							<div class="address-input">
								<input name="add1" type="text" id="sign-postcode"
									placeholder="우편번호" autocomplete="off"> <input
									name="add2" type="text" id="sign-roadAddress"
									placeholder="도로명주소" autocomplete="off"> <input
									name="add3" type="text" id="sign-jibunAddress"
									placeholder="지번주소" autocomplete="off">
							</div>
							<div class="address-input">
								<span id="guide" style="color: #999; display: none"></span> <input
									name="add4" type="text" id="sign-extraAddress"
									placeholder="참고항목" autocomplete="off"> <input
									name="add5" type="text" id="sign_detailAddress"
									placeholder="상세주소" autocomplete="off">
								<div class="address-btn">
									<input type="button" onclick="DaumPostcode()" value="우편번호 찾기"
										autocomplete="off">
								</div>
							</div>
						</div>
					</div>

					<div class="signup-btn">
						<button id="signup-btn" type="submit">회원가입</button>
					</div>

				</form>
			</div>

		</div>
	</main>

	<!-- axios 중복체크 -->
	<script type="text/javascript"
		src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>

	<!-- jquery  -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

	<script type="text/javascript" src="/resource/js/member/signup.js?v=5"></script>
	<!-- daum api -->
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</body>
</html>