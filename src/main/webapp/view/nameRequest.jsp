<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="bean.NameRequest"%>
<%
NameRequest nameRequest = (NameRequest) request.getAttribute("nameRequest");
%>

<html>
<head>
<!-- タイトル -->
<title>氏名申請詳細</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
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

.detail .oldname {
	width: 12%;
	background-color: #cccc9d;
}


.detail .newname {
	width: 12%;
	background-color: #e6e6b1;
}

.detail .oldnamekanji {
	background-color: #cccc9d;
}

.detail .newnamekanji {
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

.kana {
	height: 150px;
}

.oldkana {
	background-color: #cccc9d;
}

.newkana {
	background-color: #e6e6b1;
}

.oldnamekana {
	background-color: #cccc9d;
}

.newnamekana {
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
</style>

<body>
<div id="wrap">
		<!-- ヘッダー部分 -->
		<%@ include file="../common/header.jsp"%>

		<!-- メイン部分 -->
		<div id="main" class="container">

			<h2 style="text-align: center">-氏名申請詳細-</h2>

			<table class="beforeAfter">
				<tr>
					<th class="before">変更前</th>
					<th class="space"></th>
					<th class="after">変更後</th>
				</tr>
			</table>

			<table class="detail">
				<tr class="name">
					<th class="oldname">旧氏名</th>
					<td class="oldnamekanji"><%=nameRequest.getOldName()%></td>
					<th class="space">⇒</th>
					<th class="newname">新氏名</th>
					<td class="newnamekanji"><%=nameRequest.getNewName()%></td>
				</tr>

				<tr class="kana">
					<th class="oldkana">旧氏名(かな)</th>
					<td class="oldnamekana"><%=nameRequest.getOldNameKana()%></td>
					<th class="space">⇒</th>
					<th class="newkana">新氏名(かな)</th>
					<td class="newnamekana"><%=nameRequest.getNewNameKana()%></td>
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
				</div>
				</div>
</body>
</html>