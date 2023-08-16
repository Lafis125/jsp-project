<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<meta http-equiv="X-UA-Compatible" content="IE=edge">

<title>team3PJ:<decorator:title /></title>
<title>team3PJ</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>


<!-- Google Font -->
<link
	href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,700|Raleway:400,300,500,700,600'
	rel='stylesheet' type='text/css'>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css"
	type="text/css">



<link rel="stylesheet" href="/resource/css/main/main.css?v=2023-08-10"
	type="text/css" />
<link rel="stylesheet" href="/resource/css/product/main.css?v=3" type="text/css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>

<style type="text/css">
.widget-inner li a i, .widget-inner p i {
	padding-right: 7px;
}
</style>
<!-- member js -->
<decorator:head />
</head>
<body>
	<header>
		<!-- top bar   -->
		<div class="top-bar">
			<div class="container">
				<div class="row">
					<div class="col-md-6">
						<div class="social pull-left">
							<div>
								<div>
									<a href="/main/main.do"><img
										style="height: 50px; width: 100px;"
										src="/resource/image/main/b.svg" alt="Logo" /></a>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-6">
						<div class="action pull-right">
							<ul>
								<c:if test="${ empty login }">
									<li><a href="/member/login.do"><i class="fa fa-user"></i>
											로그인</a></li>
									<li><a href="/member/agreeMent.do"><i
											class="fa fa-user-plus" aria-hidden="true"></i> 회원가입</a></li>
								</c:if>
								<c:if test="${ not empty login }">
									<li style="font-family: Lato, sans-serif;"><a>*
											${login.login_name } * 님 환영합니다.</a></li>
									<li><a href="/member/viewInfo.do"><i
											class="fa fa-user-circle-o" aria-hidden="true"></i> 내정보</a></li>
									<c:if test="${ login.login_gradeNo == 9}">
										<li><a href="/member/manageList.do"><i
												class="fa fa-cog" aria-hidden="true"></i> 회원관리</a></li>
									</c:if>
									<li><a href="/cart/list.do"><i
											class="fa fa-shopping-cart" aria-hidden="true"></i> 장바구니</a></li>
									<li><a href="/member/logout.do"><i
											class="fa fa-sign-out" aria-hidden="true"></i> 로그아웃</a></li>
								</c:if>

							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</header>
	<article>
		<decorator:body />
	</article>
	<!-- footer -->
	<div class="footer">
		<div class="container">
			<div class="row">
				<div class="col-md-3 col-sm-3">
					<div class="single-widget">
						<h2 class="widget-title">About Us</h2>
						<div class="widget-inner">
							<p>
								<i class="fa fa-building fa-2x" aria-hidden="true"></i>Office:
								EZEN Academy
							</p>
							<p>
								<i class="fa fa-phone-square fa-2x" aria-hidden="true"></i>Phone:
								010-xxxx-xxxx
							</p>
							<p>
								<i class="fa fa-fax fa-2x" aria-hidden="true"></i>Fax:
								000-xxxx-xxxx
							</p>
							<p>
								<i class="fa fa-envelope-o fa-2x" aria-hidden="true"></i>Email:
								Bong@google.com
							</p>
						</div>
					</div>
				</div>

				<div class="col-md-3 col-sm-3">
					<div class="single-widget">
						<h2 class="widget-title">Customer Care</h2>
						<div class="widget-inner">
							<ul>
								<li><a href=""><i class="fa fa-user fa-2x"
										aria-hidden="true"></i>BongGuu Member</a></li>
								<li><a href=""><i class="fa fa-cart-plus fa-2x"
										aria-hidden="true"></i>BongGuu Cart</a></li>
								<li><a href=""><i class="fa fa-bars fa-2x"
										aria-hidden="true"></i>BongGuu Category</a></li>
								<li><a href=""><i class="fa fa-product-hunt fa-2x"
										aria-hidden="true"></i>BongGuu Product</a></li>
								<li><a href=""><i class="fa fa-microphone fa-2x"
										aria-hidden="true"></i>BongGuu Notice</a></li>
							</ul>
						</div>
					</div>
				</div>

				<div class="col-md-3 col-sm-3">
					<div class="single-widget">
						<h2 class="widget-title">information</h2>
						<div class="widget-inner">
							<ul>
								<li><a href=""><i class="fa fa-bold fa-2x"
										aria-hidden="true"></i>Contact Us</a></li>
								<li><a href=""><i class="fa fa-bold fa-2x"
										aria-hidden="true"></i>Sitemap</a></li>
								<li><a href=""><i class="fa fa-bold fa-2x"
										aria-hidden="true"></i>Gift Vouchers</a></li>
								<li><a href=""><i class="fa fa-bold fa-2x"
										aria-hidden="true"></i>Live Chat</a></li>
							</ul>
						</div>
					</div>
				</div>

				<div class="col-md-3 col-sm-3">
					<div class="single-widget">
						<h2 class="widget-title">Our SNS</h2>
						<div class="widget-inner">
							<ul>
								<li><a href="#"> <i
										class="fa fa-facebook-official fa-2x" aria-hidden="true"></i>Facebook
								</a></li>
								<li><a href="#"> <i class="fa fa-google fa-2x"
										aria-hidden="true"></i>Google
								</a></li>
								<li><a href="#"> <i class="fa fa-twitter-square fa-2x"
										aria-hidden="true"></i>Twitter
								</a></li>
								<li><a href="#"> <i class="fa fa-linkedin fa-2x"
										aria-hidden="true"></i>Linkedin
								</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

</html>
