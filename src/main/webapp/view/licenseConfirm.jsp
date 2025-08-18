<%--
機能：資格申請フォームに入力された内容の確認する画面表示

作成者：桑原岳

最終更新日：2025/08/18
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
	/* Flexboxを使ってボタンを中央揃えで横並びにする */
	display: flex;
	justify-content: center;
	gap: 20px; /* ボタンとボタンの間の隙間 */
}

.button-area button {
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
					<td>${name}</td>
				</tr>
				<tr>
					<th>部署名</th>
					<td>${department}</td>
				</tr>
				<tr>
					<th>グループ名</th>
					<td>${group}</td>
				</tr>
				<tr>
					<th>資格名</th>
					<td>${license}</td>
				</tr>
				<tr>
					<th>受験日</th>
					<td>${examDate}</td>
				</tr>
				<tr>
					<th>受験回数</th>
					<td>${examTime}</td>
				</tr>
				<tr>
					<th>受験料領収書</th>
					<td>${receiptTempFileName}</td>
				</tr>
				<tr>
					<th>合格証</th>
					<td>${passingTempFileName}</td>
				</tr>

			</table>

			<div class="button-area">

				<form action="<%=request.getContextPath()%>/view/licenseForm.jsp"
					method="post">
					<%-- データをhiddenフィールドで保持 --%>
					<input type="hidden" name="name" value="${name}"> <input
						type="hidden" name="department" value="${department}"> <input
						type="hidden" name="group" value="${group}"> <input
						type="hidden" name="license" value="${license}"> <input
						type="hidden" name="examDay" value="${examDay}"> <input
						type="hidden" name="examTime" value="${examTime}"> <input
						type="hidden" name="receiptTempFileName" value="${receiptTempFileName}"> <input
						type="hidden" name="passingTempFileName" value="${passingTempFileName}">

					<button type="submit">修正する</button>
				</form>

				<form action="<%=request.getContextPath()%>/licenseKeep"
					method="post">
					<input type="hidden" name="oldname" value="${oldName}"> <input
						type="hidden" name="oldnamekana" value="${oldNameKana}"> <input
						type="hidden" name="newname" value="${newName}"> <input
						type="hidden" name="newnamekana" value="${newNameKana}">

					<button type="submit">この内容で確定する</button>
				</form>

			</div>
		</div>
	</div>
</body>
</html>