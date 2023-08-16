/**
 * 
 */
function goToFirstNotAgreed() {
	var individualAgreeCheckboxes = document.querySelectorAll("input[type='checkbox']:not(#allAgree)");

	for (var i = 0; i < individualAgreeCheckboxes.length; i++) {
		if (!individualAgreeCheckboxes[i].checked) {
			individualAgreeCheckboxes[i].focus(); // 약관 동의를 하지 않은 첫 번째 체크박스로 포커스 이동
			break; // 첫 번째 약관 동의 항목을 찾았으므로 반복문 중단
		}
	}
}
function toggleAllAgree() {
	var allAgreeCheckbox = document.getElementById("Allagreement");
	var individualAgreeCheckboxes = document.querySelectorAll(
		"input[type='checkbox']:not(#Allagreement)"
	);

	for (var i = 0; i < individualAgreeCheckboxes.length; i++) {
		individualAgreeCheckboxes[i].checked = allAgreeCheckbox.checked;
	}
}

// 개별 동의 항목 체크박스들을 확인하여 "모두 동의" 체크박스의 상태를 변경하는 함수
function checkIndividualAgreements() {
	var allAgreeCheckbox = document.getElementById("Allagreement");
	var individualAgreeCheckboxes = document.querySelectorAll(
		"input[type='checkbox']:not(#Allagreement)"
	);

	for (var i = 0; i < individualAgreeCheckboxes.length; i++) {
		if (!individualAgreeCheckboxes[i].checked) {
			// 하나라도 개별 동의 항목 체크박스가 체크 해제되었을 때 "모두 동의" 체크박스도 체크 해제
			allAgreeCheckbox.checked = false;
			return; // 함수 종료
		}
	}

	// 모든 개별 동의 항목 체크박스가 선택되었을 때 "모두 동의" 체크박스도 체크
	allAgreeCheckbox.checked = true;
}

// "동의 여부 확인" 버튼을 클릭했을 때, 개별 동의 항목들의 체크 여부를 확인하는 함수
function checkAgreements() {
	var allAgreeCheckbox = document.getElementById("Allagreement");
	var agree1Checkbox = document.getElementById("Serviceagreement");
	var agree2Checkbox = document.getElementById("Privacyagreement");

	var isAllAgreed = allAgreeCheckbox.checked;
	var isAgree1 = agree1Checkbox.checked;
	var isAgree2 = agree2Checkbox.checked;

	console.log("모두 동의: " + isAllAgreed);
	console.log("개별 동의 항목 1: " + isAgree1);
	console.log("개별 동의 항목 2: " + isAgree2);
	if (isAllAgreed == true && isAgree1 == true && isAgree2 == true) {
		location.href = "/member/signUp.do";
	} else {
		alert("필수 항목에 동의해야 합니다!");
		goToFirstNotAgreed();
	}

	// 여기에서 개별 동의 항목들의 체크 여부에 따른 추가적인 로직을 수행할 수 있습니다.
	// 예를 들어, 모두 동의하지 않았을 때의 처리, 특정 항목 동의 여부에 따른 조건 처리 등을 할 수 있습니다.
}
