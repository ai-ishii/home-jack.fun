<%--
今月のJackWorks登録画面
作成者：青木美波
更新者：占部虎司郎

作成日 2025/07/11
最終更新日 2025/08/21
 --%>
 
 
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="bean.Monthjack"%>

<%
//今月のJackWorksの全情報が格納されたmonthJackを受け取る
Monthjack monthJack = (Monthjack) session.getAttribute("monthJack");

//戻るボタン後の画面遷移先を分けるためのcmdを受け取る
String cmd = (String) request.getAttribute("cmd");

if(cmd == null){
	cmd="";
}
%>

<html>
<head>
<!-- タイトル -->
<title>JackWorksテーマ更新 | Home-Jack</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
<script src="<%=request.getContextPath()%>/js/error.js"></script>
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
	padding: 10px 0;
	margin-bottom: 2px;
	background-image: linear-gradient(90deg, #b2d5de 0 25%, #ddcfb3 25% 50%, #b3ddb4 50% 75%,
		#ddbab3 75%);
	background-repeat: no-repeat;
	background-size: 100% 3px;
	background-position: bottom;
	color: #353535;
	font-weight: bold;
	font-size: 26px;
	text-align: center;
}

.box-mar {
width: 60%;
margin: 0 auto;
}

/* 登録ボタンの配置 */
#JackWorks-submit {
	text-align: center;
	margin-top: 20px;
}

/*  */
.monthArea {
	resize: none;
	width: 100%;
	height: 200px;
}

/* テキストボックス */
.monthBox{
width: 100%;
height: 30px;
}

/* セルサイズ */
.textCell{
width: 100%;
height: 100%;
}

/* 米印の色 */
.warning {
	color: red;
}

/*  並べる方向を指定 */
.dis-flex {
	display: flex;
}

.btn, a.btn, button.btn {
-webkit-box-sizing: border-box;
box-sizing: border-box;
	font-size: 14px;
	font-weight: 700;
	line-height: 1.5;
	position: relative;
	display: inline-block;
	padding: 5px 20px;
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
	letter-spacing: 1.4px;
	color: #212529;
	border-radius: 5px;
	border: none;
}

button.btn-border {
-webkit-box-sizing: border-box;
box-sizing: border-box;
	margin-bottom: 12px;
	padding: 0;
	-webkit-transition: all 0.3s;
	transition: all 0.3s;
	border-radius: 0;
}

button.btn-border span.btnUp {
-webkit-box-sizing: border-box;
box-sizing: border-box;
	position: relative;
	display: block;
	padding: 6px 18px;
	color: #000;
	border: 2px solid #000;
	border-radius: 5px;
	background: #fff;
}

button.btn-border:before {
	-webkit-box-sizing: border-box;
	box-sizing: border-box;
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
	-webkit-box-sizing: border-box;
	box-sizing: border-box;
	-webkit-transform: translate(0, 3px);
	transform: translate(0, 3px);
}

button.btn-border:hover:before {
	-webkit-box-sizing: border-box;
	box-sizing: border-box;
	bottom: -5px;
}

button.btn-border:active {
	-webkit-box-sizing: border-box;
	box-sizing: border-box;
	-webkit-transform: translate(0, 7px);
	transform: translate(0, 7px);
}

button.btn-border:active:before {
-webkit-box-sizing: border-box;
box-sizing: border-box;
	bottom: -1px;
}

/* ただの色付き小見出し */
.yorushika{
font-size: 22px;
color: #e89b17;
margin-left: 10px;
margin-right: auto;
margin-bottom: 2px;
}

/* 小見出し用の縦線 */
.yorushikaStripe{
display: flex;
justify-content: center;   /* 水平方向の中央揃え */
align-items: center;
border-left: 5px solid #ff8b4d;
}

/* 小見出し */
.formSub{
font-size: 21px;
}

.formText{
font-size: 17px;
}

.tdMag{
padding-bottom: 5px;
}

/* テーブル間隔開ける */
.textPadd{
padding-bottom: 15px;
}

/* ボタン位置 */
.magButton{
height: 90px;
padding-bottom: 10px;
}

/* aタグの初期CSSのリセット */
.jackReset{
text-decoration: none;
color: #000;
}

/* 中央揃えのためのダミー */
.jackDummy{
width: 150px;
}

/* 戻るボタンの大枠 */
.jackFlex{
display: flex;
justify-content: space-between;
align-items: center;
height: 30px;
}

/* 矢印の枠 */
.yoruArrow{
width: 150px;
}

/* 矢印 */
.arrow{
display: inline-block;
vertical-align: middle;
transition: transform 0.5s ease;
overflow: visible; 				/* はみ出た内容を表示させる */
}

/* 矢印文字 */
.beaf{
height: 100%;
font-family: "Yomogi", cursive;
font-size: 25px;
}

/* 矢印ホバー時の動き */
.jackReset:hover svg path {
transform: translateX(-10px);
stroke: #f9de95;
fill: #f9de95;
}

.margTop{
margin-top: 30px;
}

/* 以下画像変更ボタンのCSS */
/* 画像変更ボタンの大枠 */
.photoFrame{
display: flex;
justify-content: flex-end;
width: 200px;
height: 50px;
margin-left: auto;
}

/* 画像変更ボタン */
.photoButton{
display: inline-block;
display: flex;         /* 子要素をFlexboxで配置 */
border-radius: 5px;
text-decoration: none;			/* 下線を消す */
cursor: pointer; 				/* マウスカーソルをポインターにする */
border: 8px solid #e19dbe;
height: 100%;
align-items: center;
}

/* 画像アイコンボックス */
.photoBox{
display: flex;             /* Flexboxを有効にする */
justify-content: center;   /* 水平方向の中央揃え */
align-items: center;       /* 垂直方向の中央揃え */
border: 3px solid #fff;
background-color: #e19dbe;
height: 35px;
border-radius: 3px;
padding: 5px 5px;
margin: 0;
}

/* 画像アイコン */
.photoIcon{
display: inline-block;
vertical-align: middle;
stroke: #fff;
fill: #fff;
transition: .5s;
}

/* 画像変更の文字 */
.photoText{
display: flex;             /* Flexboxを有効にする */
justify-content: center;   /* 水平方向の中央揃え */
align-items: center;       /* 垂直方向の中央揃え */
background-color: #e19dbe;
height: 35px;
font-size:25px;
border: 3px solid #fff;
border-radius: 3px;
padding: 5px 5px;
margin: 0;
color: #fff;
transition: .5s;
}

/* 画像変更ボタンホバーアニメ */
.photoFrame:hover .photoIcon{
transform: rotateX(360deg);
}

/* ボタンクリック時のアニメ */
.photoFrame:active .photoButton{
	background-position: center center;
	background-size: 100% 100%;
	-webkit-animation: pulse 2s;
	animation: ripple 0.4s;
	color: #fff;
}

/* 広がる破門アニメ */
@keyframes ripple {
  0% {box-shadow: 0 0 0 0 #e47cae}
  70% {box-shadow: 0 0 0 10px rgb(228 124 174 / 0%);}
  100% {box-shadow: 0 0 0 0 rgb(228 124 174 / 0%);}
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
		<form action="<%=request.getContextPath()%>/monthJackworks" enctype="multipart/form-data" method="post" class="error-form">

			<!-- 入力フォーム -->
			<table class="box-mar">
			<%if(!cmd.equals("change")){ %>
				<tr>
					<td class="magButton">
						<div class="photoFrame">
							<a class="photoButton" href="<%=request.getContextPath()%>/monthJackworks?cmd=change">
								<div class="photoBox">
									<svg xmlns="http://www.w3.org/2000/svg" x="2px" y="2px" viewBox="1 1 45 45" width="35"  height="35" class="photoIcon">
									<defs>
										<style>.a,.b{fill:none;}.b{stroke-linecap:round;stroke-linejoin:round;stroke-width:2px;}
										</style>
									</defs>
									<title>454_ca_h</title>
									<rect class="a" width="48" height="48"/>
									<rect class="b" x="3" y="3" width="42" height="42" rx="4" ry="4"/>
									<polyline class="b" points="3 36 18.09 20.91 27.57 30.39 33.88 24.08 45 35"/>
									<circle class="b" cx="31" cy="14" r="4"/>
									</svg>
								</div>
								<div class="photoText">画像変更</div>
							</a>
						</div>
						<input type="hidden" name="image" value="<%=monthJack.getImage()%>">
					</td>
				</tr>
			<%}else{ %>
				<tr>
					<td style="display: flex" class="formSub">画像</td>
				</tr>
				<td><input type="file" accept=".png, .jpg, .jpeg, .gif" name="image" size="35" value="" class="error-file"></td>
				<tr>
				<td>画像サイズ最大3MB / 対応ファイルはJPG,JPEG,PNG,GIF</td>
				</tr>
			<%} %>
				<tr>
					<td style="display: flex;" class="tdMag">
						<div class="yorushikaStripe">
							<div class="yorushika">今月のテーマ</div>
						</div>
						<div class="warning">*</div>
					</td>
				</tr>
				<tr>
				<td class="textPadd"><input type="text" name="theme" value="<%=monthJack.getTheme()%>" class="required monthBox formText"></td>
				</tr>
				<tr>
					<td style="display: flex" class="tdMag">
						<div class="yorushikaStripe">
							<div class="yorushika">備考</div>
						</div>
					</td>
				</tr>
				<tr>
				<td class="textPadd"><textarea class="monthArea formText" name="note"><%=monthJack.getNote()%></textarea></td>
				</tr>
			</table>

			<!-- 登録ボタン -->
			<div class="box-mar">
			<div class="margTop"/>
			<div class="jackFlex">
					<div class="yoruArrow">
					<a href="<%=request.getContextPath()%>/monthJackworks" class="jackReset">
					<svg class="arrow" width="50"  height="20">
						<path d="M 0 10 L 50 10" stroke="#000" stroke-width="2" fill="none"/>
						<path d="M 0 10 L 25 0" stroke="#000" stroke-width="2" fill="none"/>
					</svg>
					<span class="beaf">PREV</span>
					</a>
					</div>
					<div>
					<button type="submit" class="btn btn-border">
					<span class="btnUp">更新</span>
					</button>
					</div>
					<div class="jackDummy"></div>
			</div>
		</div>
		</form>
		</div>
	</div>
</body>
</html>