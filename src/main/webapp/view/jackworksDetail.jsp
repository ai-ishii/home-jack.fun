<%--
JackWorks詳細画面

作成者：青木美波
更新者：占部虎司郎

作成日 2025/07/18
最終更新日:2025/08/19
 --%>

<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.ArrayList,bean.Jackworks,util.MyFormat"%>

<%
//JackWorksの全情報が格納されたjack_listを受け取る
ArrayList<Jackworks> jackList = (ArrayList<Jackworks>) request.getAttribute("jack_list");

//戻るボタン後の画面遷移先を分けるためのcmdを受け取る
String cmd = (String) request.getAttribute("cmd");

if(cmd == null){
	cmd="";
}

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
@import url('https://fonts.googleapis.com/css2?family=Orbitron:wght@400..900&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Yomogi&display=swap');
@import url('https://fonts.googleapis.com/css2?family=DotGothic16&display=swap');


#contents {
	width: 90%;
	margin-right: auto;
	margin-left: auto;
}

/* タイトル部分 */
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

/* テーブル部分 */
#box-mar {
	margin: 0 auto;
	width:85%;
	border-collapse: collapse;
	background-color:#fff;
	text-align:left;
	white-space:pre-wrap;
}

table td{
padding:10px 10px 15px;
vertical-align:top;
 height:50px;
}

td[colspan="2"]{
width:90%;
padding-left:10px;
}


td.jack-left{
width:50%;
padding-left: 10px;
background-color:#fff;
border-right:dotted #ffd9ad;
}

td.jack-right{
width:50%;
padding-right:10px;
padding-left:10px;
background-color:#fff;
}

th{
text-align:left;
padding:10px 10px 10px;
}

tr.jack-double{
border-bottom:double #ffd9ad;
border-top:solid #ffb35c;
}

p.cap{
width:85%;
margin: 0 auto;
text-align:left;
font-size:16px;
}

.jack-return{
margin-top:2%;
height:40px;
text-align:center;
}

/* aタグの初期CSSのリセット */
.jackReset{
text-decoration: none;
color: #000;
}

/* 戻るボタンの大枠 */
.jackFlex{
display: flex;
align-items: center;
height: 30px;
width: 85%;
margin: 30px auto 0;
}

/* 矢印 */
.arrow{
display: inline-block;
vertical-align: middle;
transition: transform 0.5s ease;
overflow: visible; 					/* はみ出た内容を表示させる */
}

/* 矢印文字 */
.beaf{
height: 100%;
font-family: "Yomogi", cursive;
font-weight: 700;
font-size: 25px;
}

/* 矢印ホバー時の動き */
.jackReset:hover svg path {
transform: translateX(-10px);
stroke: #f9de95;
fill: #f9de95;
}

.mag {
margin-top: 3%;
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
			<h1 id="link-line">案件情報収集の詳細</h1>
		</div>
		
		<div class="mag"></div>
		
		<%
				for(int i=0; i < jackList.size(); i++){
					
					MyFormat myformat = new MyFormat();
					String date = myformat.breakDateFormat(jackList.get(i).getPointsGetDate());
				%>
				
				<strong>
				<p class="cap">名前：<%=jackList.get(i).getName()%></p>
				<p class="cap">取得日：<%= date %></p>
				</strong>

				<div style="margin-bottom:1%"></div>
				
				<!-- 入力フォーム -->
				<table id="box-mar">
				<tr class="jack-double">
					<th colspan="2" >案件名</th>
				</tr>
				<tr>
					<td colspan="2" class="jack-full"><div class="inner-content"><%=jackList.get(i).getProject()%></div></td>
				</tr>
				<tr class="jack-double">
					<th class="jack-left">作業時期</th>
					<th class="jack-right">作業場所</th>
				</tr>
				<tr>
					<td class="jack-left"><%=jackList.get(i).getWorkSeason()%></td>
					<td class="jack-right"><%=jackList.get(i).getWorkPlace()%></td>
				</tr>
				<tr class="jack-double">
					<th class="jack-left">単価</th>
					<th class="jack-right">精算</th>
				</tr>
				<tr>
					<td class="jack-left"><%=jackList.get(i).getPay()%></td>
					<td class="jack-right"><%=jackList.get(i).getPrice()%></td>
				</tr>
				<tr class="jack-double">
					<div style="width:90%">
					<th colspan="2">作業内容</th>
					</div>
				</tr>
				<tr>
					<td colspan="2"><%=jackList.get(i).getWorkContent()%></td>
				</tr>
				<tr class="jack-double">
					<th colspan="2">フェーズ</th>
				</tr>
				<tr>
					<td colspan="2"><%=jackList.get(i).getPhase()%></td>
				</tr>
				<tr class="jack-double">
					<th class="jack-left">開発言語</th>
					<th class="jack-right">必要スキル</th>
				</tr>
				<tr>
					<td class="jack-left"><%=jackList.get(i).getLanguage()%></td>
					<td class="jack-right"><%=jackList.get(i).getSkill()%></td>
				</tr>
				<tr class="jack-double">
					<th colspan="2" >必要人数</th>
				</tr>
				<tr>
				<td colspan="2"><%=jackList.get(i).getNeedPeople() %></td>
				</tr>
				<tr class="jack-double">
					<th class="jack-left">営業担当者</th>
					<th class="jack-right">連絡先</th>
				</tr>
				<tr>
					
					<td class="jack-left"><%=jackList.get(i).getSeller()%></td>
					<td class="jack-right"><%=jackList.get(i).getContact()%></td>
				</tr>
				<tr class="jack-double">
					<th colspan="2">その他</th>
				</tr>
				<tr>
					<td colspan="2"><%=jackList.get(i).getOther()%></td>
				</tr>
				
				<%} %>
			</table>
			
			<% if(cmd.equals("request")) {%>
			<div class="jackFlex">
				<a href="<%=request.getContextPath()%>/jackworksRequest" class="jackReset">
					<svg class="arrow" width="50"  height="20">
						<path d="M 0 10 L 50 10" stroke="#000" stroke-width="2" fill="none"/>
						<path d="M 0 10 L 25 0" stroke="#000" stroke-width="2" fill="none"/>
					</svg>
					<span class="beaf">PREV</span>
				</a>
			</div>
			
			<%}else{ %>
			<div class="jackFlex">
				<a href="<%=request.getContextPath()%>/monthJackworks" class="jackReset">
					<svg class="arrow" width="50"  height="20">
						<path d="M 0 10 L 50 10" stroke="#000" stroke-width="2" fill="none"/>
						<path d="M 0 10 L 25 0" stroke="#000" stroke-width="2" fill="none"/>
					</svg>
					<span class="beaf">PREV</span>
				</a>
			</div>
			<%} %>
			
		</div>
	</div>
</body>
</html>