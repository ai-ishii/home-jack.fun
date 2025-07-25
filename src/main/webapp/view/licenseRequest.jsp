<%@page import="util.MyFormat"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@ page import="bean.RequestLicenseRequestUser"%>
<%
RequestLicenseRequestUser requestLicenseRequestUser = (RequestLicenseRequestUser) request
		.getAttribute("requestLicenseRequestUser");
MyFormat myFormat = new MyFormat();
%>

<html>
<head>
<!-- タイトル -->
<title></title>
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


.license {
	width: 70%;
	height: 80%;
	margin: 0 auto;
}

.license td {
	border: solid 3px #000000;
}

.item {
	text-align: center;
	background-color: #afd5e6;
}

.request {
	text-align: center;
	background-color: #afd5e6;
}

.licensename {
	background-color: #e6ffcc;
}

.name {
	background-color: #fff7cc;
}

.licenseexamdate {
	background-color: #e6ffcc;
}

.examdate {
	background-color: #fff7cc;
}

.username {
	background-color: #e6ffcc;
}

.user {
	background-color: #fff7cc;
}

.affiliationdepartment {
	background-color: #e6ffcc;
}

.department {
	background-color: #fff7cc;
}

.affiliationteam {
	background-color: #e6ffcc;
}

.team {
	background-color: #fff7cc;
}

.licenseexamdate {
	background-color: #e6ffcc;
}

.examdate {
	background-color: #fff7cc;
}

.licenseexamtime {
	background-color: #e6ffcc;
}

.examtime {
	background-color: #fff7cc;
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
</style>
<body>
	<div id="wrap">
		<!-- ヘッダー部分 -->
		<%@ include file="../common/header.jsp"%>

		<!-- メイン部分 -->
		<div id="main2" class="container">

			<h1 style="text-align: center">-資格申請詳細-</h1>

			<table class="license">
				<tr>
					<td class="item">項目</td>
					<td class="request">申請内容</td>
				</tr>
				<tr>
					<td class="licensename">資格名</td>
					<td class="name"><%--<%=requestLicenseRequestUser.getLicenseRequest().getLicenseName()%>--%></td>
				</tr>
				<tr>
					<td class="username">氏名</td>
					<td class="user"><%--<%=requestLicenseRequestUser.getRequest().getName()%>--%></td>
				</tr>
				<td class="affiliationdepartment">部</td>
				<td class="department"><%--<%=requestLicenseRequestUser.getUser().getDepartment()%>--%>部</td>
				</tr>
				<tr>
					<td class="affiliationteam">グループ</td>
					<td class="team"><%--<%=requestLicenseRequestUser.getUser().getTeam()%>--%>グループ</td>
				</tr>
				<tr>
					<td class="licenseexamdate">受験日</td>
					<td class="examdate"><%--<%=myFormat.dateFormat(requestLicenseRequestUser.getLicenseRequest().getExamDate())%>--%></td>
				</tr>
				<tr>
					<td class="licenseexamtime">受験回数</td>
					<td class="examtime"><%--<%=requestLicenseRequestUser.getLicenseRequest().getExamTime()%>--%>回</td>
				</tr>
			</table>
			<table class="button">
				<tr>
					<td><a href="<%--<%=request.getContextPath()%>/#?#%>--%>"
						onclick="return confirm('承認しますか?')" class="btn btn--notApproved">承認</a></td>

				</tr>
				<tr>
					<th class="space"></th>
				</tr>
			</table>
			<table class="return">
				<tr>
					<td><a href="<%--<%=request.getContextPath()%>--%>/requestList"
						class="returnlist">申請一覧に戻る</a></td>
				</tr>
			</table>
			<br>
			<br>
			<br><br><br>
		</div>
	</div>
</body>
</html>
