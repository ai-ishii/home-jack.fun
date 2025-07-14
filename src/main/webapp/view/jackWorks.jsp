<%--
JackWorks画面
作成者：青木美波
作成日 2025/07/11
 --%>

<%@page contentType="text/html; charset=UTF-8"%>
<%@pageimport="java.util.ArrayList,bean.Jackworks,bean.Monthjack,util.MyFormat"%>

<%
//JackWorksの全情報が格納されたjack_listを受け取る
ArrayList<Jackworks> jackList = (ArrayList<Jackworks>) request.getAttribute("jack_list");
//今月のJackWorksの全情報が格納されたmjack_listを受け取る
Monthjack monthJack = (Monthjack) request.getAttribute("monthJack");
%>


<html>
<head>
<!-- タイトル -->
<title>JackWorks</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
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
	height: 70px
}

table tr:nth-child(even) {
	background-color: #eee;
}

table th, table td {
	padding: .20em 1em;
}

table thead th {
	font-size: .85em;
	padding: 1em;
	width: 1em;
}

table thead tr {
	background-color: #f8b862;
	color: #fff;
}

.txt {
	text-align: left;
	font-size: .75em;
}

.num {
	text-align: center;
	white-space: pre-wrap;
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

<%-- 削除ボタン --%>
html {
	-webkit-box-sizing: border-box;
	box-sizing: border-box;
	font-size: 62.5%;
}

.btn, a.btn, button.btn {
	font-size: 1.6rem;
	font-weight: 700;
	line-height: 1.5;
	position: relative;
	display: inline-block;
	padding: 0.5rem 2rem;
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
	border-radius: 8.5rem;
}

a.btn--delete {
	color: #000;
	background-color: #bbc8e6;
	border-bottom: 5px solid #8491c3;
}

a.btn--delete:hover {
	margin-top: 3px;
	color: #000;
	background: #706caa;
	border-bottom: 2px solid #4a488e;
}


<%-- 登録ボタン --%>
a.btn--insert {
	color: #000;
	background-color: #fef263;
	border-bottom: 5px solid #e6b422;
}

a.btn--insert:hover {
	margin-top: 3px;
	color: #000;
	background: #e9bc00;
	border-bottom: 2px solid #72640c;
}

ul {
	padding-left: 0;
}

li {
	list-style: none;
}

.search-form {
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 250px; /* 任意の幅に調整してください */
    overflow: hidden;
    border-radius: 25px;
    background-color: #feffe0;
}

.search-form input {
    height: 45px;
    padding: 5px 15px;
    border: none;
    box-sizing: border-box;
    background-color: #feffe0;
    font-size: 1em;
    outline: none;
}

.search-form input::placeholder {
    color: #d9811c;
}

.search-form button {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 50px;
    height: 45px;
    border: none;
    background-color: transparent;
    cursor: pointer;
}

.search-form button::after {
    width: 20px;
    height: 20px;
    background-image: url('data:image/svg+xml;charset=utf8,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%2024%2024%22%3E%20%3Cpath%20d%3D%22M23.7%2020.8%2019%2016.1c-.2-.2-.5-.3-.8-.3h-.8c1.3-1.7%202-3.7%202-6C19.5%204.4%2015.1%200%209.7%200S0%204.4%200%209.7s4.4%209.7%209.7%209.7c2.3%200%204.3-.8%206-2v.8c0%20.3.1.6.3.8l4.7%204.7c.4.4%201.2.4%201.6%200l1.3-1.3c.5-.5.5-1.2.1-1.6zm-14-5.1c-3.3%200-6-2.7-6-6s2.7-6%206-6%206%202.7%206%206-2.6%206-6%206z%22%20fill%3D%22%23d9811c%22%3E%3C%2Fpath%3E%20%3C%2Fsvg%3E');
    background-repeat: no-repeat;
    content: '';
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
					<h1 id="link-line">JackWorks</h1>
				</div>

				<!-- ポイント一覧 -->
				<div class="point-text">
					<ul>
						<li>ポイント一覧</li>
					</ul>
					<li><strong><%=monthJack.getTheme()%></strong></li>
					<li><a
						href="<%=request.getContextPath()%>/view/monthJackWorks.jsp"
						class="btn btn--insert">新規登録</a></li>
				</div>

				<div id="point-img">
					<img
						src="<%=request.getContextPath()%>/img/<%=monthJack.getImage()%>"
						alt="ポイント一覧表" width="80%">
				</div>
				<br>

				<!-- ポイント一覧説明 -->
				<div class="point-box"><%=monthJack.getNote()%></div>

				<div id="mag"></div>

				<p>ポイント取得者一覧</p>
				
				<!-- ポイント取得者一覧 -->
				<table style="margin: 0 auto">
					<tr>
						<td><form action="<%=request.getContextPath()%>/searchJackWorks" class="search-form">
							<label>
							<input type="text"  name="name" placeholder="キーワードを入力">
							</label>
							<button type="submit" aria-label="検索"></button>
						</td>
						<td style="text-align: right"><a
							href="<%=request.getContextPath()%>/view/registerJackWorks.jsp"
							class="btn btn--insert">新規登録</a></td>
					</tr>
				</table>

				<table style="width: 100%">
					<thead style="margin: 0 auto">
						<tr>
							<th scope="col">年月日</th>
							<th scope="col">社員No.</th>
							<th scope="col">氏名</th>
							<th scope="col">カテゴリ</th>
							<th scope="col">評価項目</th>
							<th scope="col">付与ポイント</th>
							<th scope="col">備考</th>
							<th scope="col"></th>
						</tr>
					</thead>

					<%
					for (int i = 0; i < jackList.size(); i++) {
						Jackworks jack = (Jackworks) jackList.get(i);
						String note = jack.getNote();
						MyFormat myformat = new MyFormat();
						String date = myformat.BreakDateFormat(jack.getPointsGetDate());
						
						if (note == null) {
							note = "";
						}
					%>
					<tr>
						<td data-label="年月日" class="num" name="date"><%= date %></td>
						<td data-label="社員No" class="num" name="employeeNumber"><%=jack.getEmployeeNumber()%></td>
						<td data-label="氏名" class="text-point" name="name"><%=jack.getName()%></td>
						<td data-label="カテゴリ" class="text-point" name="category"><%=jack.getCategory()%></td>
						<td data-label="評価項目" class="text" name="assessment"><%=jack.getAssessment()%></td>
						<td data-label="付与ポイント" class="num-point" name="point"><%=jack.getPoint()%></td>
						<td data-label="備考" class="text" name="note"><%=note%></td>
						<td><div style="text-align: center">
								<a
									href="<%=request.getContextPath()%>/deleteJackWorks?jackworksId=<%=jack.getJackworksId()%>"
									class="btn btn--delete">削除</a>
							</div></td>
					</tr>

					<%
					}
					%>

				</table>
			</div>
			</form>
		</div>
	</div>
</body>
</html>