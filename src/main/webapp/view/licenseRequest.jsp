<%@page import="util.MyFormat"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@ page
	import="bean. LicenseRequestExclusive,bean.Request,java.util.ArrayList"%>
<%
ArrayList<LicenseRequestExclusive> licenseRequestExclusiveList = (ArrayList<LicenseRequestExclusive>) request
		.getAttribute("licenseRequestExclusiveList");
MyFormat myFormat = new MyFormat();
%>

<html>
<head>
<!-- タイトル -->
<title>資格申請一覧</title>
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

.list {
	width: 90%;
	margin: 0 auto;
}

.list th {
	border: 1px solid;
	background-color: #afd5e6;
	text-align: center;
}

.time {
	width: 9%;
}

.groupName {
	width: 12%;
}

.applicant {
	width: 7%;
}

.licenseName {
	width: 14%;
}

.examDate {
	width: 9%;
}

.examTime {
	width: 5%;
}

.receipt {
	width: 11%;
}

.passing {
	width: 11%;
}

.approver {
	width: 7%;
}

.approvalDate {
	width: 9%;
}

.requestFlag {
	width: 7%;
}

.display {
	width: 90%;
	margin: 0 auto;
}

.display tr:nth-child(even) {
	background-color: white;
}

.display tr:nth-child(odd) {
	background-color: #f0f0e6;
}

.display td {
	text-align: center;
	font-size: 12px;
	height: 60px;
}

.time td {
	width: 10%;
	height: 60px;
}

.groupName td {
	width: 10%;
	height: 60px;
}

.applicant td {
	width: 8%;
	height: 60px;
}

.licenseName td {
	width: 10%;
	height: 60px;
}

.examDate td {
	width: 10%;
	height: 60px;
}

.examTime td {
	width: 5%;
	height: 60px;
}

.receipt td {
	width: 10%;
	height: 60px;
}

.passing td {
	width: 10%;
	height: 60px;
}

.approver td {
	width: 10%;
	height: 60px;
}

.approvalDate td {
	width: 10%;
	height: 60px;
}

.requestFlag td {
	width: 7%;
	height: 60px;
}
/* 行全体ホバーで色だけ変える（リンク風ではない） */
.row-hover:hover {
	background-color: #eef;
}

.display tbody tr:hover {
	background-color: #f2f2f2; /* マウスオーバー時の背景色 */
	cursor: pointer; /* カーソルを指の形に変更 */
}
</style>
<body>
	<div id="wrap">
		<!-- ヘッダー部分 -->
		<%@ include file="../common/header.jsp"%>

		<!-- メイン部分 -->
		<div id="main2" class="container">

			<h1 style="text-align: center">-資格申請一覧-</h1>

<<<<<<< HEAD
			<table class="list">
				<thead>
					<tr>
=======
			<table class="license">
				<tr>
					<td class="item">項目</td>
					<td class="request">申請内容</td>
				</tr>
				<tr>
					<td class="licensename">資格名</td>
					<td class="name"><%=requestLicenseRequestUser.getLicenseRequest().getLicenseName()%></td>
				</tr>
				<tr>
					<td class="username">氏名</td>
					<td class="user"><%=requestLicenseRequestUser.getRequest().getName()%></td>
				</tr>
				<td class="affiliationdepartment">部</td>
				<td class="department"><%=requestLicenseRequestUser.getUser().getDepartmentId()%>部</td>
				</tr>
				<tr>
					<td class="affiliationteam">グループ</td>
					<td class="team"><%=requestLicenseRequestUser.getUser().getGroupId()%>グループ</td>
				</tr>
				<tr>
					<td class="licenseexamdate">受験日</td>
					<td class="examdate"><%=myFormat.dateFormat(requestLicenseRequestUser.getLicenseRequest().getExamDate())%></td>
				</tr>
				<tr>
					<td class="licenseexamtime">受験回数</td>
					<td class="examtime"><%=requestLicenseRequestUser.getLicenseRequest().getExamTime()%>回</td>
				</tr>
			</table>
			<table class="button">
				<tr>
					<td><a href="<%=request.getContextPath()%>/#?#%>"
						onclick="return confirm('承認しますか?')" class="btn btn--notApproved">承認</a></td>
>>>>>>> refs/heads/test2

						<th class="time">申請日時</th>
						<th class="groupName">所属</th>
						<th class="applicant">申請者</th>
						<th class="licenseName">資格</th>
						<th class="examDate">受験日</th>
						<th class="examTime">受験回数</th>
						<th class="receipt">領収書</th>
						<th class="passing">合格証</th>
						<th class="approver">承認者</th>
						<th class="approvalDate">承認日時</th>
						<th class="requestFlag">申請状況</th>

					</tr>
				</thead>
			</table>
			<table class="display">

				<tbody>
					<%
					for (int i = 0; i < licenseRequestExclusiveList.size(); i++) {
					%>
					<tr
						onclick="location.href='<%=request.getContextPath()%>/licenseRequestDetail?requestId=<%=licenseRequestExclusiveList.get(i).getRequestId()%>&flag=<%=licenseRequestExclusiveList.get(i).getRequestFlag()%>'">

						<td class="time"><%=myFormat.dateFormat(licenseRequestExclusiveList.get(i).getRequestDate())%></td>
						<td class="groupName"><%=licenseRequestExclusiveList.get(i).getDepartmentName()%><%=licenseRequestExclusiveList.get(i).getGroupName()%></td>
						<td class="applicant"><%=licenseRequestExclusiveList.get(i).getApplicant()%></td>
						<td class="licenseName"><%=licenseRequestExclusiveList.get(i).getLicenseName()%></td>
						<td class="examDate"><%=myFormat.dateFormat(licenseRequestExclusiveList.get(i).getExamDate())%></td>
						<td class="examTime"><%=licenseRequestExclusiveList.get(i).getExamTime()%>回</td>
						<td class="receipt"><%=licenseRequestExclusiveList.get(i).getReceipt()%></td>
						<td class="passing"><%=licenseRequestExclusiveList.get(i).getPassing()%></td>
						<%
						if (licenseRequestExclusiveList.get(i).getRequestFlag() == 0) {
						%>
						<td class="approver">――</td>
						<%
						} else if (licenseRequestExclusiveList.get(i).getRequestFlag() == 1) {
						%>
						<td class="approver"><%=licenseRequestExclusiveList.get(i).getApprover()%></td>
						<%
						}
						if (licenseRequestExclusiveList.get(i).getRequestFlag() == 0) {
						%>
						<td class="approvalDate">――</td>
						<%
						} else if (licenseRequestExclusiveList.get(i).getRequestFlag() == 1) {
						%>
						<td class="approvalDate"><%=myFormat.dateFormat(licenseRequestExclusiveList.get(i).getApprovalDate())%></td>
						<%
						}
						if (licenseRequestExclusiveList.get(i).getRequestFlag() == 0) {
						%>
						<td class="request_flag1">承認待ち</td>
						<%
						} else if (licenseRequestExclusiveList.get(i).getRequestFlag() == 1) {
						%>
						<td class="request_flag2">承認済み</td>
						<%
						}
						%>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>

			<br> <br> <br> <br> <br>
		</div>
	</div>
</body>
</html>
