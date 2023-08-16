<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
$(function(){
	
	// 검색 key 값을 세팅
	$("#key").val("${(empty param.key)?'i':param.key}");

	$("#perPageNum").val(${pageObject.perPageNum});
	
	$("#perPageNum").change(function(){
		// alert("perPageNum 값이 변경");
		let perPageNum = $("#perPageNum").val();
		// alert("perPageNum 값 : " + perPageNum);
		location = "/member/manageList.do?perPageNum=" + perPageNum + "&key=${param.key}&word=${param.word}"
	});
});

			


$(document).on('click', '.change-grade-btn', function(){
	alert("등급 변경할 회원을 클릭해주세요");
	var selectedMemberId = "";
    $(document).on('click', '#add-btn', function() {
        selectedMemberId = $(this).find(".id").text();
        console.log(selectedMemberId);
        $('#modal').addClass('show');
        $('.m_body').html(`<div class="signup-area" id="user-id">회원등급을 변경하시겠습니까? 아이디: `+selectedMemberId+`</div><div class="signup-area" id="user-gradeNo">
        		<input type="text" id="usergradeNo" name="usergradeNo" 
				autocomplete="off" required>
			<label for="usergradeNo">등급 번호 :</label>
        </div>`);
        
        $('.m_footer').html(`<button class="btn btn-sm btn-info confirm-change-btn changebtn">변경</button>
                <button class="btn btn-sm btn-secondary close-modal-btn" id="close_btn">취소</button>`);
        
        $(document).on('click', '.changebtn', function(){
        	var gradeNo = $(".signup-area").find("#usergradeNo").val();
        	console.log(gradeNo);
        	$.ajax({
    			type : "POST",
    			url : "/member/updateGrade.ck",
    			data : {
    				userId : selectedMemberId,
    				userGradeNo : gradeNo
    			},	success : function(response) {
    				$("#modal").find(".modal_body").html(response);
    			},error : function() {
					alert("변경이 실패했습니다.");
				}
        
        	});
        });
    });
});

$(document).on('click', '.delete-member-btn', function(){
	alert("삭제할 회원을 클릭해주세요");
	var selectedMemberId = "";
    $(document).on('click', '#add-btn', function() {
        selectedMemberId = $(this).find(".id").text();
        console.log(selectedMemberId);
        $('#modal').addClass('show');
        $('.m_body').html(`<div class="signup-area" id="user-id">회원을 정말로 삭제 하시겠습니까? 아이디: `+selectedMemberId+`</div>`);
        $('.m_footer').html(`<button class="btn btn-sm btn-info confirm-change-btn deletebtn">삭제</button>
                <button class="btn btn-sm btn-secondary close-modal-btn" id="close_btn">취소</button>`);
        
        $(document).on('click', '.deletebtn', function(){
        	$.ajax({
    			type : "POST",
    			url : "/member/manageDelete.ck",
    			data : {
    				userId : selectedMemberId,
    			},	success : function(response) {
    				$("#modal").find(".modal_body").html(response);
    			},error : function() {
					alert("변경이 실패했습니다.");
				}
        
        	});
        });
    });
});
	
	// 모달 닫기
    $(document).on('click', '#close_btn', function(e) {
    			console.log("click event");
    			$('#modal').removeClass('show');

    		});
</script>

</head>
<body style="">
	<main class="main-container">
		<div class="memberlist-container">
			<div class="container">
				<div>
					<h2>#회원관리</h2>
					<div style="margin-left: 0px; margin-bottom: 20px" class="row">
						<div id="searchDiv">
							<form action="/member/manageList.do" class="form-inline">
								<input name="page" value="1" type="hidden" />
								<div class="form-group">
									<select class="form-control" id="key" name="key">
										<option value="i">회원 아이디</option>
										<option value="r">등록일</option>
										<option value="c">최근접속일</option>
										<option value="s">상태</option>
										<option value="ircs">전체</option>
									</select>
								</div>
								<div class="input-group">
									<input type="text" class="form-control" placeholder="Search"
										name="word" value="${param.word }">
									<div class="input-group-btn">
										<button class="btn btn-default" type="submit">
											<i class="glyphicon glyphicon-search"></i>
										</button>
									</div>
								</div>
								<div class="input-group pull-right" style="margin-right: 20px;">
									<span class="input-group-addon">Rows/Page</span> <select
										class="form-control" id="perPageNum" name="perPageNum">
										<option>10</option>
										<option>15</option>
										<option>20</option>
										<option>25</option>
									</select>
								</div>
							</form>
						</div>
					</div>
				</div>
				<table class="table memberlist table-hover tablefont">
					<thead>
						<tr>
							<th scope="col">아이디</th>
							<th scope="col">이름</th>
							<th scope="col">성별</th>
							<th scope="col">생년월일</th>
							<th scope="col">전화번호</th>
							<th scope="col">상태</th>
							<th scope="col">등록일</th>
							<th scope="col">최근접속일</th>
							<th scope="col">회원등급</th>
							<th scope="col">회원등급이름</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty list}">
							<tr>
								<td colspan="5">데이터가 존재하지 않습니다.</td>
							</tr>
						</c:if>
						<c:if test="${!empty list }">
							<c:forEach items="${list }" var="vo">
								<tr id="add-btn">
									<th scope="row" class="id">${vo.BG_MemberId }</th>
									<td>${vo.BG_MemberName }</td>
									<td>${vo.BG_MemberGender }</td>
									<td>${vo.BG_MemberBirth }</td>
									<td>${vo.BG_MemberTel }</td>
									<td>${vo.BG_MemberStatus }</td>
									<td>${vo.BG_MemberRegDate }</td>
									<td>${vo.BG_MemberConDate }</td>
									<td>${vo.BG_GradeNo }</td>
									<td>${vo.BG_GradeName }</td>
								</tr>
							</c:forEach>
						</c:if>
					</tbody>
				</table>
				<div style="text-align: center;">
					<pageNav:pageNav listURI="/member/manageList.do"
						pageObject="${pageObject }" />
					<div style="text-align: right;">
						<button class="btn btn-sm btn-info change-grade-btn">등급
							변경</button>
						<button class="btn btn-sm btn-danger delete-member-btn">회원
							삭제</button>
					</div>
				</div>
			</div>
		</div>
	</main>
	<!-- 모달 -->
	<div class="modal" id="modal">
		<div class="modal_body">
			<div class="m_head">
				<div class="modal_title">회원관리</div>
				<div class="close_btn" id="close_btn">X</div>
			</div>
			<div class="m_body"></div>
			<div class="m_footer"></div>
		</div>
	</div>
	<!-- 모달 -->




</body>
</html>