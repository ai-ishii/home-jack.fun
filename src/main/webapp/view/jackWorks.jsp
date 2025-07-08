<%--
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