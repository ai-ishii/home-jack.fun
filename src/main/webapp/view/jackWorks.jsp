<%--
JackWorks画面
作成者：青木美波
作成日 2025/06/20
 --%>

<%@page contentType="text/html; charset=UTF-8"%>
<<<<<<< HEAD
<%@page import="java.text.SimpleDateFormat,java.util.Date,java.sql.Timestamp,java.util.ArrayList,bean.Jackworks,bean.Monthjack"%>

<%
//JackWorksの全情報が格納されたjack_listを受け取る
ArrayList<Jackworks> jackList = (ArrayList<Jackworks>) request.getAttribute("jack_list");
//今月のJackWorksの全情報が格納されたmjack_listを受け取る
Monthjack monthJack = (Monthjack) request.getAttribute("monthJack");
%>

<html>
	<head>
		<title>JackWorks</title>
		<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
		
		
<style type="text/css">
#link-title {
	text-align: center;
}

#link-collect {
	margin-top: 5%;
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

#contents {
	width: 90%;
	margin-right: auto;
	margin-left: auto;
}

#point-img {
	text-align: center;
}

#mag {
	margin-top: 6%;
}

.point-box {
	width: 80%;
	white-space: pre-wrap;
	word-wrap: break-word;
	overflow-wrap: break-word;
	word-break: break-all;
	margin: 0 auto;
}

.point-text {
	margin: 0 auto;
	width: 80%;
}

table {
	border-collapse: collapse;
	margin: 0 auto;
	padding: 0;
	width: 100%;
}

table tr {
	background-color: #fff;
	border-bottom: 2px solid #fff;
}

table tr:nth-child(even) {
	background-color: #eee;
}

table th, table td {
	padding: .35em 1em;
	++
}

table thead th {
	font-size: .85em;
	padding: 1em;
	width: 1em;
}

table thead tr {
	background-color: #fd6767;
	color: #fff;
}

table body th {
	text-align: left;
	font-size: .8em;
}

.txt {
	text-align: left;
	font-size: .75em;
}

.num {
	text-align: center;
}

.num-point {
	text-align: center;
	color: #FF7043;
	font-weight: bold;
}

.text-point {
	text-align: center;
	color: #FF7043;
	font-weight: bold;
}
</style>
		
	</head>
	<body>
	
	<%@include file = "../common/header.jsp" %>
	
	<div id="contents">

	<!-- タイトル部分 -->
	<div id="link-title">
	<h1 id="link-line">JackWorks</h1>
	</div>
	
	<!-- ポイント一覧 -->
	<div class="point-text">
	<p>ポイント一覧</p>
	<p><strong><%=monthJack.getTheme()%></strong></p>
	</div>
		
	<div id="point-img"><img src="<%=request.getContextPath()%>/img/<%=monthJack.getImage()%>" alt="ポイント一覧表" width="80%" ></div><br>
	
	<!-- ポイント一覧説明 -->
	<div class="point-box"><%=monthJack.getNote()%></div>
	
	<div id="mag"></div>

	<!-- ポイント取得者一覧 -->
	<table style="margin:0 auto">
		<tr>
			<td><p>ポイント取得者一覧</p></td>
		</tr>
	</table>
	
	<table style="width:100%">
        <thead style="margin:0 auto">
            <tr>
                <th scope="col">年月日</th>
                <th scope="col">社員No.</th>
                <th scope="col">氏名</th>
                <th scope="col">カテゴリ</th>
                <th scope="col">評価項目</th>
                <th scope="col">付与ポイント</th>
                <th scope="col">備考</th>
            </tr>
        </thead>

		<%
		for (int i = 0; i < jackList.size(); i++) {
				Jackworks jack = (Jackworks) jackList.get(i);
				String note = jack.getNote();
				Timestamp timestamp = jack.getPoints_get_date();
					//Date型への変換
					Date date = new Date(timestamp.getTime());
					// SimpleDateFormat をオブジェクト化し、任意のフォーマットを設定
					SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy年 MM月 dd日");
					if (note == null) {
						note = "";
					}
		%>
		<body>
			<tr>
				<td data-label="年月日" class="num"><%=dateFormat.format(date)%></td>
				<td data-label="社員No" class="num"><%=jack.getEmployee_number()%></td>
				<td data-label="氏名" class="text-point"><%=jack.getName()%></td>
				<td data-label="カテゴリ" class="text-point"><%=jack.getCategory()%></td>
				<td data-label="評価項目" class="text"><%=jack.getAssessment()%></td>
				<td data-label="付与ポイント" class="num-point"><%=jack.getPoint()%></td>
				<td data-label="備考" class="text"><%=note%></td>
			</tr>

			<% } %>
			
		</body>
	</table>
	</div>
=======
<%@page import="java.util.ArrayList,bean.jackworks"%>

<html>
	<head>
		<title>JackWorks</title>
		<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
		
		
<style type="text/css">
#link-title {
	text-align: center;
}

#link-collect {
	margin-top: 5%;
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

table {
  border-collapse: collapse;
  margin: 0 auto;
  padding: 0;
  width: 650px;
}
table tr {
  background-color: #fff;
  border-bottom: 2px solid #fff;
}
table tr:nth-child(even){
  background-color: #eee;
}
table th,
table td {
  padding: .35em 1em;
}
table thead th {
    font-size: .85em;
    padding: 1em;
}
table thead tr{
  background-color: #fd6767;
  color:#fff;
}
table tbody th {
  text-align: left;
  font-size: .8em;
}
.txt{
   text-align: left;
   font-size: .75em;
}
.price{
  text-align: right;
  color: #FF7043;
  font-weight: bold;
}

</style>
		
	</head>
	<body>

	<!-- タイトル部分 -->
	<div id="link-title">
	<h1 id="link-line">JackWorks</h1>
	</div>
	
	<!-- ポイント一覧 -->
	<p>ポイント一覧</p>
	<p>今月の重点テーマは、採用です！</p>
		
	<img src="../img/JackWorks.png" alt="ポイント一覧" width="80%">
	
	<!-- ポイント一覧説明 -->
	<p><strong>申請方法</strong></p>
	<p>・上司の承認が必要(口頭で可)。<br>
	上司は発生した内容をメールで本社(吉田)へ連絡。<br>
	※原則、当月発生分は当月内に連絡すること。月末に発生した場合は遅くとも翌営業日の午前中までに連絡すること。<br>
	・会社から指示するものについては、社長がテーマ、内容、取り組み期間、獲得ポイント数を発表。<br>
	・技術テーマや社内研修については、本人が上司承認(口頭)を得たのちに、上司から本社(吉田)へ連絡。<br>
	・必ず着手前に上司の承認を取ること。

	<p><strong>その他注意事項</strong></p>
	<p>・別途予算枠が決まっている活動は対象外とする。現在推進中の社内システム開発がそれに該当。
	・人事評価との二重評価を防止するため、人事評価項目に入っている内容は除外。
	・社外コンテストは、当社の業務に関係するものであること。
	・本来呈務の劇囲内である場合、評価対象外とする。
	例)受託開発部門の受託開発、総務部所属社員の請求業務、など、
	・ 評価項目の「案件情報収集」については、以下の項目を本人より収集し上司に連絡すること
	上司は本社(吉田)に連絡する際、本人より連絡があった以下の情報を転記すること(案件情報の収集がされていることを確認するため) 案件名、作時期、単価、精算、作場所、作内容、フェーズ、開党出語、必要スキル、必要人数、担当者、連絡先、その他
	</p>
	
	<!-- ポイント取得者一覧 --><%--
JackWorks画面
作成者：青木美波
作成日 2025/06/20
 --%>

<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.text.SimpleDateFormat,java.util.Date,java.sql.Timestamp,java.util.ArrayList,bean.Jackworks,bean.Monthjack"%>

<%
//JackWorksの全情報が格納されたjack_listを受け取る
ArrayList<Jackworks> jackList = (ArrayList<Jackworks>) request.getAttribute("jack_list");
//今月のJackWorksの全情報が格納されたmjack_listを受け取る
Monthjack monthJack = (Monthjack) request.getAttribute("monthJack");
%>

<html>
	<head>
		<title>JackWorks</title>
		<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
		
		
<style type="text/css">
#link-title {
	text-align: center;
}

#link-collect {
	margin-top: 5%;
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

#contents {
	width: 90%;
	margin-right: auto;
	margin-left: auto;
}

#point-img {
	text-align: center;
}

#mag {
	margin-top: 6%;
}

.point-box {
	width: 80%;
	white-space: pre-wrap;
	word-wrap: break-word;
	overflow-wrap: break-word;
	word-break: break-all;
	margin: 0 auto;
}

.point-text {
	margin: 0 auto;
	width: 80%;
}

table {
	border-collapse: collapse;
	margin: 0 auto;
	padding: 0;
	width: 100%;
}

table tr {
	background-color: #fff;
	border-bottom: 2px solid #fff;
}

table tr:nth-child(even) {
	background-color: #eee;
}

table th, table td {
	padding: .35em 1em;
	++
}

table thead th {
	font-size: .85em;
	padding: 1em;
	width: 1em;
}

table thead tr {
	background-color: #fd6767;
	color: #fff;
}

table body th {
	text-align: left;
	font-size: .8em;
}

.txt {
	text-align: left;
	font-size: .75em;
}

.num {
	text-align: center;
}

.num-point {
	text-align: center;
	color: #FF7043;
	font-weight: bold;
}

.text-point {
	text-align: center;
	color: #FF7043;
	font-weight: bold;
}
</style>
		
	</head>
	<body>
	
	<%@include file = "../common/header.jsp" %>
	
	<div id="contents">

	<!-- タイトル部分 -->
	<div id="link-title">
	<h1 id="link-line">JackWorks</h1>
	</div>
	
	<!-- ポイント一覧 -->
	<div class="point-text">
	<p>ポイント一覧</p>
	<p><strong><%=monthJack.getTheme()%></strong></p>
	</div>
		
	<div id="point-img"><img src="<%=request.getContextPath()%>/img/<%=monthJack.getImage()%>" alt="ポイント一覧表" width="80%" ></div><br>
	
	<!-- ポイント一覧説明 -->
	<div class="point-box"><%=monthJack.getNote()%></div>
	
	<div id="mag"></div>

	<!-- ポイント取得者一覧 -->
	<table style="margin:0 auto">
		<tr>
			<td><p>ポイント取得者一覧</p></td>
		</tr>
	</table>
	
	<table style="width:100%">
        <thead style="margin:0 auto">
            <tr>
                <th scope="col">年月日</th>
                <th scope="col">社員No.</th>
                <th scope="col">氏名</th>
                <th scope="col">カテゴリ</th>
                <th scope="col">評価項目</th>
                <th scope="col">付与ポイント</th>
                <th scope="col">備考</th>
            </tr>
        </thead>

		<%
		for (int i = 0; i < jackList.size(); i++) {
				Jackworks jack = (Jackworks) jackList.get(i);
				String note = jack.getNote();
				Timestamp timestamp = jack.getPoints_get_date();
					//Date型への変換
					Date date = new Date(timestamp.getTime());
					// SimpleDateFormat をオブジェクト化し、任意のフォーマットを設定
					SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy年 MM月 dd日");
					if (note == null) {
						note = "";
					}
		%>
		<body>
			<tr>
				<td data-label="年月日" class="num"><%=dateFormat.format(date)%></td>
				<td data-label="社員No" class="num"><%=jack.getEmployee_number()%></td>
				<td data-label="氏名" class="text-point"><%=jack.getName()%></td>
				<td data-label="カテゴリ" class="text-point"><%=jack.getCategory()%></td>
				<td data-label="評価項目" class="text"><%=jack.getAssessment()%></td>
				<td data-label="付与ポイント" class="num-point"><%=jack.getPoint()%></td>
				<td data-label="備考" class="text"><%=note%></td>
			</tr>

			<% } %>
			
		</body>
	</table>
	</div>
	</body>
</html>
	<table style="margin:0 auto">
		<tr>
			<td><p>ポイント取得者一覧</p></td>
		</tr>
	</table>
	<table>
        <thead style="margin:0 auto">
            <tr>
                <th scope="col">年月日</th>
                <th scope="col">社員No.</th>
                <th scope="col">氏名</th>
                <th scope="col">カテゴリ</th>
                <th scope="col">評価項目</th>
                <th scope="col">付与ポイント</th>
                <th scope="col">備考</th>
            </tr>
        </thead>
        <tbody>
            <tr>
               	<td data-label="価格" class="price">年月日</td>
                <td data-label="価格" class="price">社員No.</td>
                <td data-label="価格" class="price">氏名</td>
                <td data-label="価格" class="price">カテゴリ</td>
                <td data-label="価格" class="price">評価項目</td>
                <td data-label="価格" class="price">付与ポイント</td>
                <td data-label="価格" class="price">備考</td>
            </tr>
            <tr>
                <th>カスタムプラン</th>
                <td data-label="内容" class="txt">必要なものだけ揃えられるカスタムプラン</td>
                <td data-label="価格"class="price">¥4,000</td>
                <td data-label="内容" class="txt">必要なものだけ揃えられるカスタムプラン</td>
                <td data-label="価格"class="price">¥4,000</td>
                <td data-label="内容" class="txt">必要なものだけ揃えられるカスタムプラン</td>
                <td data-label="価格"class="price">¥4,000</td>
            </tr>
        </tbody>
    </table>  
>>>>>>> branch 'master' of https://github.com/ai-ishii/home-jack.fun.git
	</body>
</html>