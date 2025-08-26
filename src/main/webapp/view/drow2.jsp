<!-- デザインを置いておくjspです　石井 -->
<!-- 作成日：2025/08/21 -->
<!-- 更新日：2025/08/25 -->

<!-- システムが完成したらこのjspは消してください -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>おえかき いしい</title>
<style>
/* 登録ボタンの配置 */
#submitBtn {
	text-align: center;
	margin: 5px;
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
	padding: 0;
	-webkit-transition: all 0.3s;
	transition: all 0.3s;
	border-radius: 0;
	margin-bottom: 12px;
}

button.btn-border span {
	position: relative;
	display: block;
	padding: 0.6rem 1.8rem;
	color: #000;
	border: 2px solid #5f5f5f;
	border-radius: 0.5rem;
	background: #ffe0c1;
}

button.btn-border.save span {
	background: #fff;
}

/* ボタンの影の部分 */
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
	border: 2px solid #5f5f5f;
	border-top: 1px solid #5f5f5f;
	border-radius: 0 0 0.5rem 0.5rem;
	background-image: -webkit-repeating-linear-gradient(135deg, #000, #000 1px, transparent
		2px, transparent 5px);
	background-image: repeating-linear-gradient(-45deg, #5f5f5f, #5f5f5f 1px, transparent 2px,
		transparent 5px);
	background-size: 7px 7px;
	-webkit-backface-visibility: hidden;
	backface-visibility: hidden;
	background-color: #ffefe0;
}

/* 一時保存だけ色なしにしてます */
button.btn-border.save:before {
	background-color: whitesmoke;
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

a {
	text-decoration: none;
}

.register_box a {
	padding: 10px 20px;
	margin: 0 15px;
	width: 100px;
	height: 20px;
	border-radius: 20px;
	border: solid 2px orange;
	background-color: orange;
	text-align: center;
	color: #fff;
	letter-spacing: 0.1em;
}

.register_box a:hover {
	background-color: #fff;
	color: orange;
	border: solid 2px orange;
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
	<!-- 一時保存ボタン -->
	<div id="submitBtn">
		<button type="submit" class="btn btn-border save">
			<span>一時保存</span>
		</button>
	</div>
	<!-- 登録確定ボタン -->
	<div id="submitBtn">
		<button type="submit" class="btn btn-border">
			<span>登録</span>
		</button>
	</div>

	<!-- 新規登録・新規投稿ボタン（登録画面に飛ぶボタン） -->
	<div class="register_box">
		<a href="<%=request.getContextPath()%>/view/登録画面.jsp" class="box-link">新規投稿</a>
	</div>

	<!-- 詳細から一覧へ戻るボタン -->
	<a class="listButton" href="<%=request.getContextPath()%>/一覧">
		<svg class="memo" xmlns="http://www.w3.org/2000/svg"
			viewBox="0 0 640 640" style="width: 30px; height: 30px;">
				<!--!Font Awesome Free v7.0.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.-->
				<path
				d="M104 112C90.7 112 80 122.7 80 136L80 184C80 197.3 90.7 208 104 208L152 208C165.3 208 176 197.3 176 184L176 136C176 122.7 165.3 112 152 112L104 112zM256 128C238.3 128 224 142.3 224 160C224 177.7 238.3 192 256 192L544 192C561.7 192 576 177.7 576 160C576 142.3 561.7 128 544 128L256 128zM256 288C238.3 288 224 302.3 224 320C224 337.7 238.3 352 256 352L544 352C561.7 352 576 337.7 576 320C576 302.3 561.7 288 544 288L256 288zM256 448C238.3 448 224 462.3 224 480C224 497.7 238.3 512 256 512L544 512C561.7 512 576 497.7 576 480C576 462.3 561.7 448 544 448L256 448zM80 296L80 344C80 357.3 90.7 368 104 368L152 368C165.3 368 176 357.3 176 344L176 296C176 282.7 165.3 272 152 272L104 272C90.7 272 80 282.7 80 296zM104 432C90.7 432 80 442.7 80 456L80 504C80 517.3 90.7 528 104 528L152 528C165.3 528 176 517.3 176 504L176 456C176 442.7 165.3 432 152 432L104 432z" /></svg>
		<span class="listText">一覧へ</span>
	</a>
</body>
</html>