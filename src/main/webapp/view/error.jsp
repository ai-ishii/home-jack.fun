<%--　
エラー表示画面(共通画面)

作成者:青木美波

作成日:2025/7/14

更新日:2025/8/7
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%
// エラー文を受け取る
String error = (String) request.getAttribute("error");
//cmd(エラー種類)を受け取る
String cmd = (String) request.getAttribute("cmd");

// 遷移先のパス
String path = "";

if (cmd.equals("announce")) {
	path = "/announce";
} else if (cmd.equals("employee")) {
	path = "/employee";
} else if (cmd.equals("goal")) {
	path = "/goal";
} else if (cmd.equals("monthJackworks")) {
	path = "/monthJackworks";
} else if (cmd.equals("licenseList")) {
	path = "/licenseList";
} else if (cmd.equals("licenseRequest")) {
	path = "/licenseRequest";
} else if (cmd.equals("userList")) {
	path = "/userList";
}
%>
	
<html>
<head>
<!-- タイトル -->
<title>エラー | Home-Jack</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<script src="<%=request.getContextPath()%>/js/script.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<style>

.errorArea {
	margin-top: 5%;
	width: 100%;
}

.main {
	display: inline-block;
	padding-top: 0;
	padding-left: 3%;
	width: 22%;
	vertical-align: top;
}

h1 {
	margin: 0;
	font-size: 100px;
}

.back {
	display: inline-block;
	padding: 5%;
	background-color: lightsalmon;
	text-decoration: none;
	color: white;
	font-weight: bold;
}

.errorChara {
	position: absolute;
	top: 40%;
	left: 100%;
	width: 200px;
	height: 200px;
}

.sub {
	display: inline-block;
	position: relative;
	padding-top: 3%;
	padding-left: 5%;
	width: 50%;
	height: 280px;
	border-left: double 5px black;
	vertical-align: top;
}
</style>

<body>
	<div id="wrap">
		<!-- ヘッダー部分 -->
		<%@ include file="../common/header.jsp"%>

		<!-- メイン部分 -->
		<div id="main" class="container">

			<div class="errorArea">

				<div class="main">
					<h1>Error</h1>
					<%
					if (cmd.equals("logout")) {
					%>
					<a class="back" href="<%= request.getContextPath() %>/index.jsp">ログイン画面に戻る</a>
					<%
					} else {
					%>
					<a class="back" href="<%= request.getContextPath() %>/<%= path %>">一覧画面に戻る</a>
					<%
					}
					%>
				</div>

				<div class="sub">
					<h2><%= error %></h2>
					<%
					if (cmd.equals("logout")) {
					%>
					<p>申し訳ありませんが、画面左のリンクからログイン画面に戻ってください</p>
					<%
					} else {
					%>
					<p>申し訳ありませんが、画面左のリンクから一覧画面に戻ってください</p>
					<%
					}
					%>
					<img class="errorChara" src="<%= request.getContextPath() %>/img/errorChara.png" alt="エラー画面のキャラクター">
				</div>

			</div>

		</div>
	</div>
</body>
</html>