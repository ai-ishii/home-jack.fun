<%--
機能：内容確定のお知らせとメニュー画面へのリンクが表示される

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
<script src="<%=request.getContextPath()%>/js/script.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<style>
.form-link {
	width: 80%;
	margin: auto;
	text-align: center;
	font-size:18px;
	padding: 20px;
}

}
</style>
</head>
<body>
	<div id="wrap">
		<%@ include file="../common/header.jsp"%>
		<div id="main" class="container">
			<h1 style="text-align: center;">内容を確定しました。</h1>
			<div class="form-link">
				<a href="<%=request.getContextPath()%>/view/addressChangeForm.jsp">住所変更申請フォームに戻る</a>
			</div>
			<div class="form-link">
				<a href="<%=request.getContextPath()%>/view/">申請メニューに戻る</a>
			</div>
		</div>
	</div>
</body>
</html>