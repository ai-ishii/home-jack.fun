<%--
機能：資格申請フォームに入力された内容の確認画面
作成者：桑原岳
最終更新日：2025/08/22
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<title>入力内容の確認</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<style>
.confirm-table {
	width: 50%;
	margin: 30px auto;
	border-collapse: collapse;
}

.confirm-table th, .confirm-table td {
	border: 1px solid #ccc;
	padding: 15px;
}

.confirm-table th {
	background-color: #f2f2f2;
	width: 30%;
	text-align: left;
}

.button-area {
	margin-top: 30px;
	display: flex;
	justify-content: center;
	gap: 20px;
}

.button-area button, .button-area a button {
	padding: 10px 20px;
	cursor: pointer;
}
</style>
</head>
<body>

	<div id="wrap">
		<%@ include file="../common/header.jsp"%>
		<div id="main" class="container">
			<h1>入力内容の確認</h1>
			<p style="text-align: center;">以下の内容でよろしいですか？</p>
			<table class="confirm-table">
				<tr>
					<th>氏名</th>
					<td><c:out value="${formValues.name}" /></td>
				</tr>
				<tr>
					<th>部署名</th>
					<td><c:out value="${formValues.department}" /></td>
				</tr>
				<tr>
					<th>グループ名</th>
					<td><c:out value="${formValues.group}" /></td>
				</tr>
				<tr>
					<th>資格名</th>
					<td><c:out value="${formValues.license}" /></td>
				</tr>
				<tr>
					<th>受験日</th>
					<td><c:out value="${formValues.examDate}" /></td>
				</tr>
				<tr>
					<th>受験回数</th>
					<td><c:out value="${formValues.examTime}" /></td>
				</tr>
				<tr>
					<th>受験料領収書</th>
					<td><c:out value="${formValues.receiptFileName}" /></td>
				</tr>
				<tr>
					<th>合格証</th>
					<td><c:out value="${formValues.passingFileName}" /></td>
				</tr>
			</table>
			<form id="confirmDataForm" method="post">
				<input type="hidden" name="name" value="${formValues.name}">
				<input type="hidden" name="department" value="${formValues.department}"> 
				<input type="hidden" name="group" value="${formValues.group}"> 
				<input type="hidden" name="license" value="${formValues.license}">
				<input type="hidden" name="examDate" value="${formValues.examDate}">
				<input type="hidden" name="examTime" value="${formValues.examTime}">
				<input type="hidden" name="receiptFileName" value="${formValues.receiptFileName}"> 
				<input type="hidden" name="passingFileName" value="${formValues.passingFileName}">
				<input type="hidden" name="requestId" value="${formValues.requestId}">
				<div class="button-area">
					<button type="submit"
						formaction="<%=request.getContextPath()%>/licenseRetouching">
						修正する</button>
					<button type="submit"
						formaction="<%=request.getContextPath()%>/licenseKeep">
						この内容で確定する</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>