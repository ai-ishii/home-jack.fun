<%@page import="util.MyFormat"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@ page import="bean.LicenseRequestExclusive,util.MyFormat"%>
<%
LicenseRequestExclusive licenseRequestExclusive = (LicenseRequestExclusive) request
		.getAttribute("licenseRequestExclusive");
String flag = (String) request.getAttribute("flag");
MyFormat myFormat = new MyFormat();
%>

<html>
<head>
<!-- タイトル -->
<title>資格申請承認画面</title>
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
	height: 50px;
}

.request {
	text-align: center;
	background-color: #afd5e6;
	height: 50px;
}

.applicationtime {
	background-color: #ccccc4;
}

.time {
	background-color: #f0f0e6;
}

.licensename {
	background-color: #ccccc4;
}

.name {
	background-color: #f0f0e6;
}

.licenseexamdate {
	background-color: #ccccc4;
}

.examdate {
	background-color: #f0f0e6;
}

.username {
	background-color: #ccccc4;
}

.user {
	background-color: #f0f0e6;
}

.affiliationgroupname {
	background-color: #ccccc4;
}

.groupname {
	background-color: #f0f0e6;
}

.licenseexamdate {
	background-color: #ccccc4;
}

.examdate {
	background-color: #f0f0e6;
}

.licenseexamtime {
	background-color: #ccccc4;
}

.examtime {
	background-color: #f0f0e6;
}

.submitreceipt {
	background-color: #ccccc4;
}

.receipt {
	background-color: #f0f0e6;
}

.certificateofpassing {
	background-color: #ccccc4;
}

.passing {
	background-color: #f0f0e6;
}

.button {
	width: 80%;
	margin: 0 auto;
	text-align: center;
	padding: 20px 10px 10px 10px;
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

			<h1 style="text-align: center">-資格申請承認-</h1>

			<table class="license">
				<tr>
					<td class="item">項目</td>
					<td class="request">申請内容</td>
				</tr>
				<tr>
					<td class="applicationtime">申請日時</td>
					<td class="time"><%=myFormat.datetimeFormat(licenseRequestExclusive.getRequestDate())%>
					</td>
				</tr>
				<tr>
					<td class="affiliationgroupName">所属</td>
					<td class="groupName"><%=licenseRequestExclusive.getDepartmentName()%><%=licenseRequestExclusive.getGroupName()%>

					</td>
				</tr>
				<tr>
					<td class="username">申請者</td>
					<td class="user"><%=licenseRequestExclusive.getApplicant()%></td>
				</tr>
				<tr>
					<td class="licensename">資格</td>
					<td class="name"><%=licenseRequestExclusive.getLicenseName()%>
					</td>
				</tr>


				<tr>
					<td class="licenseexamdate">受験日</td>
					<td class="examdate"><%=myFormat.dateFormat(licenseRequestExclusive.getExamDate())%>
					</td>
				</tr>
				<tr>
					<td class="licenseexamtime">受験回数</td>
					<td class="examtime"><%=licenseRequestExclusive.getExamTime()%>回
					</td>
				</tr>
				<tr>
					<td class="submitreceipt">領収書</td>
					<td class="receipt"><%=licenseRequestExclusive.getReceipt()%></td>
				</tr>
				<tr>
					<td class="certificateofpassing">合格証</td>
					<td class="passing"><%=licenseRequestExclusive.getPassing()%></td>
				</tr>


				<%
				if ("0".equals(flag)) {
				%>
				<table class="button">
					<tr>
						<td><a href="<%=request.getContextPath()%>/#?#%>"
							onclick="return confirm('申請を承認しますか?')" class="btn btn--notApproved">承認</a></td>
					</tr>
					<table class="button">
						<tr>
							<td><a href="<%=request.getContextPath()%>/#?#%>"
								onclick="return confirm('申請を差し戻しますか?')"
								class="btn btn--notApproved">差し戻し</a></td>
						</tr>

					</table>
					<%
					} else if ("1".equals(flag)) {
					%>
					<table class="app">
						<tr>
							<td class="approved">承認済み</td>
						</tr>
						<tr>
							<td class="approver">承認者名：<%=licenseRequestExclusive.getApprover()%></td>
						</tr>
						<tr>
							<td class="approvaldate">承認日時：<%=myFormat.datetimeFormat(licenseRequestExclusive.getApprovalDate())%></td>
						</tr>
					</table>

						<table class="button">
							<tr>
								<td><a href="<%=request.getContextPath()%>/#?#%>"
									onclick="return confirm('承認が取り消されますがよろしいですか？')"
										
									class="btn btn--notApproved">差し戻し</a></td>
							</tr>
						</table>
						<%
						}
						%>

					</table>
					<table class="return">
						<tr>
							<td><a href="<%=request.getContextPath()%>/licenseRequest"
								class="returnlist">資格申請一覧に戻る</a></td>
						</tr>
					</table>
					<br><br>
				</div>
	</div>
</body>
</html>
