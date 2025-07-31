<%--
今月のJackWorks登録画面
作成者：青木美波
作成日 2025/07/11
 --%>
 
 
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="bean.Monthjack"%>

<%
//今月のJackWorksの全情報が格納されたmonthJackを受け取る
Monthjack monthJack = (Monthjack) session.getAttribute("monthJack");
%>

<html>
<head>
<!-- タイトル -->
<title>JackWorks</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
<script src="<%=request.getContextPath()%>/js/script.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>

<!-- 以下CSS -->
<style>

#contents {
	width: 90%;
	margin-right: auto;
	margin-left: auto;
}

/* タイトル部分 */
#link-title {
	text-align: center;
}

#link-line {
	padding: 1rem 0;
	margin-bottom: 0.2rem;
	background-image: linear-gradient(90deg, #b2d5de 0 25%, #ddcfb3 25% 50%, #b3ddb4 50% 75%,
		#ddbab3 75%);
	background-repeat: no-repeat;
	background-size: 100% 0.3rem;
	background-position: bottom;
	color: #353535;
	font-weight: bold;
	font-size: 26px;
	text-align: center;
}

#box-mar {
	margin: 0 auto;
}

/* 登録ボタンの配置 */
#JackWorks-submit {
	text-align: center;
}

textarea {
	resize: none;
	width: 270px;
	height: 100px;
}

/* 米印の色 */
.warning {
	color: red;
}

/*  並べる方向を指定 */
.dis-flex {
	display: flex;
}

/* 登録ボタンのデザイン */
*, *:before, *:after {
	-webkit-box-sizing: inherit;
	box-sizing: inherit;
}

html {
	-webkit-box-sizing: border-box;
	box-sizing: border-box;
	font-size: 62.5%;
}

.btn, a.btn, button.btn {
	font-size: 1.4rem;
	font-weight: 700;
	line-height: 1.5;
	position: relative;
	display: inline-block;
	padding: 0.5rem 2rem;
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
	color: #212529;
	border-radius: 0.5rem;
	border: none;
}

button.btn-border {
	margin-bottom: 12px;
	padding: 0;
	-webkit-transition: all 0.3s;
	transition: all 0.3s;
	border-radius: 0;
}

button.btn-border span {
	position: relative;
	display: block;
	padding: 0.6rem 1.8rem;
	color: #000;
	border: 2px solid #000;
	border-radius: 0.5rem;
	background: #fff;
}

button.btn-border:before {
	position: absolute;
	bottom: -8px;
	left: 0;
	display: block;
	width: 100%;
	height: 14px;
	content: "";
	-webkit-transition: all 0.3s;
	transition: all 0.3s;
	border: 2px solid #000;
	border-top: 1px solid #000;
	border-radius: 0 0 0.5rem 0.5rem;
	background-image: -webkit-repeating-linear-gradient(135deg, #000, #000 1px, transparent
		2px, transparent 5px);
	background-image: repeating-linear-gradient(-45deg, #000, #000 1px, transparent 2px,
		transparent 5px);
	background-size: 7px 7px;
	-webkit-backface-visibility: hidden;
	backface-visibility: hidden;
}

button.btn-border:hover {
	-webkit-transform: translate(0, 3px);
	transform: translate(0, 3px);
}

button.btn-border:hover:before {
	bottom: -5px;
}

button.btn-border:active {
	-webkit-transform: translate(0, 7px);
	transform: translate(0, 7px);
}

button.btn-border:active:before {
	bottom: -1px;
}

</style>

<body>
	<div id="wrap">
		<!-- ヘッダー部分 -->
		<%@ include file="../common/header.jsp"%>

		<!-- メイン部分 -->
		<div id="main" class="container">
		
		<div id="contents">

		<!-- タイトル部分 -->
		<div id="link-title">
			<h1 id="link-line">今月のJackWorks内容更新</h1>
		</div>
		
		<!-- 入力された今月のJackWorksのデータを送るフォーム -->
		<form action="<%=request.getContextPath()%>/monthJackworks" enctype="multipart/form-data" method="post">

			<!-- 入力フォーム -->
			<table id="box-mar">
				<tr>
					<td style="display: flex">画像
						<div class="warning">*</div>
					</td>
				</tr>
				<td><input type="file" name="image" size="35" value="" required></td>
				<tr>
					<td style="display: flex">今月のテーマ
						<div class="warning">*</div>
					</td>
				</tr>
				<td><input type="text" name="theme" value="<%=monthJack.getTheme()%>" size="35" required></td>
				<tr>
					<td style="display: flex">備考</td>
				</tr>
				<td><textarea name="note" rows="" cols="" ><%=monthJack.getNote()%></textarea></td>
			</table>
			
			<!-- 登録ボタン -->
			<div id="JackWorks-submit">
				<button type="submit" class="btn btn-border">
					<span>更新</span>
				</button>
			</div>
		</div>
		</form>
		</div>
	</div>
</body>
</html>