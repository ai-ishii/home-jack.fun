<!-- デザインを置いておくjsoです　石井 -->
<!-- 作成日：2025/08/21 -->
<!-- 更新日：2025/08/21 -->

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
</body>
</html>