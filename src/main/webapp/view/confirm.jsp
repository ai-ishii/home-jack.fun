<%--
機能：住所変更申請フォームに入力された内容の確認する画面表示

作成者：桑原岳

最終更新日：2025/08/07
 --%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<html>
<head>
<title>入力内容の確認</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<style>
.confirm-table {
	width: 60%;
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
	text-align: center;
	margin-top: 30px;
}

.button-area button {
	padding: 10px 20px;
	margin: 0 15px;
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
					<th>社員番号</th>
					<td><%=request.getAttribute("employeeNumber")%></td>
				</tr>
				<tr>
					<th>氏名</th>
					<td><%=request.getAttribute("name")%></td>
				</tr>
				<tr>
					<th>住所変更日時</th>
					<td><%=request.getAttribute("addressChangedDate")%></td>
				</tr>
				<tr>
					<th>旧郵便番号</th>
					<td><%=request.getAttribute("oldPost")%></td>
				</tr>
				<tr>
					<th>旧住所</th>
					<td><%=request.getAttribute("oldAddress")%></td>
				</tr>
				<tr>
					<th>新郵便番号</th>
					<td><%=request.getAttribute("newPost")%></td>
				</tr>
				<tr>
					<th>新住所</th>
					<td><%=request.getAttribute("newAddress")%></td>
				</tr>
				<tr>
					<th>最寄り駅</th>
					<td><%=request.getAttribute("nearestStation")%></td>
				</tr>
			</table>

			<form id="confirmForm"
				action="<%=request.getContextPath()%>/jspToExcel" method="post">
			
				<input type="hidden" name="employeenumber"
					value="<%=request.getAttribute("employeeNumber")%>">
				<input type="hidden" name="name"
					value="<%=request.getAttribute("name")%>">
				<input type="hidden" name="addressChangedDate"
					value="<%=request.getAttribute("addressChangedDate")%>">
				<input type="hidden" name="oldpost"
					value="<%=request.getAttribute("oldPost")%>">
				<input type="hidden" name="oldaddress"
					value="<%=request.getAttribute("oldAddress")%>">
				<input type="hidden" name="newpost"
					value="<%=request.getAttribute("newPost")%>">
				<input type="hidden" name="newaddress"
					value="<%=request.getAttribute("newAddress")%>">
				<input type="hidden" name="neareststation"
					value="<%=request.getAttribute("nearestStation")%>">

				<div class="button-area">
					<button type="button" onclick="history.back()">修正する</button>
					<button type="button" onclick="submitAndRedirect()">この内容で確定する</button>
				</div>
			</form>
		</div>
	</div>
	<script>
        function submitAndRedirect() {
            // 1. フォームを送信してダウンロードを開始する
            document.getElementById('confirmForm').submit();

            // 2. 0.5秒後に完了画面へ遷移する
            setTimeout(function() {
                window.location.href = '<%=request.getContextPath()%>/view/completion.jsp';
            }, 500);
        }
	</script>
</body>
</html>