<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="bean.NameRequest,bean.Request"%>
<%
NameRequest nameRequest = (NameRequest) request.getAttribute("nameRequest");
Request allRequest = (Request) request.getAttribute("allRequest");
int flag = (int) request.getAttribute("flag");
%>

<html>
<head>
<!-- タイトル -->
<title>氏名変更詳細</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<script src="<%=request.getContextPath()%>/js/script.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<style>
#main2 {
	position: relative;
	width: 100%;
	margin: 0px;
	flex-direction: row;
	z-index: 10;
}

h1 {
	padding: 30px 0;
	display: block;
	font-size: 2.5em;
	margin-block-start: 0.67em;
	margin-block-end: 0.67em;
	margin-inline-start: 0px;
	margin-inline-end: 0px;
	font-weight: bold;
	unicode-bidi: isolate;
}

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
	background-color: #e6e6b1;
}

.post {
	height: 150px;
}

.button {
	width: 80%;
	margin: 0 auto;
	text-align: center;
	padding: 50px 10px 10px 10px;
}

html {
	-webkit-box-sizing: border-box;
	box-sizing: border-box;
	font-size: 62.5%;
}

.btn, a.btn, button.btn {
	margin: 0 auto;
	width: 15%;
	font-size: 1.6rem;
	font-weight: 700;
	line-height: 1.5;
	position: relative;
	display: inline-block;
	padding: 0.5rem 1.5rem;
	cursor: pointer;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
	-webkit-transition: all 0.3s;
	transition: all 0.3s;
	text-align: center;
	vertical-align: middle;
	text-decoration: none;
	letter-spacing: 0.1em;
	border-radius: 8.5rem;
	font-size: 1.6rem;
}

a.btn--notApproved {
	color: #000;
	background-color: #bbc8e6;
	border-bottom: 2px solid #8491c3 transparent;
}

a.btn--notApproved:hover {
	margin-top: 3px;
	color: #000;
	background: #9192b3;
	border-bottom: 2px solid #4a488e;
	background: #9192b3;
}

.button tr {
	height: 40px
}

.return {
	width: 80%;
	margin: 0 auto;
	text-align: center;
}

.return .returnlist {
	width: 150px;
	height: 40px;
	border-radius: 4px 4px 4px 4px;
}

.return .returnlist:hover {
	transition: all 0.3s;
}

.app {
	width: 80%;
	margin: 0 auto;
	text-align: center;
}

.approved {
	width: 80%;
	margin: 0 auto;
}

.approver {
	width: 80%;
	margin: 0 auto;
}

.approvaldate {
	width: 80%;
	margin: 0 auto;
}
</style>

<body>
	<div id="wrap">
		<!-- ヘッダー部分 -->
		<%@ include file="../common/header.jsp"%>

		<!-- メイン部分 -->
		<div id="main2" class="container">

			<h1 style="text-align: center">-氏名申請詳細-</h1>

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
			<%
			if (flag == 0) {
			%>
			<table class="button">
				<tr>
					<td><a href="<%=request.getContextPath()%>/#?#%>"
						onclick="return confirm('承認しますか?')" class="btn btn--notApproved">承認</a></td>
				</tr>
			</table>
			<%
			} else if (flag == 1) {
			%>
			<table class="app">
				<tr>
					<td class="approved">承認済み</td>
				</tr>
				<tr>
					<td class="approver">承認者名：<%=allRequest.getApprover()%></td>
				</tr>
				<tr>
					<td class="approvaldate">承認日時：<%=allRequest.getApprovalDate()%></td>
				</tr>
			</table>
			<%
			}
			%>
			<tr>
				<th class="space"></th>
			</tr>
			</table>
			<table class="return">
				<tr>
					<td><a href="<%=request.getContextPath()%>/requestList"
						class="returnlist">申請一覧に戻る</a></td>
				</tr>
			</table>
			<br> <br> <br> <br>
		</div>
	</div>
</body>
</html>