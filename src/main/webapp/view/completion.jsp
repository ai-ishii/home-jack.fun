<%--
機能：内容確定のお知らせとメニュー画面へのリンクが表示される

作成者：桑原岳

最終更新日：2025/08/26
 --%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>入力内容の確認</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<script src="<%=request.getContextPath()%>/js/script.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<style>
.form-link {
	width: 80%;
	margin: auto;
	text-align: center;
	font-size: 18px;
	padding: 20px;
}

.instruction-box {
	max-width: 650px;
	margin: auto;
	padding: 30px;
    color: #2c2c2f;
    background: #fff3e0;
    border-top: solid 10px #99702e;
    border-bottom: solid 10px #99702e;
}

.instruction-box h3 {
	margin: 0; 
    padding: 0;
}
</style>
</head>
<body>
	<div id="wrap">
		<%@ include file="../common/header.jsp"%>
		<div id="main" class="container">
			<h1 style="text-align: center;">内容を確定しました。</h1>
			<div class="instruction-box">
				<h3>内容確定後の手順</h3>
				<h3>1.ダウンロードされたエクセルの内容を確認し、印刷する。</h3>
				<h3>2.印刷した住所届に印鑑を押す。</h3>
				<h3>3.提出書類と住所届の画像をこのページの「画像のアップロード」または、</h3>
				<h3>住所変更申請フォームの「画像のアップロードはこちら⇀」リンクから提出する。</h3>
			</div>
			<div class="form-link">
				<a href="<%=request.getContextPath()%>/view/addressChangeForm.jsp">住所変更申請フォームに戻る</a>
			</div>
			<div class="form-link">
				<a href="<%=request.getContextPath()%>/view/RequestMenu.jsp">申請メニューに戻る</a>
			</div>
			<div class="form-link">
				<a href="<%=request.getContextPath()%>/view/">画像のアップロード</a>

			</div>
		</div>
	</div>
</body>
</html>