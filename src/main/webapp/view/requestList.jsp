<%@page contentType="text/html; charset=UTF-8"%>
<%@ page import="bean.Request,java.util.ArrayList"%>
<%
ArrayList<Request> requestList = (ArrayList<Request>) request.getAttribute("requestList");
Request Allrequest = new Request();
%>

<html>
<head>
<title>申請一覧</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<script src="<%=request.getContextPath()%>/js/script.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<style>
#main2 {
	position: relative;
	width: 100%;
	margin: 0px;
	flex-direction: row;
	z-index: 10;
}
.list {
	width: 80%;
	margin: 0 auto;
}

.form {
	margin: 0 auto;
}

.list th {
	border: 1px solid;
	background-color: #afd5e6;
}

.userid {
	width: 10%;
}

.name {
	width: 15%;
}

.requestid {
	width: 10%;
}

.request {
	width: 20%;
}

.time {
	width: 22%;
}

.approval {
	width: 8%;
	text-align: center;
}

.request_flag {
	width: 7%;
	text-align: center;
}

.delete {
	width: 8%;
	text-align: center;
}

.display {
	width: 80%;
	margin: 0 auto;
}

.display tr:nth-child(even) {
	background-color: white;
}

.display tr:nth-child(odd) {
	background-color: #f0f0e6;
}

.display tr:hover {
	background-color: #e6e6e6;
	cursor: pointer
}

/*フォーム全体を中央へ*/
#form1 {
	display: flex;
	justify-content: center; /*中央へ固定*/
	height: 30px; /*高さ*/
}
/*入力フォーム*/
#sbox1 {
	width: 200px; /*横幅*/
	padding: 0 15px; /*プレースホルダーの位置調整*/
	border-radius: 4px 0 0 4px; /*左側の角を少し丸める*/
	background: #eee; /*検背景カラー*/
	outline: 0; /*クリック時の青い枠線消す*/
}
/*検索ボタン*/
#sbtn1 {
	width: 70px; /*横幅*/
	border-radius: 0 4px 4px 0; /*右側の角を少し丸める*/
	background: #3399ff; /*背景カラー*/
	border: none; /*枠線を消す*/
	color: #fff; /*テキストカラー*/
	font-size: 16px; /*フォントサイズ指定*/
	cursor: pointer; /*マウスを乗せると指差しポインターになる*/
}
/*検索ボタンマウスオーバー時*/
#sbtn1:hover {
	background: #8ad2ff; /*背景カラー変更*/
}

.approval a {
	font-family: 'Noto Sans JP', serif;
	font-size: 11px;
	letter-spacing: 0.1em;
	color: #000000;
	background: #f0f8ff;
	font-weight: 700;
	border: solid 3px #32adfa;
	border-radius: 999px;
	display: block;
	box-sizing: border-box;
	max-width: 50spx;
	text-align: center;
	margin: 0 auto;
	margin-inline: auto;
	text-decoration: none;
	cursor: pointer;
	transition: all 0.3s;
	z-index: 15;
}

.approval a:hover {
	color: #f0f8ff;
	background: #32adfa;
	transition: all 0.3s;
}

.complete a {
	font-family: 'Noto Sans JP', serif;
	font-size: 11px;
	letter-spacing: 0.1em;
	color: #888888;
	background: #b0c4de;
	font-weight: 700;
	border: solid 3px #b0c4de;
	border-radius: 999px;
	display: block;
	box-sizing: border-box;
	max-width: 50spx;
	text-align: center;
	margin: 0 auto;
	margin-inline: auto;
	text-decoration: none;
	cursor: default;
	transition: all 0.3s;
}

.selectbox-1 {
	position: relative;
}

.selectbox-1::before, .selectbox-1::after {
	position: absolute;
	content: '';
	pointer-events: none;
}

.selectbox-1::before {
	display: inline-block;
	right: 0;
	width: 2.8em;
	height: 2.8em;
	border-radius: 0px 4 4 0px;
	background-color: #2589d0;
}

.selectbox-1::after {
	position: absolute;
	top: 50%;
	right: 1.4em;
	transform: translate(50%, -50%) rotate(45deg);
	width: 6px;
	height: 6px;
	border-bottom: 3px solid #fff;
	border-right: 3px solid #fff;
}

.selectbox-1 select {
	appearance: none;
	min-width: 230px;
	height: 2.8em;
	padding: .4em 3.6em .4em .8em;
	border: none;
	border-radius: 3px;
	background-color: #f2f2f2;
	color: #333;
	font-size: 1em;
	cursor: pointer;
}

.selectbox-1 select:focus {
	outline: 2px solid #2589d0;
}

.notApproved {
	border-radius: 999px;
	border: solid 3px #32adfa;
	width: 100%;
	margin: 0 auto;
}

.display .notApproved:hover {
	color: #f0f8ff;
	background: #32adfa;
	transition: all 0.3s;
}

.approved {
	border-radius: 10px;
	border: #d3d3d3;
	width: 100%;
	margin: 0 auto;
	color: #f0f8ff;
	background: #d3d3d3;
	width: 100%;
}

.display .delete {
	border-radius: 10px;
	width: 100%;
	margin: 0 auto;
	color: #f0f8ff;
	background: #b22222;
}

.display .delete:hover {
	color: #b22222;
	background: #f0f8ff;
	transition: all 0.3s;
}
/* 行全体ホバーで色だけ変える（リンク風ではない） */
.row-hover:hover {
	background-color: #eef;
}

/* IDセルのリンクだけクリック可能に見せる */
.requestid a {
	display: inline-block;
	text-decoration: underline;
	color: blue;
	cursor: pointer;
}

/* 他のボタンは通常のマウスカーソルで操作 */
.request-table td button {
	cursor: default;
}
</style>

<body>
	<div id="wrap">
		<!-- ヘッダー部分 -->
		<%@ include file="../common/header.jsp"%>

		<!-- メイン部分 -->
		<div id="main2" class="container">


			<h2 style="text-align: center">-申請一覧-</h2>


			<tr>
				<form id="form1" action="requestSearch">
					<input id="sbox1" name="search" type="text"
						placeholder="申請者名やIDで検索" /> <select name="sort" id="sort">
						<option value="default">すべての内容</option>
						<option value="changeAddress">住所変更</option>
						<option value="changeName">氏名変更</option>
						<option value="changeWork">勤務状況変更</option>
						<option value="licenseRequest">資格申請</option>
						<option value="notApproved">承認待ち</option>
						<option value="approved">承認済み</option>
					</select> <input id="sbtn1" type="submit" value="検索" />
				</form>

				<table class="list">
					<thead>
						<tr>
							<th class="requestid">申請ID</th>
							<th class="userid">申請者ID</th>
							<th class="name">氏名</th>
							<th class="request">申請内容</th>
							<th class="time">申請日時</th>
							<th class="approval">承認</th>
							<th class="request_flag">申請状況</th>
							<th class="delete">取り消し</th>
						</tr>
					</thead>
				</table>
				<table class="display">
					<%
					for (int i = 0; i < requestList.size(); i++) {
					%>

					<tr class="row-hover">
						<td class="requestid" data-href="<%=request.getContextPath()%>/requestDetail?request_id=<%=requestList.get(i).getRequestId()%>&type=<%=requestList.get(i).getRequestTypeFlag()%>"><%=requestList.get(i).getRequestId()%></td>
						<td class="userid" data-href="<%=request.getContextPath()%>/requestDetail?request_id=<%=requestList.get(i).getRequestId()%>&type=<%=requestList.get(i).getRequestTypeFlag()%>"><%=requestList.get(i).getApplicantId()%></td>
						<td class="name" data-href="<%=request.getContextPath()%>/requestDetail?request_id=<%=requestList.get(i).getRequestId()%>&type=<%=requestList.get(i).getRequestTypeFlag()%>"><%=requestList.get(i).getName()%></td>
						<%
						if (requestList.get(i).getRequestTypeFlag() == 0) {
						%>
						<td class="request" data-href="<%=request.getContextPath()%>/requestDetail?request_id=<%=requestList.get(i).getRequestId()%>&type=<%=requestList.get(i).getRequestTypeFlag()%>">住所変更</td>
						<%
						} else if (requestList.get(i).getRequestTypeFlag() == 1) {
						%>
						<td class="request" data-href="<%=request.getContextPath()%>/requestDetail?request_id=<%=requestList.get(i).getRequestId()%>&type=<%=requestList.get(i).getRequestTypeFlag()%>">氏名変更</td>
						<%
						} else if (requestList.get(i).getRequestTypeFlag() == 2) {
						%>
						<td class="request" data-href="<%=request.getContextPath()%>/requestDetail?request_id=<%=requestList.get(i).getRequestId()%>&type=<%=requestList.get(i).getRequestTypeFlag()%>">勤務状況変更</td>
						<%
						} else {
						%>
						<td class="request" data-href="<%=request.getContextPath()%>/requestDetail?request_id=<%=requestList.get(i).getRequestId()%>&type=<%=requestList.get(i).getRequestTypeFlag()%>">資格申請</td>
						<%
						}
						%>
						<td class="time" data-href="<%=request.getContextPath()%>/requestDetail?request_id=<%=requestList.get(i).getRequestId()%>&type=<%=requestList.get(i).getRequestTypeFlag()%>"><%=requestList.get(i).getRequestDate()%></td>
						<%
						if (requestList.get(i).getRequestFlag() == 0) {
						%>
						<td><input class="notApproved" type="submit" value="承認"></td>
						<%
						} else if (requestList.get(i).getRequestFlag() == 1) {
						%>
						<td><input class="approved" type="submit" value="承認済み"></td>
						<%
						}
						if (requestList.get(i).getRequestFlag() == 0) {
						%>
						<td class="request_flag">承認待ち</td>
						<%
						} else if (requestList.get(i).getRequestFlag() == 1) {
						%>
						<td class="request_flag">承認済み</td>
						<%
						}
						%>
						<td><input class="delete" type="submit" value="取り消し"></td>
					</tr>

					<%
					}
					%>


				</table>
		</div>
	</div>
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			// class="requestid,userid,name,time,request" がついてる td を全部探す
			const linkCells = document.querySelectorAll(".requestid, .userid, .name, .time, .request");
			

			// それぞれの td にクリックしたときの処理を追加
			linkCells.forEach(function(cell) {
				cell.addEventListener("click", function() {
					const url = cell.dataset.href; // td に指定された data-href を取り出す
					if (url) {
						window.location.href = url; // そのURLへジャンプする
					}
				});
			});
		});
	</script>
</body>

</div>
</div>
</body>
</html>
