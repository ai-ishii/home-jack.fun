<%--
機能：住所変更申請フォームに入力された内容の確認する画面表示

作成者：桑原岳

最終更新日：2025/08/12
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
/* 処理中にボタンを無効化するスタイル */
.button-area button:disabled {
	cursor: not-allowed;
	opacity: 0.6;
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
					<td>${employeeNumber}</td>
				</tr>
				<tr>
					<th>氏名</th>
					<td>${name}</td>
				</tr>
				<tr>
					<th>住所変更日時</th>
					<td>${addressChangedDate}</td>
				</tr>
				<tr>
					<th>旧郵便番号</th>
					<td>${oldPost}</td>
				</tr>
				<tr>
					<th>旧住所</th>
					<td>${oldAddress}</td>
				</tr>
				<tr>
					<th>新郵便番号</th>
					<td>${newPost}</td>
				</tr>
				<tr>
					<th>新住所</th>
					<td>${newAddress}</td>
				</tr>
				<tr>
					<th>最寄り駅</th>
					<td>${nearestStation}</td>
				</tr>
			</table>

			<form id="confirmDataForm" method="post">
				<input type="hidden" name="employeenumber" value="${employeeNumber}">
				<input type="hidden" name="name" value="${name}"> <input
					type="hidden" name="addressChangedDate"
					value="${addressChangedDate}"> <input type="hidden"
					name="oldpost" value="${oldPost}"> <input type="hidden"
					name="oldaddress" value="${oldAddress}"> <input
					type="hidden" name="newpost" value="${newPost}"> <input
					type="hidden" name="newaddress" value="${newAddress}"> <input
					type="hidden" name="neareststation" value="${nearestStation}">

				<div class="button-area">
					<button type="button" onclick="returnToEdit()">修正する</button>
					<button type="button" id="submitButton"
						onclick="submitAndDownload()">この内容で確定する</button>
				</div>
			</form>
		</div>
	</div>

	<script>
    // 「修正する」ボタンが押されたときの処理
  function returnToEdit() {
    const form = document.getElementById('confirmDataForm');
    form.action = `<%=request.getContextPath()%>/addressChangeRetouching`;
    form.submit();
  }

    // 「この内容で確定する」ボタンが押されたときの処理
    async function submitAndDownload() {
        const submitButton = document.getElementById('submitButton');
        const form = document.getElementById('confirmDataForm');
        
        submitButton.disabled = true;
        submitButton.textContent = '処理中...';

            // サーブレットにデータを送信
            const response = await fetch(`<%=request.getContextPath()%>/jspToExcel`, {
                method: 'POST',
                body: new URLSearchParams(new FormData(form)),
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                }
            });

            if (!response.ok) {
                const errorMessage = await response.text();
                throw new Error(`サーバーでエラーが発生しました: ${response.status} ${errorMessage}`);
            }

            // レスポンス（Excelファイル）をダウンロード
            const blob = await response.blob();
            const url = window.URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.style.display = 'none';
            a.href = url;
            a.download = '住所変更届のコピー.xlsx';
            document.body.appendChild(a);
            a.click();
            
            window.URL.revokeObjectURL(url);
            document.body.removeChild(a);

            // 完了ページへ画面遷移
            window.location.href = `<%=request.getContextPath()%>
		/view/completion.jsp`;

		}
	</script>
</body>
</html>
