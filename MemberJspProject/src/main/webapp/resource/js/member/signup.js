
// input check
const birthRegex = /^[0-9]*$/;
const telRegex = /^[0-9]*$/;
const passwordRegex = /^(?=.*[a-z])(?=.*\d)[A-Za-z\d]{8,20}$/;
const jsIDregExp = /^[a-z]+[a-z0-9]{5,19}$/g;
const emailRegex = /^[a-z0-9]+@[a-z]+\.[a-z]{2,3}$/;
// check

const nameCheckRegex = /^[가-힣]{2,8}$/;
const passwordCheckRegex = /^(?=.*[a-z])(?=.*\d)[A-Za-z\d]{8,20}$/;
const telCheckRegex = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;


// daum api
function DaumPostcode() {
	new daum.Postcode({
		oncomplete: function(data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

			// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var roadAddr = data.roadAddress; // 도로명 주소 변수
			var extraRoadAddr = ""; // 참고 항목 변수

			// 법정동명이 있을 경우 추가한다. (법정리는 제외)
			// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
			if (data.bname !== "" && /[동|로|가]$/g.test(data.bname)) {
				extraRoadAddr += data.bname;
			}
			// 건물명이 있고, 공동주택일 경우 추가한다.
			if (data.buildingName !== "" && data.apartment === "Y") {
				extraRoadAddr +=
					extraRoadAddr !== "" ? ", " + data.buildingName : data.buildingName;
			}
			// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
			if (extraRoadAddr !== "") {
				extraRoadAddr = " (" + extraRoadAddr + ")";
			}

			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			document.getElementById("sign-postcode").value = data.zonecode;
			document.getElementById("sign-roadAddress").value = roadAddr;
			document.getElementById("sign-jibunAddress").value = data.jibunAddress;

			// 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
			if (roadAddr !== "") {
				document.getElementById("sign-extraAddress").value = extraRoadAddr;
			} else {
				document.getElementById("sign-extraAddress").value = "";
			}

			var guideTextBox = document.getElementById("guide");
			// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
			if (data.autoRoadAddress) {
				var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
				guideTextBox.innerHTML = "(예상 도로명 주소 : " + expRoadAddr + ")";
				guideTextBox.style.display = "block";
			} else if (data.autoJibunAddress) {
				var expJibunAddr = data.autoJibunAddress;
				guideTextBox.innerHTML = "(예상 지번 주소 : " + expJibunAddr + ")";
				guideTextBox.style.display = "block";
			} else {
				guideTextBox.innerHTML = "";
				guideTextBox.style.display = "none";
			}
		}
	}).open();
}


// 도메인 직접 입력 or domain option 선택
const domainListEl = document.querySelector("#domain-list");
const domainInputEl = document.querySelector("#domain-txt");

// select 옵션 변경 시
domainListEl.addEventListener("change", (event) => {
	// option에 있는 도메인 선택 시
	if (event.target.value !== "type") {
		// 선택한 도메인을 input에 입력하고 disabled
		domainInputEl.value = event.target.value;
		domainInputEl.disabled = true;
	} else {
		// 직접 입력 시
		// input 내용 초기화 & 입력 가능하도록 변경
		domainInputEl.value = "";
		domainInputEl.disabled = false;
	}
});





// 정규표현식 체크

$(function() {
	$("#userpassword").on("input", function() {
		let pw = $(this).val();
		pw = pw.trim();
		$(this).val(pw);
		$("#checkPwDiv").removeClass("alert-warning alert-success alert-danger");
		var PWCHECK = (new RegExp(passwordRegex)).test(pw);
		var NonPWCHECK = !PWCHECK; 	// true >> false , false >> true
		if (NonPWCHECK) {
			$("#checkPwDiv").text("비밀번호는 8~20자 사이로, 최소 6자 이상의 영문(소문자 또는 대문자)과 최소 2자 이상의 숫자를 포함해야 합니다.").addClass("alert-warning");
		} else {
			$("#checkPwDiv").text("사용 가능한 비밀번호 입니다.").addClass("alert-success");
		}
	});
});


$("#userbirth").on("input", function() {
	let birthvalue = $(this).val();
	birthvalue = birthvalue.trim();

	var BIRTHCHECK = (new RegExp(birthRegex)).test(birthvalue);
	var NonBIRTHCHECK = !BIRTHCHECK; 	// true >> false , false >> true

	if (NonBIRTHCHECK) {
		// 숫자가 아닌 문자가 입력된 경우, 숫자만 남기고 다른 문자는 제거
		$(this).val(birthvalue.replace(/[^0-9]/g, ""));
	} else if (birthvalue.length >= 8) {
		// 8자리 이상인 경우에만 하이픈을 추가하여 보정
		birthvalue = birthvalue.replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');
		$(this).val(birthvalue);
	}
});

$("#usertel").on("input", function() {
	let telvalue = $(this).val();
	telvalue = telvalue.trim();

	var TELCHECK = (new RegExp(telRegex)).test(telvalue);
	var NonTELCHECK = !TELCHECK; 	// true >> false , false >> true

	if (NonTELCHECK) {
		// 숫자가 아닌 문자가 입력된 경우, 숫자만 남기고 다른 문자는 제거
		$(this).val(telvalue.replace(/[^0-9]/g, ""));
	} else if (telvalue.length >= 11) {
		// 8자리 이상인 경우에만 하이픈을 추가하여 보정
		telvalue = telvalue.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
		$(this).val(telvalue);
	}
});



// 생년월일 text 변경
$("#userbirth").click(function() {
	$("label[for='userbirth']").text("생년월일:");
	$("#userbirth").focusout(function() {
		if ($(this).val() == "") {
			$("label[for='userbirth']").text("생년월일 8자리 ex) 19910119 (숫자만 입력해주세요)");
		}
	});
});



// 전화번호 text 변경
$("#usertel").click(function() {
	$("label[for='usertel']").text("전화번호:");
	$("#usertel").focusout(function() {
		if ($(this).val() == "") {
			$("label[for='usertel']").text("전화번호 ex) 01022221111 (숫자만 입력해주세요)");
		}
	});
});


// 최대 글자 방지
// 이름
function nameMaxLength(e) {
	if (e.value.length > e.maxLength) {
		e.value = e.value.slice(0, e.maxLength);
	}
}
// 아이디
function idMaxLength(e) {
	if (e.value.length > e.maxLength) {
		e.value = e.value.slice(0, e.maxLength);
	}
}
// 비밀번호
function pwMaxLength(e) {
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
// 생년월일
function birthMaxLength(e) {
	if (e.value.length > e.maxLength) {
		e.value = e.value.slice(0, e.maxLength);
	}
}
// 이메일
function emailMaxLength(e) {
	if (e.value.length > e.maxLength) {
		e.value = e.value.slice(0, e.maxLength);
	}
}

// 공백 확인 및 정규 표현식 확인
function signUpCheck() {

	var c = document.signup_form;

	// 성별
	var genderSelected = false;
	var genderRadios = c.querySelectorAll('input[name="userGender"]');
	for (var i = 0; i < genderRadios.length; i++) {
		if (genderRadios[i].checked) {
			genderSelected = true;
			break;
		}
	}

	// 성별
	if (!genderSelected) {
		alert("성별을 선택해주세요");
		return false;
	}

	// 생년월일
	if (c.userBirth.value === "") {
		alert("생년월일을 정확하게 입력해주세요");
		return false;
	}

	const birthValue = c.userBirth.value;

	const dateParts = birthValue.split("-");

	const year = parseInt(dateParts[0]);
	const month = parseInt(dateParts[1]);
	const day = parseInt(dateParts[2]);

	if (year < 1900 || year > 2099) {
		alert("생년월일을 정확하게 입력해주세요");
		return false; // Year out of range
	}

	if (month < 1 || month > 12) {
		alert("생년월일을 정확하게 입력해주세요");
		return false; // Month out of range
	}

	if (day < 1 || day > 31) {
		alert("생년월일을 정확하게 입력해주세요");
		return false; // Day out of range
	}

	// Check for months with less than 31 days
	if ((month === 4 || month === 6 || month === 9 || month === 11) && day > 30) {
		alert("생년월일을 정확하게 입력해주세요");
		return false;
	}

	// Check for February and leap years
	if (month === 2) {
		if ((year % 4 === 0 && year % 100 !== 0) || (year % 400 === 0)) {
			if (day > 29) {
				alert("생년월일을 정확하게 입력해주세요");
				return false; // Leap year, but day out of range
			}
		} else {
			if (day > 28) {
				alert("생년월일을 정확하게 입력해주세요");
				return false; // Non-leap year, but day out of range
			}
		}
	}
	const birthDate = new Date(c.userBirth.value);
	const currentDate = new Date();
	if (birthDate >= currentDate) {
		alert("생년월일을 정확하게 입력해주세요");
		return false;
	}


	var telCK = (new RegExp(telCheckRegex)).test(c.userTel.value);
	var nontel = !telCK;
	// 전화번호
	if (c.userTel.value === "" || nontel) {
		alert("전화번호를 정확하게 입력해주세요");
		return false;
	}




	var testemail = "";
	console.log("testemail : " + testemail);
	console.log("select domain : " + c.domain.value);
	console.log("input domain : " + c.domain2.value);
	console.log("user Email : " + c.userEmail.value);

	if (c.domain.value === "" || c.domain.value == "type") {
		console.log("input 의 domain2");
		testemail = c.userEmail.value + "@" + c.domain2.value;
		console.log("직접 입력시 : " + testemail);
	} else {
		console.log("select 의 domain2");
		testemail = c.userEmail.value + "@" + c.domain.value;
		console.log("주소 선택시 : " + testemail);
	}
	console.log("선택 결과 값 : " + testemail);

	var emailCK = (new RegExp(emailRegex)).test(testemail);
	var nonemail = !emailCK;

	// 이메일확인
	if (c.userEmail.value === "" || nonemail) {
		alert("이메일을 정확하게 입력해주세요");
		return false;
	}


	var nameCK = (new RegExp(nameCheckRegex)).test(c.userName.value);
	var nonname = !nameCK;

	// 이름확인
	if (c.userName.value === "" || nonname) {
		alert("이름을 정확하게 입력해주세요");
		return false;
	}


	var idCK = (new RegExp(jsIDregExp)).test(c.userId.value);
	var nonid = !idCK;
	// 아이디확인
	if (c.userId.value === "" || nonid) {
		alert("아이디를 정확하게 입력해주세요");
		return false;
	}


	var pwCK = (new RegExp(passwordCheckRegex)).test(c.userPw.value);
	var nonpw = !pwCK
	// 비밀번호 확인
	if (c.userPw.value === "" || nonpw) {
		alert("비밀번호를 정확하게 입력해주세요");
		return false;
	}

	// 지역선택 확인
	if (c.add1.value == "" || c.add2.value == "" || c.add3.value == "" || c.add4.value == "" || c.add5.value == "") {
		alert("주소를 정확하게 입력해주세요");
		return false;
	}

	if (c.domain.value === "") {
		c.domain.value = domainListEl.value;
	}




	// 모든 조건을 통과한 경우 true 반환
	return true;
}
