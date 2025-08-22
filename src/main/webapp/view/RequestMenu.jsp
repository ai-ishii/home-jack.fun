<%--
機能：内容確定のお知らせとメニュー画面へのリンクが表示される

作成者：桑原岳

最終更新日：2025/08/22
 --%>



<%@page contentType="text/html; charset=UTF-8"%>

<html>
<head>
<title>申請メニュー | Home-Jack</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<script src="<%=request.getContextPath()%>/js/script.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<style>
#contents {
	width: 80%;
	margin-left: auto;
	margin-right: auto;
}

#link-title {
	text-align: center;
	margin-bottom: 30px;
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

.button-spacing {
	padding: 15px;
}
/* ボタン全体のデザイン */
.btn {
	width: 400px;
	display: inline-flex;
	align-items: center;
	background-color: #E67E22;
	color: white;
	padding: 15px 20px;
	border-radius: 50px;
	font-size: 18px;
	font-family: sans-serif;
	font-weight: bold;
	text-decoration: none;
	text-align: center;
	transition: all 0.3s;
}

.btn:hover {
	opacity: 0.8;
}

/* アイコンと文字の間のスペースを調整 */
.btn i {
	margin: 0 5px;
}

.btn span {
	margin: 0 10px;
}
/* 矢印を持つボタンのスタイル */
.btn-arrow {
	/* 矢印を配置するための基準位置（これが重要） */
	position: relative;
	/* 矢印の分だけ、右側の余白を少し増やす */
	padding-right: 40px;
}

/* 矢印本体の描画 */
.btn-arrow::after {
	content: '';
	/* 親要素(.btn-arrow)を基準に配置 */
	position: absolute;
	top: 50%;
	right: 20px;
	/* 描画した正方形を45度回転させて矢印に見せる */
	transform: translateY(-50%) rotate(45deg);
	/* 正方形を描画 */
	width: 6px;
	height: 6px;
	border-top: 2px solid #fff; /* 上と右の線だけ描画 */
	border-right: 2px solid #fff;
}

/* ホバー時のボタンのスタイル */
.btn-arrow:hover {
	background-color: #333; /* 背景色を黒っぽく */
	color: #fff; /* 文字色を白に */
}

/* ホバー時の矢印のスタイル */
.btn-arrow:hover::after {
	/* 矢印の色も白のまま（背景が変わるので色は変えなくてもOK） */
	border-color: #fff;
}

.menu-container {
	/* Flexboxを適用 */
	display: flex;
	/* 並ぶ方向を「縦」に指定 */
	flex-direction: column;
	/* ボタンを中央揃えにする（任意） */
	align-items: center;
	/* ボタンとボタンの間の隙間を指定 */
	gap: 20px;
}
</style>
</head>
<body>
	<div id="wrap">
		<%@ include file="../common/header.jsp"%>
		<div id="main" class="container">
			<div id="contents">
				<div id="link-title">
					<h1 id="link-line">申請メニュー</h1>
				</div>
				<div class="form-wrapper-container">
					<div class="menu-container">
						<div class="button-spacing">

							<a
								href="<%=request.getContextPath()%>/view/addressChangeForm.jsp"
								class="btn btn-arrow"> <i class="fa-solid fa-envelope"></i>
								<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30"
									viewBox="5 5 40 40">
  <defs>
    <style>
.a, .b {
	fill: none;
	stroke: #fff;
	stroke-width: 2px;
}

.a {
	stroke-linecap: round;
	stroke-linejoin: round;
}

.b {
	stroke-miterlimit: 10;
}
</style>
  </defs>
  <title>1020_hm_h</title>
  <g>
    <polygon class="a" points="38 39 38 21 24 9 10 21 10 39 38 39" />
    <g>
      <rect class="b" x="17.95" y="21.85" width="3.96" height="3.96" />
      <rect class="b" x="26.09" y="21.85" width="3.96" height="3.96" />
      <rect class="b" x="17.95" y="29.74" width="3.96" height="3.96" />
      <rect class="b" x="26.09" y="29.74" width="3.96" height="3.96" />
    </g>
  </g>
</svg> <span>住所変更申請</span> <i class="fa-solid fa-chevron-right"></i>
							</a>
						</div>
						<div class="button-spacing">
							<a href="#" class="btn btn-arrow"> <i
								class="fa-solid fa-envelope"></i>
								<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 48 48" width="30" height="30"><defs><style>.a,.b{fill:none;}.b{stroke:#fff;stroke-linecap:round;stroke-linejoin:round;stroke-width:2px;}</style></defs><title>454_ca_h</title><rect class="b" x="3" y="3" width="42" height="42" rx="4" ry="4"/><polyline class="b" points="3 36 18.09 20.91 27.57 30.39 33.88 24.08 45 35"/><circle class="b" cx="31" cy="14" r="4"/></svg>
								<span>画像アップロード(住所変更申請)</span>
								<i class="fa-solid fa-chevron-right"></i>
							</a>
						</div>
						<div class="button-spacing">
							<a href="<%=request.getContextPath()%>/view/nameChangeForm.jsp"
								class="btn btn-arrow"> <i class="fa-solid fa-envelope"></i>
								<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 640" width="30" height="30" style="fill: #fff; stroke: #fff;">
								<!--!Font Awesome Pro v7.0.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2025 Fonticons, Inc.-->
								<path d="M192 192C192 174.3 206.3 160 224 160C241.7 160 256 174.3 256 192L256 199.8C256 227.5 253.6 255.1 248.9 282.3L164.5 307.6C123.9 319.8 96.1 357.2 96.1 399.6L96.1 432L24.1 432C10.8 432 .1 442.7 .1 456C.1 469.3 10.8 480 24.1 480L96.6 480C100.8 516 131.4 544 168.6 544C194.6 544 218.6 530.1 231.5 507.5L245.4 483.2C272.2 436.2 291.9 385.5 303.8 332.7L398.2 304.4L385.7 341.9C382.4 351.7 384.1 362.4 390.1 370.7C396.1 379 405.7 384 416 384L544 384C561.7 384 576 369.7 576 352C576 334.3 561.7 320 544 320L460.4 320L478.4 266.1C482.2 254.8 479.3 242.3 471 233.7C462.7 225.1 450.3 221.9 438.8 225.3L316.4 262.1C318.8 241.4 320 220.7 320 199.8L320 192C320 139 277 96 224 96C171 96 128 139 128 192L128 224C128 241.7 142.3 256 160 256C177.7 256 192 241.7 192 224L192 192zM182.8 369L231.8 354.3C221.4 388.1 207.3 420.7 189.7 451.5L175.8 475.8C174.3 478.4 171.5 480.1 168.4 480.1C163.7 480.1 159.9 476.3 159.9 471.6L159.9 399.7C159.9 385.6 169.2 373.1 182.7 369zM616 480C629.3 480 640 469.3 640 456C640 442.7 629.3 432 616 432L323.1 432C316.6 448.3 309.4 464.3 301.5 480L616 480z"/></svg>
								<span>氏名変更申請</span> <i class="fa-solid fa-chevron-right"></i>
							</a>
						</div>
						<div class="button-spacing">
							<a href="<%=request.getContextPath()%>/licenseFormPrepare"
								class="btn btn-arrow"> <i class="fa-solid fa-envelope"></i>
								<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 48 48" width="30" height="30"><rect width="48" height="48" fill="none"/><line x1="18" y1="15" x2="27" y2="15" fill="none" stroke="#fff" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"/><line x1="18" y1="23" x2="27" y2="23" fill="none" stroke="#fff" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"/><line x1="18" y1="31" x2="21" y2="31" fill="none" stroke="#fff" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"/><path d="M28,5H12.3A4.16,4.16,0,0,0,8,9V39a4.16,4.16,0,0,0,4.3,4H30" fill="none" stroke="#fff" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"/><polyline points="34 36 38 44 42 36" fill="none" stroke="#fff" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"/><path d="M42,36V8a4,4,0,0,0-8,0V36" fill="none" stroke="#fff" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"/></svg>
								<span>資格申請</span> <i class="fa-solid fa-chevron-right"></i>
							</a>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>