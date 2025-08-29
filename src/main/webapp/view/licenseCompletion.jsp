<%--
機能：内容確定のお知らせとメニュー画面へのリンクが表示される

作成者：桑原岳

最終更新日：2025/08/29
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

.links {
	width: 100%;
	height: 100px;
}

.prev, .next {
	width: 30%;
}

.next {
	text-align: right;
}

.list {
	width: 40%;
	text-align: center;
	vertical-align: bottom;
}

/* アイコン */
.memo {
	display: inline-block;
	vertical-align: middle;
	stroke: #fff;
	fill: #fff;
}

/* ボタンの文字 */
.listText {
	vertical-align: middle;
	font-family: "Kosugi Maru", sans-serif;
	font-size: 21px;
	font-weight: 300;
	color: #fff;
}

.listButton {
	display: inline-block;
	padding: 8px 16px;
	background-color: #fdd35c;
	border: 3px solid #fdd35c;
	border-radius: 5px;
	text-decoration: none;
	text-align: center;
	cursor: pointer;
}

.listButton:hover {
	background-color: #fff;
	border: 3px solid #fdd35c;
}

.listButton:hover .memo {
	stroke: #fdd35c;
	fill: #fdd35c;
}

.listButton:hover .listText {
	color: #fdd35c;
}
</style>
</head>
<body>
	<div id="wrap">
		<%@ include file="../common/header.jsp"%>
		<br> <br> <br> <br>
		<div id="main" class="container">
			<h1 style="text-align: center;">内容を確定しました。</h1>
		
		<br> <br> <br>
		<table class="links">
			<div class="form-link">
				<!-- 詳細から一覧へ戻るボタン -->
				<a class="listButton"
					href="<%=request.getContextPath()%>/view/RequestMenu.jsp"> <svg
						class="memo" xmlns="http://www.w3.org/2000/svg"
						viewBox="0 0 640 640"
						style="width: 30px; height: 30px; stroke: #fff; fill: #fff;">
				<!--!Font Awesome Free v7.0.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.-->
				<path
							d="M104 112C90.7 112 80 122.7 80 136L80 184C80 197.3 90.7 208 104 208L152 208C165.3 208 176 197.3 176 184L176 136C176 122.7 165.3 112 152 112L104 112zM256 128C238.3 128 224 142.3 224 160C224 177.7 238.3 192 256 192L544 192C561.7 192 576 177.7 576 160C576 142.3 561.7 128 544 128L256 128zM256 288C238.3 288 224 302.3 224 320C224 337.7 238.3 352 256 352L544 352C561.7 352 576 337.7 576 320C576 302.3 561.7 288 544 288L256 288zM256 448C238.3 448 224 462.3 224 480C224 497.7 238.3 512 256 512L544 512C561.7 512 576 497.7 576 480C576 462.3 561.7 448 544 448L256 448zM80 296L80 344C80 357.3 90.7 368 104 368L152 368C165.3 368 176 357.3 176 344L176 296C176 282.7 165.3 272 152 272L104 272C90.7 272 80 282.7 80 296zM104 432C90.7 432 80 442.7 80 456L80 504C80 517.3 90.7 528 104 528L152 528C165.3 528 176 517.3 176 504L176 456C176 442.7 165.3 432 152 432L104 432z" /></svg>
					<span class="listText">一覧へ</span>
				</a>
			</div>
		</table>
		</div>
	</div>
</body>
</html>