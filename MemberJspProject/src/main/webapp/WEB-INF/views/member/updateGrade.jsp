<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="m_head">
		<div></div>
		<div class="close_btn" id="findid_btn">X</div>
	</div>
	<div class="m_body">
		<h2>회원 등급 변경 결과</h2>
		<p>
			<strong><%=request.getAttribute("updateGrade")%></strong>
		</p>

	</div>
	<div class="m_footer">
		<div class="modal_btn cancle" id="close_btn">확인</div>
	</div>
	<script>
		// 확인 버튼 클릭 시 이전 페이지로 이동 및 모달 창 숨기기
		document.getElementById("findid_btn").addEventListener("click",
				function() {
					location.reload()
				});

		document.getElementById("close_btn").addEventListener("click",
				function() {
					location.reload()
				});
	</script>
</body>
</html>