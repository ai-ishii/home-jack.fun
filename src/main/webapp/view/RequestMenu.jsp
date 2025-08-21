<%--
機能：内容確定のお知らせとメニュー画面へのリンクが表示される

作成者：桑原岳

最終更新日：2025/08/20
 --%>



<%@page contentType="text/html; charset=UTF-8"%>

<html>
<head>
<title>申請メニュー</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<script src="<%=request.getContextPath()%>/js/script.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<style>
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
	padding: 15px 30px;
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
			<div class="form-wrapper-container">
				<div class="menu-container">
					<h1 style="text-align: center">-申請メニュー-</h1>
					<div class="button-spacing">

						<a href="<%= request.getContextPath() %>/view/addressChangeForm.jsp" class="btn btn-arrow"> <i
							class="fa-solid fa-envelope"></i> <span>住所変更申請</span> <i
							class="fa-solid fa-chevron-right"></i>
						</a>
					</div>
					<div class="button-spacing">
						<a href="#" class="btn btn-arrow"> <i
							class="fa-solid fa-envelope"></i> <span>画像アップロード(住所変更申請)</span> <i
							class="fa-solid fa-chevron-right"></i>
						</a>
					</div>
					<div class="button-spacing">
						<a href="<%= request.getContextPath() %>/view/nameChangeForm.jsp" class="btn btn-arrow"> <i
							class="fa-solid fa-envelope"></i> <span>氏名変更申請</span> <i
							class="fa-solid fa-chevron-right"></i>
						</a>
					</div>
					<div class="button-spacing">
						<a href="<%= request.getContextPath() %>/licenseFormPrepare" class="btn btn-arrow"> <i
							class="fa-solid fa-envelope"></i> <span>資格申請</span> <i
							class="fa-solid fa-chevron-right"></i>
						</a>
					</div>

				</div>
			</div>
		</div>
	</div>

</body>
</html>