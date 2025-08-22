<%--
共有資料画面
作成者：青木美波
作成日 2025/08/22
 --%>

<%@page contentType="text/html; charset=UTF-8"%>

<html>
<head>
<!-- タイトル -->
<title>共有資料 | Home-Jack</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
<script src="<%=request.getContextPath()%>/js/script.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>

<style>
#link-title {
	text-align: center;
}

#link-collect {
	margin-top: 5%;
}

/*各リンクのテーブル（table）*/
.linkTable {
	font-size: large;
	margin: 0 auto;
	border-collapse: collapse;
	box-shadow: 0 -1px 3px rgba(0, 160, 255, 0.1);
}

.linkTable td {
	padding: 16px 48px;
	width: 200px;
	box-shadow: 0 4px 6px rgba(0, 160, 255, 0.1);
}

#contents{
width:90%;
margin-right: auto;
margin-left : auto;
}

.link {
	text-decoration: none;
	font-weight: bold;
	position: relative;
	display: inline-block;
	transition: .3s;
	color: #6495ed;
}

.link::after {
	position: absolute;
	bottom: 0;
	left: 0;
	content: '';
	width: 0;
	height: 1px; /*下線の太さ*/
	background-color: #f89174; /*下線の色*/
	transition: .3s;
}

.link:hover::after {
	width: 100%;
}

.link:hover {
	color: #f89174; /*ホバー時の文字色*/
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
	<h1 id="link-line">共有資料</h1>
	</div>
	
	<!-- 各リンク -->
	<div id="link-collect">
	<table class="linkTable">
		<tr>
			<td><a class="link" href="https://drive.google.com/drive/folders/1Lz8DsC7tmC5jVZ_i_Tvm3MYesODFDZ6W" target="_blank">日本生命説明会</a></td>
			<td><a class="link" href="https://drive.google.com/drive/folders/1lcmwm18TR6kITth33m16P47YNFTHdiSa" target="_blank">新Home-Jack資料</a></td>
			<td><a class="link" href="https://drive.google.com/drive/folders/1qQk4hF8c4Fnz6uCYfhQDoW86Aa5q3EKN" target="_blank">健康経営</a></td>
			<td><a class="link" href="https://drive.google.com/drive/folders/1RIE5KtW4w7GH-UQa_nkpTtNeY5tjNLch" target="_blank">互助会</a></td>
		</tr>
		<tr>
			<td><a class="link" href="https://drive.google.com/drive/folders/1Ft_x3mx4C7beeJxozjVZNCl-9ixoIbNN" target="_blank">DC制度説明</a></td>
			<td><a class="link" href="https://drive.google.com/drive/folders/1Us2TacaZmZA-nar51B5C0EMimBanS3iz" target="_blank">各種申請書</a></td>
			<td><a class="link" href="https://drive.google.com/drive/folders/1RcFIYOHT2rFQn4BpL2_teOIfO0BOmTrl" target="_blank">組織図</a></td>
			<td><a class="link" href="https://drive.google.com/drive/folders/15MoJzybWRnOI4J-1VLn-AxR-hz9cc8rf" target="_blank">社内規程</a></td>
		</tr>
		<tr>
			<td><a class="link" href="https://drive.google.com/drive/folders/16REESCRp1v5lp8o-G0lsIhdret-YQ2x-" target="_blank">年度進発会資料</a></td>
			<td><a class="link" href="https://drive.google.com/drive/folders/1swktISrLpPGgWQLu2VAnzKviSqEEhokN" target="_blank">営業資料</a></td>
			<td><a class="link" href="https://drive.google.com/drive/folders/1Xi_VeobYoTEi0RoYLRUlkQfabzgi-1sh" target="_blank">各種勉強会資料</a></td>
			<td><a class="link" href="https://drive.google.com/drive/folders/19zahGmJ_YfRKASu9XMqjvI-dBc2aNT-L" target="_blank">勤怠アップロード手順</a></td>
		</tr>
		<tr>
			<td><a class="link" href="https://drive.google.com/drive/folders/1wDb0vGE3PC1_hDwERF5fCO48L7vAMaEW" target="_blank">メーリングリスト</a></td>
			<td><a class="link" href="https://drive.google.com/drive/folders/1RPV2HuXHtpwR0KzgTibaPMJDs_WXN-ug" target="_blank">デザイン</a></td>
			<td><a class="link" href="https://drive.google.com/drive/folders/1U47lkn-yRhScrWLjscj8IdKQheoyQk6Z" target="_blank">サークル</a></td>
			<td><a class="link" href="https://drive.google.com/drive/folders/1Y3dmXpmDf2eMimcOJOASdk5r3Ar0ND81" target="_blank">その他</a></td>
		</tr>
	</table>
	</div>		
	</div>
	</div>
	</body>
</html>