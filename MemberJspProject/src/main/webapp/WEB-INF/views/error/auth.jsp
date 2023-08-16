<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오류 페이지</title>
<style type="text/css">
/* 오류 페이지 css 속성 */
.flex-container {
	display: flex;
}

.inline-flex-container{
	display: inline-flex;
}

.flex-item {
	margin: 15px;
}

.flex-container.flex-content {
	width: 1200px;
	height: 400px;
	padding: 20px;
	box-shadow: 5px 5px 10px;
}

.color {
	background: #dedede;
	color: black;
	border: 5px solid black;
	border-radius: 20px;
}

p{
	font-size: 14px;
}
</style>
</head>
<body>
	<div class="container" style="margin-top: 100px;">
	
		<div class="flex-container">
			<div class="flex-item">
				<h2>권한 페이지 오류</h2>
			</div>
		</div>

		<div class="flex-container flex-content color">
			<div class="flex-item">
				<img src="/resource/image/main/B.png" width="100px" height="100px" style="opacity: 0.3;">
			</div>
			<div class="flex-item" style="margin-left: 10px;">
				<p>이용에 불편을 드려 죄송합니다</p>
				<p>요청하신 페이지에 접근 권한이 없습니다</p>
				<p>오류 내용 : 권한이 요구되는 페이지 접근</p>
				<p>권한이 필요한 페이지입니다. 권한이 있는 계정으로 로그인해 주세요</p>
			</div>
		</div>

	</div>
</body>
</html>