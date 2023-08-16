<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script>

//페이지 로드 시에 이전에 띄워진 알림창 상태를 확인하여 alertShown 변수 초기화
var alertShown = localStorage.getItem("alertShown") === "true";
var changealert = localStorage.getItem("changealert") === "true";

var changecheck = "${chagePw}"; 
var deletecheck = "${updateStatus}";

console.log(changecheck);
console.log(deletecheck);

if (!alertShown && deletecheck !== "") {
	alert(deletecheck);
	alertShown = true;
	localStorage.setItem("alertShown", "true"); // 알림창이 띄워진 상태를 로컬 스토리지에 저장
}
if(!changealert && changecheck !== ""){
	alert(changecheck);
	changealert = true;
	localStorage.setItem("changealert", "true");
}


const birthRegex = /^[0-9]*$/;
const telRegex = /^[0-9]*$/;


var userbirth = "${viewInfo.BG_MemberBirth }";
var useremail = "${viewInfo.BG_MemberEmail }";
var usertel = "${viewInfo.BG_MemberTel }";
var useradress = "${viewInfo.BG_MemberAddress }";

//전화번호
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

function handleClick(id) {
	var clickedId = id;
	console.log(clickedId);

	console.log("click event");
	$("#modal").addClass("show");

	if (clickedId == "birth-btn") {
		$(".m_body").html(`<div class="signup-area" id="user-birth">
							<input type="text" id="userbirth" name="userBirth" maxlength="10"
							oninput="birthMaxLength(this);" required /><label
							for="userbirth">변경 할 생년월일 8자리 ex) 19910119</label>
					</div>`);
		// 모달 풋터
		$(".m_footer")
			.html(`<button class="btn btn-sm btn-info confirm-change-btn change">변경</button>
			                <button class="btn btn-sm btn-secondary close-modal-btn" id="close_btn">취소</button>`);

		// 생년 월일
		$("#userbirth").on("input", function() {
			let birthvalue = $(this).val();
			birthvalue = birthvalue.trim();

			var checkbirth = (new RegExp(birthRegex)).test(birthvalue);
			var CheckBirth = !checkbirth;
			if (CheckBirth) {
				// 숫자가 아닌 문자가 입력된 경우, 숫자만 남기고 다른 문자는 제거
				$(this).val(birthvalue.replace(/[^0-9]/g, ""));
			} else if (birthvalue.length >= 8) {
				// 8자리 이상인 경우에만 하이픈을 추가하여 보정
				birthvalue = birthvalue.replace(/(\d{4})(\d{2})(\d{2})/, "$1-$2-$3");
				$(this).val(birthvalue);
			}
		});
		$("#userbirth").click(function() {
			$("label[for='userbirth']").text("생년월일:");
			$("#userbirth").focusout(function() {
				if ($(this).val() == "") {
					$("label[for='userbirth']").text(
						"변경 할 생년월일 8자리 ex) 19910119"
					);
				}
			});
		});
	}

	if (clickedId == "email-btn") {
		$(".m_body").html(`<div class="email-form">
						<div class="email-formsz">
						<input type="text" id="useremail" name="userEmail" maxlength="30"
							oninput="emailMaxLength(this);" required> <label
							for="useremail">Email:</label>
					</div>
					<div class="dec">&#64;</div>
					<input class="box" id="domain-txt" type="text" name="domain2" /> <select
						class="box" id="domain-list" name="domain">
						<option value="type">직접 입력</option>
						<option value="naver.com">naver.com</option>
						<option value="google.com">google.com</option>
						<option value="hanmail.net">hanmail.net</option>
						<option value="nate.com">nate.com</option>
						<option value="kakao.com">kakao.com</option>
					</select>
				</div>`);
		// 모달 풋터
		$(".m_footer")
			.html(`<button class="btn btn-sm btn-info confirm-change-btn change">변경</button>
		                <button class="btn btn-sm btn-secondary close-modal-btn" id="close_btn">취소</button>`);

		// 이메일
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
	}

	if (clickedId == "tel-btn") {
		$(".m_body").html(`<div class="signup-area">
						<input type="text" id="usertel" required maxlength="13"
						name="userTel" oninput="telMaxLength(this);"> <label
						for="usertel">전화번호 ex) 01022221111</label>
				</div>`);
		// 모달 풋터
		$(".m_footer")
			.html(`<button class="btn btn-sm btn-info confirm-change-btn change">변경</button>
		                <button class="btn btn-sm btn-secondary close-modal-btn" id="close_btn">취소</button>`);

		//전화번호

		$("#usertel").on("input", function() {
			let telvalue = $(this).val();
			telvalue = telvalue.trim();
			var checktel = (new RegExp(telRegex)).test(telvalue);
			var CheckTel = !checktel;

			if (CheckTel) {
				// 숫자가 아닌 문자가 입력된 경우, 숫자만 남기고 다른 문자는 제거
				$(this).val(telvalue.replace(/[^0-9]/g, ""));
			} else if (telvalue.length >= 11) {
				// 8자리 이상인 경우에만 하이픈을 추가하여 보정
				telvalue = telvalue.replace(/(\d{3})(\d{4})(\d{4})/, "$1-$2-$3");
				$(this).val(telvalue);
			}
		});

		$("#usertel").click(function() {
			$("label[for='usertel']").text("전화번호:");
			$("#usertel").focusout(function() {
				if ($(this).val() == "") {
					$("label[for='usertel']").text("전화번호 ex) 01022221111");
				}
			});
		});
	}

	if (clickedId == "address-btn") {
		$(".m_body").html(`<div class="address-area">
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
				</div>`);
		// 모달 풋터
		$(".m_footer")
			.html(`<button class="btn btn-sm btn-info confirm-change-btn change">변경</button>
		                <button class="btn btn-sm btn-secondary close-modal-btn" id="close_btn">취소</button>`);

	}

	$(document).on("click", ".change", function() {

		// 생년월일
		if (clickedId == "birth-btn") {
			userbirth = $("#userbirth").val().trim();
			if (userbirth == "") {
				return false;
			}
			const birthValue = userbirth;

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
			const birthDate = new Date(birthValue);
			const currentDate = new Date();
			if (birthDate >= currentDate) {
				alert("생년월일을 정확하게 입력해주세요");
				return false;
			}

		}

		// 이메일 
		if (clickedId == "email-btn") {
			
			var email = $("#useremail").val().trim();
			var domain = $("#domain-txt").val().trim();
			var domain2 = $("#domain-list").val().trim();
			
			console.log("testemail : "+useremail);
			console.log("select domain : " + domain);
			console.log("input domain : " + domain2);
			console.log("user Email : " + email);
			
			// 직접 입력 방식
			if (domain === "" || domain == "type") {
				console.log("input 의 domain2 >>> null or type domain : "+domain);
				useremail = email + "@" + domain2;
				console.log("직접 입력시 : " + useremail);
			} 
			// 선택 엽력 방식
			else {
				console.log("select 의 domain >>> not null or not type : "+domain2);
				useremail = email + "@" + domain
				console.log("주소 선택시 : " + useremail);
			}
			console.log("선택 결과 값 : " + useremail);
			
			const emailRegex = /^[a-z0-9]+@[a-z]+\.[a-z]{2,3}$/;
			var emailCK = (new RegExp(emailRegex)).test(useremail);
			var nonemail = !emailCK;
			if (email === "" || nonemail) {
				alert("이메일을 정확하게 입력해주세요");
				return false;
			}
		}
		
		
		


		if (clickedId == "tel-btn") {
			usertel = $("#usertel").val().trim();
			console.log("usertel : "+usertel);
			const telCheckRegex = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
			var telCK = (new RegExp(telCheckRegex)).test(usertel);
			console.log("telCK : "+telCK);
			var nontel = !telCK;
			console.log("nontel : "+nontel);
			if (usertel == "" || nontel) {
				alert("전화 번호를 정확하게 입력해주세요");
				return false;
			}
		}
		if (clickedId == "address-btn") {
			var add1 = $("#sign-postcode").val().trim();
			var add2 = $("#sign-roadAddress").val().trim();
			var add3 = $("#sign-jibunAddress").val().trim();
			var add4 = $("#sign-extraAddress").val().trim();
			var add5 = $("#sign_detailAddress").val().trim();
			useradress = add1+" "+add2+" "+add3+" "+add4+" "+add5;
			if (add1 == "" || add2 == "" || add3 == "" || add4 == "" || add5 == "") {
				alert("주소를 정확하게 입력해주세요");
				return false;
			}
		}

		console.log("click event");
		$("#pwmodal").addClass("show");
		$(".pw_m_body").html(`<div class="int-area">
								<input type="password" name="pw" id="userpw" autocomplete="off"
								required> <label for="loginpw">PassWord</label>
						</div>`);
		$(document).on("click", "#pw_save_btn", function() {
			
			$("#pwmodal").removeClass("show");

			var userpw = $("#userpw").val().trim();

			$.ajax({
				type: "POST",
				url: "/member/updateInfo.ck",
				data: {
					userPw: userpw,
					userBirth: userbirth,
					userEmail: useremail,
					userTel: usertel,
					userAdd: useradress
				},
				success: function(response) {
					$("#modal").find(".modal_body").html(response);
				},
				error: function() {
					alert("변경이 실패했습니다.");
				}
			});
		});
	});
}


$(document).on("click", "#delete-btn", function() {
	console.log("delete open event");
	$("#deletepwmodal").addClass("show");
	$(".deletepw_m_body").html(`<form action="/member/updateStatus.do" method="post" id="deleteForm"><div class="int-area">
				<input type="password" name="deletepw" id="deleteuserpw" autocomplete="off"
				required> <label for="deleteuserpw">PassWord</label>
		</div></form>`);
	$(document).on("click", "#deletepw_save_btn", function() {
		alertShown = false;
		localStorage.removeItem("alertShown");
		console.log("update save close event");
		$("#deletepwmodal").removeClass("show");

		$("#deleteForm").submit();
	});
});


$(document).on("click", "#change-btn", function () {
	  console.log("change pw open event");
	  $("#chacgepwmodal").addClass("show");
	  $(
	    ".changepw_m_body"
	  ).html(`<form action="/member/updatePw.do" method="post" id="changePwForm"><div class="pwchange-area">
	  <h3> 비밀번호 변경시 다시 로그인 해주셔야 합니다. </h3>
	   <div class="pwchange-area">
					<input type="password" name="currentpw" id="currentpw" autocomplete="off"
					required> <label for="currentpw">현재 비밀번호 :</label>
			</div>
	    <div class="pwchange-area">
					<input type="password" name="changepw" id="changeuserpw" autocomplete="off"
					required> <label for="changeuserpw">새로운 비밀번호 : </label>
	        <div class="alert alert-warning" id="checkPwDiv">비밀번호는 8~20자 사이로, 최소 6자 이상의 영문(소문자 또는 대문자)과 최소 2자 이상의 숫자를 포함해야 합니다.</div>
			</div>
	    <div class="pwchange-area">
					<input type="password" name="changecheckpw" id="changecheckuserpw" autocomplete="off"
					required> <label for="changecheckuserpw">비밀번호 재확인 :</label>
			</div>
	    </form>`);
	  $(document).on("click", "#changepw_save_btn", function () {
		var currentPw = $("#currentpw").val().trim();
	    var newPW = $("#changeuserpw").val().trim();
	    var newCheckPW = $("#changecheckuserpw").val().trim();
	    if (newPW != newCheckPW) {
	      alert("새로운 비밀번호 와 비밀번호 재확인이 서로 일치하지 않습니다.");
	    } else {
	      const passwordRegex = /^(?=.*[a-z])(?=.*\d)[A-Za-z\d]{8,20}$/;
	      var PWCHECK = new RegExp(passwordRegex).test(newPW);
	      var NonPWCHECK = !PWCHECK;
		      if (NonPWCHECK || newPW == "" || currentPw == "") {
		        alert("비밀번호 규정 맞지 않습니다.");
		        return false;
		      }else if(newPW == currentPw){
		    	  alert("현재 비밀번호와 일치합니다.")
		      }else {
		        changealert = false;
		        localStorage.removeItem("changealert");
		        console.log("update pw save close event");
		        $("#chacgepwmodal").removeClass("show");
		        $("#changePwForm").submit();
	      }
	    }
	  });
	});




/* 비밀번호 변경 모달  */
$(document).on("click", "#changepw_close_btn", function(e) {
	console.log("pwcheck close event");
	location.reload();
	$("#chacgepwmodal").removeClass("show");
});

/* 비밀번호 체크 모달  */
$(document).on("click", "#pw_close_btn", function(e) {
	console.log("pwcheck close event");
	location.reload();
	$("#pwmodal").removeClass("show");
});

/* 변경 모달 */
$(document).on("click", "#close_btn", function(e) {
	console.log("update close event");
	location.reload();
	$("#modal").removeClass("show");
});

/* 탈퇴 모달 */
$(document).on("click", "#deletepw_close_btn", function(e) {
	console.log("delete close event")
	location.reload();
	$("#deletepwmodal").removeClass("show");

});

</script>

</head>

<body>
	<main class="main-container">
		<div class="container myInfo">
			<div class="myprofile">
				<div class="info_title">
					<h3 class="title_text">기본정보</h3>
				</div>
				<ul class="myinfo_area">
					<li>
						<div class="myphoto">
							<img
								src="https://static.nid.naver.com/images/web/user/default.png"
								width="56" height="56" alt="내 프로필 이미지">
						</div>
					</li>
					<li>
						<div class="myaccount">
							<div class="myname">
								<div class="name_text">${viewInfo.BG_MemberName }</div>
							</div>
							<div class="myaddress">${viewInfo.BG_MemberId }</div>
						</div>
					</li>
				</ul>

				<div class="info">
					<ul>
						<li>
							<div class="info-line">
								<div>
									<i class="fa fa-venus-mars fa-1x" aria-hidden="true"> 성별 :
									</i>
								</div>
								<div class="info-views">
									<span>${viewInfo.BG_MemberGender }</span>
								</div>
							</div>
						</li>


						<li>
							<div class="info-line">
								<div>
									<i class="fa fa-calendar-o fa-1x" aria-hidden="true"> 생성일 :
									</i>
								</div>
								<div class="info-views">
									<span>${viewInfo.BG_MemberRegDate }</span>
								</div>
							</div>
						</li>
						<li>
							<div class="info-line">
								<div>
									<i class="fa fa-calendar fa-1x" aria-hidden="true"> 최근접속일 :
									</i>
								</div>
								<div class="info-views">
									<span>${viewInfo.BG_MemberConDate }</span>
								</div>
							</div>
						</li>
						<li>
							<div class="info-line">
								<div>
									<i class="fa fa-birthday-cake fa-1x" aria-hidden="true">
										생년월일 : </i>
								</div>
								<div class="info-views">
									<span>${viewInfo.BG_MemberBirth }</span>
								</div>
								<button type="button" class="btn btn-danger" id="birth-btn"
									onclick="handleClick(this.id)">
									<span class="text">생년월일 변경</span>
								</button>
							</div>
						</li>
						<li>
							<div class="info-line">
								<div>
									<i class="fa fa-envelope-o fa-1x" aria-hidden="true"> 이메일 :
									</i>
								</div>
								<div class="info-views">
									<span>${viewInfo.BG_MemberEmail }</span>
								</div>
								<button type="button" class="btn btn-warning" id="email-btn"
									onclick="handleClick(this.id)">
									<span class="text">이메일 변경</span>
								</button>
							</div>
						</li>
						<li>
							<div class="info-line">
								<div>
									<i class="fa fa-phone fa-1x" aria-hidden="true"> 전화번호 : </i>
								</div>
								<div class="info-views">
									<span>${viewInfo.BG_MemberTel }</span>
								</div>
								<button type="button" class="btn btn-success" id="tel-btn"
									onclick="handleClick(this.id)">
									<span class="text">전화번호 변경</span>
								</button>
							</div>
						</li>
						<li style="height: 70px;">
							<div class="info-line">
								<div style="width: 20%;">
									<i class="fa fa-map-marker fa-1x" aria-hidden="true"> 주소 :
									</i>
								</div>
								<div class="info-views"
									style="margin-left: 20px; font-size: 20px; margin-right: 50px;">
									<span>${viewInfo.BG_MemberAddress }</span>
								</div>
								<button type="button" class="btn btn-info" id="address-btn"
									onclick="handleClick(this.id)" style="width: 180px;">
									<span class="text">주소 변경</span>
								</button>
							</div>
						</li>
						<li style="border: none;">
							<div>
								<button type="button" id="delete-btn" class="btn btn-primary">탈퇴</button>
								<button type="button" id="change-btn" class="btn btn-danger"
									style="margin-right: 10px;">비밀번호변경</button>
							</div>
						</li>
					</ul>
				</div>
			</div>
		</div>

		<!-- 변경 모달 -->
		<div class="viewmodal" id="modal">
			<div class="modal_body">
				<div class="m_head">
					<div class="modal_title">내정보 변경</div>
					<div class="close_btn" id="close_btn">X</div>
				</div>
				<div class="m_body"></div>
				<div class="m_footer"></div>
			</div>
		</div>
		<!-- 비밀번호 확인 모달 -->
		<div class="pw_modal" id="pwmodal">
			<div class="pw_modal_body">
				<div class="pw_m_head">
					<div class="modal_title">비밀번호</div>
					<div class="close_btn" id="pw_close_btn">X</div>
				</div>
				<div class="pw_m_body"></div>
				<div class="pw_m_footer">
					<div class="modal_btn cancle" id="pw_close_btn">취소</div>
					<div class="modal_btn save" id="pw_save_btn">완료</div>
				</div>
			</div>
		</div>
		<!-- 탈퇴 모달  -->
		<div class="deletepw_modal" id="deletepwmodal">
			<div class="deletepw_modal_body">
				<div class="deletepw_m_head">
					<div class="modal_title">회원 탈퇴</div>
					<div class="close_btn" id="deletepw_close_btn">X</div>
				</div>
				<div class="deletepw_m_body"></div>
				<div class="deletepw_m_footer">
					<div class="modal_btn cancle" id="deletepw_close_btn">취소</div>
					<div class="modal_btn save" id="deletepw_save_btn">완료</div>
				</div>
			</div>
		</div>
		<!-- 비밀번호 변경 -->
		<div class="changepw_modal" id="chacgepwmodal">
			<div class="changepw_modal_body">
				<div class="changepw_m_head">
					<div class="modal_title">비밀번호 변경</div>
					<div class="close_btn" id="changepw_close_btn">X</div>
				</div>
				<div class="changepw_m_body"></div>
				<div class="changepw_m_footer">
					<div class="modal_btn cancle" id="changepw_close_btn">취소</div>
					<div class="modal_btn save" id="changepw_save_btn">변경</div>
				</div>
			</div>
		</div>
	</main>
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript"
		src="/resource/js/member/viewInfo.js?v=1"></script>

</body>
</html>