<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
	<div class="header">
		<div class="container">
			<div class="row">
				<!-- logo	넣기 -->
				<div class="col-md-3 col-sm-4">
					<div class="logo">
						<a href="#"> <img src="/resource/image/main/B.png" alt="logo">
						</a>
					</div>
				</div>
				<!-- 검색창 -->
				<div class="col-md-7 col-sm-5">
					<div class="search-form">
						<form class="navbar-form" role="search">
							<div class="form-group">
								<input type="text" class="form-control" placeholder="검색창">
							</div>
							<button type="submit" class="btn">
								<i class="fa fa-search"></i>
							</button>
						</form>
					</div>
				</div>
				<!-- 장바구니 -->
				<div class="col-md-2 col-sm-3">
					<div class="cart">
						<div class="cart-icon">
							<a href=""><svg viewBox="0 0 576 512" width="50" height="50"
									title="shopping-cart" class="cart-icon-color">
  <path
										d="M528.12 301.319l47.273-208C578.806 78.301 567.391 64 551.99 64H159.208l-9.166-44.81C147.758 8.021 137.93 0 126.529 0H24C10.745 0 0 10.745 0 24v16c0 13.255 10.745 24 24 24h69.883l70.248 343.435C147.325 417.1 136 435.222 136 456c0 30.928 25.072 56 56 56s56-25.072 56-56c0-15.674-6.447-29.835-16.824-40h209.647C430.447 426.165 424 440.326 424 456c0 30.928 25.072 56 56 56s56-25.072 56-56c0-22.172-12.888-41.332-31.579-50.405l5.517-24.276c3.413-15.018-8.002-29.319-23.403-29.319H218.117l-6.545-32h293.145c11.206 0 20.92-7.754 23.403-18.681z" />
</svg></a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- navigation  시작 -->
	<div class="navigation">
		<nav class="navbar navbar-theme" style="margin-bottom: 0px;">
			<div class="container">
				<!-- Brand and toggle get grouped for better mobile display -->
				<div class="navbar-header">
					<button type="button" class="navbar-toggle collapsed"
						data-toggle="collapse" data-target="#navbar" aria-expanded="false">
						<span class="sr-only">Menu</span> <span class="icon-bar"></span> <span
							class="icon-bar"></span> <span class="icon-bar"></span>
					</button>
				</div>

				<div class="shop-category nav navbar-nav navbar-left">
					<!-- Single button -->
					<div class="btn-group">
						<button type="button"
							class="btn btn-shop-category dropdown-toggle"
							data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							Category <span class="caret"></span>
						</button>
						<ul class="dropdown-menu">
							<!-- 소제목  -->
							<li class="non-hover category-text-center"><a
								style="color: #78909C; font-style: bolder;">공동구매</a></li>
							<!-- 라인줄  -->
							<li role="separator" class="divider"></li>
							<!-- 아이템  -->
							<li class="category-text-center"><a href="/product/list.do">IT</a></li>
							<li class="category-text-center"><a href="#">Fashion</a></li>
							<li class="category-text-center"><a href="#">Movies</a></li>
							<!-- 소제목  -->
							<li class="non-hover category-text-center"><a
								style="color: #78909C;">상품평</a></li>
							<!-- 라인줄  -->
							<li role="separator" class="divider"></li>
							<!-- 아이템  -->
							<li class="category-text-center"><a href="#">상품후기 리스트</a></li>
							<li class="category-text-center"><a href="#">상품후기 작성</a></li>
							<li class="category-text-center"><a href="#">나의 상품후기</a></li>
						</ul>
					</div>
				</div>

				<!-- Collect the nav links, forms, and other content for toggling -->
				<!-- nav바 상단 우측 -->
				<div class="collapse navbar-collapse" id="navbar">
					<ul class="nav navbar-nav navbar-right">
						<li><a class="text-sizes" href="/product/list.do">it</a></li>
						<li><a href="#">Fashion </a></li>
						<li><a href="#">Movies </a></li>
						<li><a href="#">상품후기</a></li>
						<li><a href="#">공지사항</a></li>
						<li><a href="#">고객센터</a></li>
					</ul>
				</div>
				<!-- /.navbar-collapse -->
			</div>
			<!-- /.container-fluid -->
		</nav>
	</div>


	<main class="main-container">
		<div class="container">
			<div style="margin-bottom: 10px" class="row">
				<div id="searchDiv">
					<form action="/product/list.do" class="form-inline">
						<input name="page" value="1" type="hidden" />
						<div class="form-group">
							<select class="form-control" id="key" name="key">
								<option value="t">상품명</option>
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
						<div class="input-group pull-right">
							<span class="input-group-addon">Rows/Page</span><select
								class="form-control" id="perPageNum" name="perPageNum">
								<option>5</option>
								<option>10</option>
								<option>15</option>
								<option>20</option>
							</select>
						</div>
					</form>
				</div>
			</div>
			<!-- 이미지 검색 창 끝 -->
			<div class="product-list">
				<c:forEach items="${mainlist }" var="vo" varStatus="vs">
					<c:if test="${vs.index != 0 && vs.index % 4 ==0 }">
					${"</div>" }
					${"<div class=\"row\">"}
				</c:if>
					<div class="product-imgsize">
						<div>
							<img src="${vo.thumb }" alt="${vo.thumb }">
						</div>
						<h4>${vo.proTitle }</h4>
						<p>
							<i class="fa fa-usd" aria-hidden="true"></i>${vo.proPrice }원</p>
					</div>
					<span id="proNo" style="display: none;">${vo.proNo }</span>
					<span id="caNo" style="display: none;">${vo.caNo }</span>
				</c:forEach>
			</div>
		</div>
	</main>
</body>
</html>