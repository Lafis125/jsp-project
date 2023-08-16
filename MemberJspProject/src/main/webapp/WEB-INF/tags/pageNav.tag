<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="pageObject" required="true"
 type="com.webjjang.util.PageObject" %>
<%@ attribute name="listURI" required="true"
 type="java.lang.String" %>
<%@ attribute name="query" required="false"
 type="java.lang.String" %> 

<% /** PageNation을 위한 사용자 JSP 태그  *
	 * 작성자 웹짱 이영환 강사 
	 * 작성일 2023.07.27
	 * 버전 5.0
	 
	 * query 데이터가 있는 경우 - 일반 게시판 페이지 정보로 사용한다. (int=1 --> int=0 으로 바꿔서 사용)
	 *   - 그러면 pageObject는 replyPageObject 정보가 들어온다.
	 *   - listURI="view.do"
	 *	 - query 정보에 Controller에서 replyPage 위치앞 까지만 저장해서 보내는 처리를 해야만합니다.
	 *	 - query 데이터가 들어오면 query는 페이지 정보, pageObject는 댓글 페이지 정보가 된다.
	 * 사용방법 :<pageObject:pageNav listURI="호출 List URL"
	 			pageObject= "웹짱 페이지 객체" query="일반 게시판 페이지 등 뒤에 붙이는 쿼리" />
   */ %>

<% request.setAttribute("noLinkColor", "#999"); %>
<% request.setAttribute("tooltip", " data-toggle=\"tooltip\" data-placement=\"top\" "); %>
<% request.setAttribute("noMove", " title=\"no move page!\" "); %>

<ul class="pagination">
  	<li data-page=1>
		<c:if test="${pageObject.page > 1 && empty query}">
			<!-- 맨 첫페이지로 이동 : query가 없는 경우 - 일반 게시판 페이지 처리 -->
	  		<a href="${listURI }?page=1&perPageNum=${pageObject.perPageNum}&key=${pageObject.key}&word=${pageObject.word}"
	  		  title="click to move first page!" ${tooltip } >
	  			<i class="glyphicon glyphicon-fast-backward"></i>
	  		</a>
  		</c:if>
		<c:if test="${pageObject.page > 1 && !empty query }">
			<!-- 맨 첫페이지로 이동 : query가 있는 경우 - 댓글 페이지(pageObject) 처리 포함, 일반게시판 페이지 정보(query)  -->
	  		<a href="${listURI }?${query }&replyPage=1&replyPerPageNum=${pageObject.perPageNum}"
	  		  title="click to move first page!" ${tooltip } >
	  			<i class="glyphicon glyphicon-fast-backward"></i>
	  		</a>
  		</c:if>
		<c:if test="${pageObject.page == 1 }">
	  		<a href="" onclick="return false"
	  		 ${noMove }  ${tooltip } >
	  			<i class="glyphicon glyphicon-fast-backward" style="color: ${noLinkColor};"></i>
	  		</a>
	  	</c:if>
	</li>
	
	
	<li data-page=${pageObject.startPage -1 }>
		<c:if test="${pageObject.startPage > 1 }">
			<c:if test="${ empty query }">
				<!-- query가 없는 경우 pageObject는 일반 게시판 페이지 정보 -->
		  		<a href="${listURI }?page=${pageObject.startPage - 1 }&perPageNum=${pageObject.perPageNum}&key=${pageObject.key}&word=${pageObject.word}"
		  		  title="click to move previous page group!" ${tooltip } >
		  			<i class="glyphicon glyphicon-step-backward"></i>
		  		</a>
		  	</c:if>
			<c:if test="${ !empty query }">
				<!-- query가 있는 경우 pageObject는 댓글 페이지 정보, query : 일반게시판 페이지 정보 -->
		  		<a href="${listURI }?${query }&replyPage=${pageObject.startPage - 1 }&replyPerPageNum=${pageObject.perPageNum}"
		  		  title="click to move previous page group!" ${tooltip } >
		  			<i class="glyphicon glyphicon-step-backward"></i>
		  		</a>
	  		</c:if>
	  	</c:if>
		<c:if test="${pageObject.startPage == 1 }">
	  		<a href="" onclick="return false"
	  		 ${noMove } ${tooltip }>
	  			<i class="glyphicon glyphicon-step-backward" style="color: ${noLinkColor};"></i>
	  		</a>
	  	</c:if>
  	</li>
	<c:forEach begin="${pageObject.startPage }" end="${pageObject.endPage }" var="cnt">
  	<li ${(pageObject.page == cnt)?"class=\"active\"":"" } 
  	 data-page=${cnt }>
  	 	<!-- 페이지와 cnt가 같으면 링크가 없음 -->
  	 	<c:if test="${pageObject.page == cnt }">
  			<a href="" onclick="return false"
  			 ${noMove } ${tooltip }>${cnt}</a>
  	 	</c:if>
  	 	<!-- 페이지와 cnt가 같지 않으면 링크가 있음 -->
  	 	<c:if test="${pageObject.page != cnt }">
			<c:if test="${ empty query }">
				<!-- query가 없는 경우 pageObject는 일반 게시판 페이지 정보 -->
	  			<a href="${listURI }?page=${cnt }&perPageNum=${pageObject.perPageNum}&key=${pageObject.key}&word=${pageObject.word}"
		  		 title="click to move ${cnt } page" ${tooltip }>${cnt}</a>
			</c:if>
			<c:if test="${ !empty query }">
				<!-- query가 있는 경우 pageObject는 댓글 페이지 정보, query : 일반게시판 페이지 정보 -->
	  			<a href="${listURI }?${query }&replyPage=${cnt }&replyPerPageNum=${pageObject.perPageNum}"
		  		 title="click to move ${cnt } page" ${tooltip }>${cnt}</a>
			</c:if>
  		</c:if>
  	</li>
	</c:forEach>
	<c:if test="${pageObject.endPage < pageObject.totalPage }">
	  	<li data-page=${pageObject.endPage + 1 }>
			<c:if test="${ empty query }">
				<!-- query가 없는 경우 pageObject는 일반 게시판 페이지 정보 -->
		  		<a href="${listURI }?page=${pageObject.endPage + 1 }&perPageNum=${pageObject.perPageNum}&key=${pageObject.key}&word=${pageObject.word}"
		  		  title="click to move next page group!" ${tooltip } >
		  			<i class="glyphicon glyphicon-step-forward"></i>
		  		</a>
	  		</c:if>
			<c:if test="${ !empty query }">
				<!-- query가 있는 경우 pageObject는 댓글 페이지 정보, query : 일반게시판 페이지 정보 -->
		  		<a href="${listURI }?${query }&replyPage=${pageObject.endPage + 1 }&replyPerPageNum=${pageObject.perPageNum}"
		  		  title="click to move next page group!" ${tooltip } >
		  			<i class="glyphicon glyphicon-step-forward"></i>
		  		</a>
		  	</c:if>
	  	</li>
  	</c:if>
	<c:if test="${pageObject.endPage == pageObject.totalPage }">
	  	<li data-page=${pageObject.endPage + 1 }>
	  		<a href="" onclick="return false"
	  		 ${noMove }  ${tooltip } >
	  			<i class="glyphicon glyphicon-step-forward" style="color: ${noLinkColor};"></i>
	  		</a>
	  	</li>
  	</c:if>
	<c:if test="${pageObject.page < pageObject.totalPage }">
	  	<li data-page=${pageObject.totalPage }>
			<c:if test="${ empty query }">
				<!-- query가 없는 경우 pageObject는 일반 게시판 페이지 정보 -->
		  		<a href="${listURI }?page=${pageObject.totalPage }&perPageNum=${pageObject.perPageNum}&key=${pageObject.key}&word=${pageObject.word}"
		  		  title="click to move last page!" ${tooltip } >
			  		<i class="glyphicon glyphicon-fast-forward"></i>
		  		</a>
	  		</c:if>
			<c:if test="${ !empty query }">
				<!-- query가 있는 경우 pageObject는 댓글 페이지 정보, query : 일반게시판 페이지 정보 -->
		  		<a href="${listURI }?${query }&replyPage=${pageObject.totalPage }&replyPerPageNum=${pageObject.perPageNum}"
		  		  title="click to move last page!" ${tooltip } >
			  		<i class="glyphicon glyphicon-fast-forward"></i>
		  		</a>
		  	</c:if>
	  	</li>
  	</c:if>
	<c:if test="${pageObject.page == pageObject.totalPage }">
	  	<li data-page=${pageObject.totalPage }>
	  		<a href="" onclick="return false"
	  		 ${noMove }  ${tooltip } >
		  		<i class="glyphicon glyphicon-fast-forward" style="color: ${noLinkColor};"></i>
	  		</a>
	  	</li>
  	</c:if>
</ul> 

<script>
$(document).ready(function(){
  $('[data-toggle="tooltip"]').tooltip();
  $(".pagination").mouseover(function(){
//   		$(".tooltip > *:last").css({"background-color": "red", "border": "1px dotted #444"});   
	});
});
</script>
