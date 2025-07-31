<%--
JackWorks詳細画面
作成者：青木美波
作成日 2025/07/18
 --%>

<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.ArrayList,bean.Jackworks,util.MyFormat"%>

<%
//JackWorksの全情報が格納されたjack_listを受け取る
ArrayList<Jackworks> jackList = (ArrayList<Jackworks>) request.getAttribute("jack_list");

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
border-right:dotted;
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
border-bottom:double;
border-top:solid;
}

p.cap{
width:85%;
margin: 0 auto;
text-align:left;
font-size:16px;
}

/* 削除ボタンのCSS */
.btn, a.btn{
	font-size: 15px;
	font-weight: 700;
	line-height: 1.5;
	display: inline-block;
	padding: 2px 15px;
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
	border-radius: 3px;
	border:2px solid #484a60;
}

a.btn--delete {
	position:relative;
	color: #000;
	background-color: #e5e7ff;
	border-bottom: 5px solid #727592;
	transform: translateY(0);
}

a.btn--delete:hover {
	transform: translateY(3px);
	color: #000;
	background: #706caa;
	border-bottom: 2px solid #4a488e;
}

.jack-return{
margin-top:2%;
height:40px;
text-align:center;
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
		</div><br>
		<%
				for(int i=0; i < jackList.size(); i++){
					
					MyFormat myformat = new MyFormat();
					String date = myformat.breakDateFormat(jackList.get(i).getPointsGetDate());
				%>
				
				<div><strong>
				<p class="cap">名前：<%=jackList.get(i).getName()%></p>
				<p class="cap">取得日：<%= date %></p>
				</strong></div>

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
			<div class="jack-return">
				<a href="<%=request.getContextPath()%>/jackworksRequest"  class="btn btn--delete">戻る</a>
			</div>
			
			<%}else{ %>
			<div class="jack-return">
				<a href="<%=request.getContextPath()%>/monthJackworks"  class="btn btn--delete">戻る</a>
			</div>
			<%} %>
			
		</div>
	</div>
</body>
</html>