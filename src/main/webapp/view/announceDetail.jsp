<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bean.Announce"%>

<%
Announce announce = (Announce) request.getAttribute("announce");
%>
<!DOCTYPE html>
<html>
<head>
<title>お知らせ</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<script src="<%=request.getContextPath()%>/js/script.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<style>
#announce_box {
	display: flex;
	flex-direction: column;
	align-items: center;
	width: 80%;
	margin: 0 auto;
	
}

#title_box {
	display: flex;
	align-items: center;
	position: relative;
	width: 100%;
	height: 150px;
	background-color: #ffffff;
	margin: 70px auto 0 auto;
	border-bottom: 3px solid #FFC465;
	border-top-right-radius: 20px;
	border-top-left-radius: 20px;
}

.year {
	width: 10%;
	height: 150px;
}

.year p {
	text-align: right;
	font-size: 25px;
}

.date {
	width: 20%;
}

.date p {
	font-size: 60px;
	text-align: center;
	padding: 30px 0;
	margin: 0;
}

.title {
	width: 70%;
}

.title p {
	text-align: left;
	font-size: 30px;
	padding: 50px 0;
	margin: 0;
}

.category {
	position: absolute;
	top: -80px;
	right: 20px;
	min-width: 20px;
	height: 20px;
	color: #aaaaaa;
}

.category p {
	text-align: center;
	font-size: 18px;
	padding: 30px 0 0 0;
}

#content_box {
	display: flex;
	justify-content: center;
	width: 100%;
	min-height: 500px;
	background-color: #ffffff;
	margin: 0 auto 70px auto;
	border-bottom-right-radius: 10px;
	border-bottom-left-radius: 10px;
}

.text_box {
	width: 90%;
	min-height: 500px;
	padding: 20px 0;
}

.text_box p {
	white-space: pre-line;
}
</style>
</head>
<body>
	<div id="wrap">

		<!-- ヘッダー部分 -->
		<%@include file="../common/header.jsp"%>

		<!-- メイン部分 -->
		<div id="main" class="container">
			<div id="announce_box">
				<div id="title_box">
					<div class="year">
						<p>2025</p>
					</div>
					<div class="date">
						<p>7/7</p>
					</div>
					<div class="title">
						<p><%=announce.getTitle()%></p>
					</div>
					<div class="category">
						<p>#お知らせ</p>
					</div>
				</div>
				<div id="content_box">
					<div class="text_box">
					<p><%=announce.getText()%></p>
					</div>
				</div>

				<a href="<%=request.getContextPath()%>/announce">一覧へ</a>
			</div>
		</div>
	</div>

</body>
</html>
