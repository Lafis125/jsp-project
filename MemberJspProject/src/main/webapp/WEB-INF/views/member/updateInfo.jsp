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
		<div class="close_btn" id="close_btn">X</div>
	</div>
	<div class="m_body">
		<h2>내 정보 결과</h2>
		<p>
			<strong><%=request.getAttribute("updateinfo-msg")%></strong>
		</p>

	</div>
	<div class="m_footer">
		<div class="modal_btn cancle" id="update_btn">확인</div>
	</div>
	<script>
		document.getElementById("update_btn").addEventListener("click",
				function() {
					location.reload();
				});
		document.getElementById("close_btn").addEventListener("click",
				function() {
					location.reload();
				});
	</script>

</body>
</html>