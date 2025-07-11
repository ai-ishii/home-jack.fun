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
<style>

#title_box {
	display: flex;
	align-items: center;
	width: 80%;
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
	width: 60%;
}

.title p {
	text-align: left;
	font-size: 30px;
	padding: 50px 0;
	margin: 0;
}

.category {
	width: 10%;
	height: 20px;
}

.category {
	text-align: center;
	font-size: 18px;
}

#content_box {
	width: 80%;
	min-height: 500px;
	background-color: #ffffff;
	margin: 0 auto 70px auto;
	border-bottom-right-radius: 10px;
	border-bottom-left-radius: 10px;
}

</style>
</head>
<body>
	
	<%@include file="../common/header.jsp" %>
	
	<div id="title_box">
		<div class="year">
			<p>2025</p>
		</div>
		<div class="date">
			<p>7/7</p>
		</div>
		<div class="title">
			<p><%= announce.getTitle() %></p>
		</div>
		<div class="categoty">
			<p>#お知らせ</p>
		</div>
	</div>
	<div id="content_box">
		<p><%= announce.getText() %></p>
	</div>
	
	<a href="<%= request.getContextPath() %>/announce">一覧へ</a>
	
</body>
</html>
