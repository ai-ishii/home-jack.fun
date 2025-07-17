<%@page contentType="text/html; charset=UTF-8"%>
<%@ page import="bean.AddressRequest"%>
<%
AddressRequest addressRequest = (AddressRequest) request.getAttribute("addressRequest");
%>
<html>
<head>
<!-- タイトル -->
<title>住所申請詳細</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<script src="<%=request.getContextPath()%>/js/script.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<style>
.detail {
	width: 80%;
	margin: 0 auto;
}

.detail td, .detail th {
	padding: 8px 20px
}

.detail td {
	width: 28%;
}

.detail .oldpost {
	width: 12%;
	background-color: #cccc9d;
}

.detail .space {
	width: 20%;
	font-size: 50px;
	color: #000000;
}

.detail .newpost {
	width: 12%;
	background-color: #e6e6b1;
}

.detail .oldpostnumber {
	background-color: #cccc9d;
}

.detail .newpostnumber {
	color: #e65d45;
	background-color: #e6e6b1;
}

.beforeAfter {
	width: 80%;
	margin: 0 auto;
	border-collapse: separate;
}

.before {
	width: 40%;
	text-align: center;
	background-color: #b0e0e6;
	padding: 8px 20px;
}

.after {
	width: 40%;
	text-align: center;
	background-color: #b0e0e6;
	padding: 8px 20px;
}

.space {
	width: 20%;
	padding: 8px 20px;
	font-size: 50px;
}

.address {
	height: 150px;
}

.oldaddress {
	background-color: #cccc9d;
}

.newaddress {
	background-color: #e6e6b1;
}

.oldaddressnumber {
	background-color: #cccc9d;
}

.newaddressnumber {
	color: #e65d45;
	background-color: #e6e6b1;
}

.post {
	height: 150px;
}

.button {
	width: 80%;
	margin: 0 auto;
	text-align: center;
	padding: 50px;
}

.button .approval {
	width: 150px;
	height: 40px;
	background-color: #e6e6e6;
	color: #000000;
	border-radius: 4px 4px 4px 4px;
}

.button .approval:hover {
	background-color: #32adfa;
	transition: all 0.3s;
	color: f0f8ff;
}

.button .returnlist {
	width: 150px;
	height: 40px;
	background-color: #e6e6e6;
	border-radius: 4px 4px 4px 4px;
}

.button .returnlist:hover {
	background-color: #cccccc;
	transition: all 0.3s;
}
</style>

<body>
	<div id="wrap">
		<!-- ヘッダー部分 -->
		<%@ include file="../common/header.jsp"%>

		<!-- メイン部分 -->
		<div id="main" class="container">

			<h2 style="text-align: center">-住所申請詳細-</h2>

			<table class="beforeAfter">
				<tr>
					<th class="before">変更前</th>
					<th class="space"></th>
					<th class="after">変更後</th>
				</tr>
			</table>

			<table class="detail">
				<tr class="post">
					<th class="oldpost">旧郵便番号</th>
					<td class="oldpostnumber"><%=addressRequest.getOldPost()%></td>
					<th class="space">⇒</th>
					<th class="newpost">新郵便番号</th>
					<td class="newpostnumber"><%=addressRequest.getNewPost()%></td>
				</tr>

				<tr class="address">
					<th class="oldaddress">旧住所</th>
					<td class="oldaddressnumber"><%=addressRequest.getOldAddress()%></td>
					<th class="space">⇒</th>
					<th class="newaddress">新住所</th>
					<td class="newaddressnumber"><%=addressRequest.getNewAddress()%></td>
				</tr>
			</table>
			<table class="button">
				<tr>
					<td><input class="approval" type="submit" value="承認"></td>
				</tr>
				<tr>
					<th class="space"></th>
				</tr>
				<tr>
					<td><a href="<%=request.getContextPath()%>/requestList" class="returnlist">一覧に戻る</a></td>
				</tr>
				</table>
				</div>
				</div>
</body>
</html>