<%--
JackWorks画面
作成者：青木美波
作成日 2025/07/11
更新日 2025/07/29
 --%>

<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.ArrayList,bean.Jackworks,bean.Monthjack,bean.Account,util.MyFormat"%>

<%
//JackWorksの全情報が格納されたjack_listを受け取る
ArrayList<Jackworks> jackList = (ArrayList<Jackworks>) request.getAttribute("jack_list");
//今月のJackWorksの全情報が格納されたmonthJackを受け取る
Monthjack monthJack = (Monthjack) session.getAttribute("monthJack");
//ログインしたアカウントの情報が格納されたaccountを受け取る
Account account = (Account)session.getAttribute("account");
//検索された文字列が格納されたnameを受け取る
String name = (String) request.getAttribute("name");
//検索された月が格納されたmonthSearchを受け取る
String monthSearch = (String) request.getAttribute("monthSearch");
//検索された年が格納されたyearSearchを受け取る
String yearSearch = (String) request.getAttribute("yearSearch");

if(name == null){
	name = "";
}

//権限分け
int adminFlag = 1;
int managerFlag = 0;
// int adminFlag = account.getAdminFlag();
// int adminFlag = account.getManagerFlag();
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

<!-- 以下CSS -->
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

/* 画像の配置 */
#point-img {
	text-align: center;
}

/* 余白 */
.mag {
	margin-top: 2%;
}

/* 今月のJackworks備考欄 */
.point-box {
	width: 90%;
	white-space: pre-wrap;
	word-wrap: break-word;
	overflow-wrap: break-word;
	word-break: break-all;
	margin: 0 auto;
}

.point-text {
	margin: 0 auto;
	width: 90%;
}

/* 表関係 */
table {
	border-collapse: collapse;
	margin: 0 auto;
	padding: 0;
	width: 100%;
}

table tbody tr {
	background-color: #fff;
	border-bottom: 2px solid #fff;
	height: 70px;
}

table tbody tr:nth-child(even) {
	background-color: #eee;
}

table th, table td {
	padding: .20em 1em;
}

table thead{
background-color: #ffffff;
}

table thead th.jack-table{
	font-size: .85em;
	padding: 1em;
	width: 100px;
}

table thead tr.jack-table{
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

/* ボタン関係 */
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

/* 削除ボタン */
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

/*　登録ボタン */
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

/*　検索を行うフォーム */
.search-form {
	display: flex;
	justify-content: space-between;
	align-items: center;
	width: 250px; 
	overflow: hidden;
	border-radius: 25px;
	background-color: #feffe0;
	margin:0;
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
	background-image:
		url('data:image/svg+xml;charset=utf8,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%2024%2024%22%3E%20%3Cpath%20d%3D%22M23.7%2020.8%2019%2016.1c-.2-.2-.5-.3-.8-.3h-.8c1.3-1.7%202-3.7%202-6C19.5%204.4%2015.1%200%209.7%200S0%204.4%200%209.7s4.4%209.7%209.7%209.7c2.3%200%204.3-.8%206-2v.8c0%20.3.1.6.3.8l4.7%204.7c.4.4%201.2.4%201.6%200l1.3-1.3c.5-.5.5-1.2.1-1.6zm-14-5.1c-3.3%200-6-2.7-6-6s2.7-6%206-6%206%202.7%206%206-2.6%206-6%206z%22%20fill%3D%22%23d9811c%22%3E%3C%2Fpath%3E%20%3C%2Fsvg%3E');
	background-repeat: no-repeat;
	content: '';
}

.mar {
	margin: 0 auto
}

/*　西暦と月の検索ボックスの配置 */
td.search-box {
	height: 100px;
	margin-bottom: 1px;
	display: flex;
	align-items: center;
}

td.search-box form {
	padding: 6px;
}

/*　西暦と月を検索ボックス */
.selectbox-4 {
	display: inline-flex;
	align-items: center;
	position: relative;
}

.selectbox-4::after {
	position: absolute;
	right: 15px;
	width: 10px;
	height: 7px;
	background-color: #ffbe20;
	clip-path: polygon(0 0, 100% 0, 50% 100%);
	content: '';
	pointer-events: none;
}

.selectbox-4 select {
	appearance: none;
	min-width: 230px;
	height: 2.8em;
	padding: .4em calc(.8em + 30px) .4em .8em;
	border: none;
	border-radius: 25px;
	box-shadow: 0 4px 4px rgb(0 0 0/ 2%), 0 2px 3px -2px rgba(0 0 0/ 5%);
	background-color: #fff;
	color: #fa9e00;
	font-size: 1em;
	cursor: pointer;
}

/* 検索窓のデザイン維持 */
input:-webkit-autofill,
input:-webkit-autofill:hover,
input:-webkit-autofill:focus,
input:-webkit-autofill:active {
    /* 背景色を元の色に戻す */
    -webkit-box-shadow: 0 0 0px 1000px #feffe0 inset !important;
}

/* buttonタグのリセットCSS */
button {
	padding: 0;
	font-family: inherit;
	appearance: none;
	cursor: pointer;
	background-color: transparent;
	border: none;
}

/* 検索ボタン */
.select-button {
	display: flex;
	align-items: center;
	justify-content: center;
	width: 70px;
	aspect-ratio: 200/100;
	color: #222;
	background-color: #f5f5f5;
	border-radius: 50%;
	box-shadow: -2px -2px 4px #fff, 2px 2px 4px rgb(0 0 0/ 24%);
	color: #737373;
}

@media ( any-hover : hover) {
	.select-button {
		transition: box-shadow 0.2s;
	}
	.select-button:hover {
		box-shadow: -2px -2px 4px #fff, 2px 2px 4px rgb(0 0 0/ 24%);
	}
	.select-button:active {
		background-color: #ebebeb;
		box-shadow: inset 4px 4px 8px rgb(0 0 0/ 16%);
	}
	option {
		color: #000;
	}
}

/* ページネーション */
.pagination {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 0 8px;
    list-style-type: none;
    padding: 0;
}

.pagination a {
    box-sizing: border-box;
    display: flex;
    justify-content: center;
    align-items: center;
    width: 2em;
    height: 2em;
    border: 1px solid #ffc342;
    border-radius: 25px;
    color: #ffc342;
}

.pagination a:not(:hover) {
    text-decoration: none;
}

.pagination .current a {
    background-color: #ffc342;
    color: #fff;
    pointer-events: none;
}

.pagination .prev a,
.pagination .next a {
    gap: 0 4px;
    width: auto;
    padding: .5em .8em;
    line-height: 1;
}

.pagination .prev a::before,
.pagination .next a::after {
    display: inline-block;
    transform: rotate(45deg);
    width: .3em;
    height: .3em;
    content: '';
}

.pagination .prev a::before {
    border-bottom: 1px solid #ffc342;
    border-left: 1px solid #ffc342;
}

.pagination .next a::after {
    border-top: 1px solid #ffc342;
    border-right: 1px solid #ffc342;
}

/* 案件情報収集用 */
.case-link{
cursor:pointer;
}

.case-link:hover{
background-color:#c0c0c0;
}

.jack-fontsize{
font-size: 16px;
}

.jack-button{
height: 20px;
margin-left: auto;
display:inline-flex;
gap: 6px;
}

.jack-display{
display:inline-flex;
justify-content: space-between;
width: 100%;
}

.jack-mana{
height: 20px;
}

</style>

<body>

<!-- 過去十年の年号を取得 -->
<script>
document.addEventListener('DOMContentLoaded', function() {
	const yearSelect = document.getElementById('yearSelect'); // セレクトボックスのidを取得
	const currentYear = new Date().getFullYear(); // 現在の年を取得

	// 現在の年から過去10年までを生成する範囲を設定
	const startYear = currentYear;//現在
	const endYear = currentYear - 10; //10年前

	// セレクトボックスに年を追加
	for (let year = startYear; year >= endYear; year--) {
		const option = document.createElement('option'); // <option> 要素を作成
		option.value = year; // value 属性に年を設定
		option.textContent = year + '年'; // 表示テキストに年を設定
		yearSelect.appendChild(option); // セレクトボックスにオプションを追加
	}
	yearSelect.value = currentYear;
});

document.addEventListener('DOMContentLoaded', function() {
	const selectmonth = "<%= monthSearch %>";

	if(selectmonth && selectmonth != "null" && selectmonth != ""){
	document.getElementById('monthSearch').value = selectmonth;
	
	}
});

document.addEventListener('DOMContentLoaded', function() {
	const selectyear = "<%= yearSearch %>";

	if(selectyear && selectyear != "null" && selectyear != ""){
	document.getElementById('yearSelect').value = selectyear;
	
	}
});

</script>

<!-- 管理者/マネージャーのみ表示：管理者・マネージャー1 -->
<%
if((adminFlag == 1 && managerFlag == 0)||(adminFlag == 0 && managerFlag == 1)){
%>
<script>

//リンクにするjavascript
document.addEventListener("DOMContentLoaded", function() {

	// .jack-link ,data-label="カテゴリ"がついてるタグを全部探す
	const categoryCells = document.querySelectorAll('td[data-label="カテゴリ"]');

	//各セルをひとつずつチェック
	categoryCells.forEach(cell =>{
		console.log(cell.textContent);
		//セル取得後、前後の空白削除
		const category = cell.textContent.trim();

	if(category === '案件情報収集'){
		// 一致した場合、そのセルの親要素である行（tr）を取得
		const row = cell.closest('tr');
		
		// クラスが記述されたタグにクリックしたときの処理を追加
		if(row){
			 // CSSを適用
			row.classList.add('case-link');

			row.addEventListener("click", function(event) {
				//ボタンを押した場合を省く
				if(event.target.closest('.btn')){
				return;
				}

				//対象に設定されたdatasetを取り出す
				const url = row.dataset.href; 
			
				if (url) {
					//設定したURLに遷移する
					window.location.href = url;
				}
       		 });
		}
	}
	});

	//削除アラート用
	const btn = document.querySelectorAll(".btn--delete");

	// それぞれの td にクリックしたときの処理を追加
	btn.forEach(function(button) {
		button.addEventListener("click", function(event) {

			//イベントの伝播をとめる処理
			event.stopPropagation();
			//イベントのデフォルトの動作を止める処理
			event.preventDefault();
			
			//対象に設定されたdatasetを取り出す
			const jackDelete = button.dataset.href; 
			
			if(confirm("本当に削除しますか？")){
				alert("削除しました。");
				
				//設定したURLに遷移する
				window.location.href = jackDelete;
			}else{
				alert("キャンセルしました。");
			}
		});
	});
	
});

</script>

<%
}
%>

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
						<li class="jack-fontsize">＜ポイント一覧＞</li>
					</ul>
				<div class="jack-display">
					<li class="jack-fontsize"><strong><%=monthJack.getTheme()%></strong></li>
					
					<!-- 管理者のみ表示：管理者1 -->
					<%
						if(adminFlag == 1 && managerFlag == 0){
					%>
					<!-- 今月のJackWorksを登録するボタン -->
					<div class="jack-button">
						<li><a href="<%=request.getContextPath()%>/view/monthJackworks.jsp"
								class="btn btn--insert">テーマ更新</a>
						</li>
						<!-- Jackworksの申請一覧ボタン -->
						<li><a href="<%=request.getContextPath()%>/jackworksRequest" 
								class="btn btn--insert">申請一覧</a>
						</li>
					</div>
					<% } %>
					
					<!-- マネージャーのみ表示：マネージャー1 -->
					<%
					if(adminFlag == 0 && managerFlag == 1){
					%>
					<div class="jack-mana">
					<!-- Jackworksの申請一覧ボタン -->
					<li><a href="<%=request.getContextPath()%>/jackworksRequest" 
							class="btn btn--insert">申請一覧</a>
					</li>
					</div>
					<% } %>
				</div>
				</div>
			
				<!-- 余白 -->
				<div class="mag"></div>

				<!-- 画像表示 -->
				<div id="point-img">
					<img src="<%=request.getContextPath()%>/file/<%=monthJack.getImage()%>"
							alt="ポイント一覧表" width="90%">
				</div>

				<!-- ポイント一覧説明 -->
				<div class="point-box"><%=monthJack.getNote()%></div>
				<div class="mag"></div>

				<p class="jack-fontsize">＜ポイント取得者一覧＞</p>

				<!-- ポイント取得者一覧表示 -->
				<table class="mar">
				<thead style="margin: 0 auto">
					<tr>
						<td class="search-box">

							<!-- 検索を行うフォーム -->
							<form action="<%=request.getContextPath()%>/jackworksSearch"
									class="search-form">
								<label><input type="text" name="name" placeholder="キーワードを入力" value="<%= name %>"></label>
								<button type="submit" aria-label="検索"></button>
							</form>
						</td>
							
						<!-- 十年間の西暦検索を行うフォーム -->
						<form action="<%=request.getContextPath()%>/jackworksSearch">
						<td><label class="selectbox-4">
								<select id="yearSelect" name="year-search">
							</label>
								</select>
						</td>
						
						<!-- 月の検索を行うセレクトボックス -->
						<td><label class="selectbox-4">
								<select id="monthSearch" name="month-search">
									<option value="01">1月</option>
									<option value="02">2月</option>
									<option value="03">3月</option>
									<option value="04">4月</option>
									<option value="05">5月</option>
									<option value="06">6月</option>
									<option value="07">7月</option>
									<option value="08">8月</option>
									<option value="09">9月</option>
									<option value="10">10月</option>
									<option value="11">11月</option>
									<option value="12">12月</option>
								</select>
						</td></label>
						<td>
						<button type="submit" class="select-button" >検索</button>
						</form>
						</td>
						
				<!-- 管理者のみ表示：管理者1 -->
				<%
				if(adminFlag == 1 && managerFlag == 0){
				%>
					<!-- JackWorkの新規登録を行うボタン -->
					<td style="text-align: right">
						<a href="<%=request.getContextPath()%>/view/jackworksRegister.jsp"
							class="btn btn--insert">新規申請</a>
					</td>
					</tr>
				</thead>
				</table>
				
				<!-- JackWork一覧表の表示 -->
				<table style="width: 100%">
					<thead style="margin: 0 auto">
						<tr class="jack-table">
							<th scope="col" class="jack-table">年月日</th>
							<th scope="col" class="jack-table">社員No.</th>
							<th scope="col" class="jack-table">氏名</th>
							<th scope="col" class="jack-table">カテゴリ</th>
							<th scope="col" class="jack-table">評価項目</th>
							<th scope="col" class="jack-table">付与ポイント</th>
							<th scope="col" class="jack-table">備考</th>
							<th scope="col" class="jack-table"></th>
						</tr>
					</thead>
					<tbody>
					<%
					for (int i = 0; i < jackList.size(); i++) {
						Jackworks jack = (Jackworks) jackList.get(i);
							String note = jack.getNote();
						
							MyFormat myformat = new MyFormat();
							String date = myformat.breakDateFormat(jack.getPointsGetDate());
						
						if (note == null) {
							note = "";
						}
						if (jack.getAdminFlag() == 1) {
					%>
					
					<tr class="jack-link" data-href="<%=request.getContextPath()%>/jackworksDetail?jackworksId=<%=jack.getJackworksId()%>">
						<td data-label="年月日" class="num" name="date"><%= date %></td>
						<td data-label="社員No" class="num" name="employeeNumber"><%=jack.getEmployeeNumber() %></td>
						<td data-label="氏名" class="text-point" name="name"><%=jack.getName()%></td>
						<td data-label="カテゴリ" class="text-point" name="category"><%=jack.getCategory()%></td>
						<td data-label="評価項目" class="text" name="assessment"><%=jack.getAssessment()%></td>
						<td data-label="付与ポイント" class="num-point" name="point"><%=jack.getPoint()%></td>
						<td data-label="備考" class="text" name="note"><%=note%></td>
						<td><div style="text-align: center">
							<a data-href="<%=request.getContextPath()%>/jackworksDelete?jackworksId=<%=jack.getJackworksId()%>" class="btn btn--delete">削除</a>
							</div>
						</td>
					</tr>

					<%
						}
					}
					%>
				</tbody>
				</table>
				<%
				}
				%>
						
				<!-- マネージャーのみ表示：マネージャー1 -->
				<%
				if(adminFlag == 0 && managerFlag == 1){
				%>
					<!-- JackWorkの新規登録を行うボタン -->
					<td style="text-align: right">
						<a href="<%=request.getContextPath()%>/view/jackworksRegister.jsp"
							class="btn btn--insert">新規申請</a>
					</td>
					</tr>
				</thead>
				</table>
				
				<!-- JackWork一覧表の表示 -->
				<table style="width: 100%">
					<thead style="margin: 0 auto">
						<tr class="jack-table">
							<th scope="col" class="jack-table">年月日</th>
							<th scope="col" class="jack-table">社員No.</th>
							<th scope="col" class="jack-table">氏名</th>
							<th scope="col" class="jack-table">カテゴリ</th>
							<th scope="col" class="jack-table">評価項目</th>
							<th scope="col" class="jack-table">付与ポイント</th>
							<th scope="col" class="jack-table">備考</th>
						</tr>
					</thead>
					<tbody>
					<%
					for (int i = 0; i < jackList.size(); i++) {
						Jackworks jack = (Jackworks) jackList.get(i);
							String note = jack.getNote();
						
							MyFormat myformat = new MyFormat();
							String date = myformat.breakDateFormat(jack.getPointsGetDate());
						
						if (note == null) {
							note = "";
						}
						if (jack.getAdminFlag() == 1) {
				
					%>
					
					<tr class="jack-link" data-href="<%=request.getContextPath()%>/jackworksDetail?jackworksId=<%=jack.getJackworksId()%>">
						<td data-label="年月日" class="num" name="date"><%= date %></td>
						<td data-label="社員No" class="num" name="employeeNumber"><%=jack.getEmployeeNumber() %></td>
						<td data-label="氏名" class="text-point" name="name"><%=jack.getName()%></td>
						<td data-label="カテゴリ" class="text-point" name="category"><%=jack.getCategory()%></td>
						<td data-label="評価項目" class="text" name="assessment"><%=jack.getAssessment()%></td>
						<td data-label="付与ポイント" class="num-point" name="point"><%=jack.getPoint()%></td>
						<td data-label="備考" class="text" name="note"><%=note%></td>
					</tr>

					<%			
						}
					}
					%>
				</tbody>
				</table>
				<%
				}
				%>
				
				<!-- ユーザーのみ表示：ユーザー0 -->
				<%
					if(adminFlag == 0 && managerFlag == 0){
				%>
				<!-- JackWork一覧表の表示 -->
				<table style="width: 100%">
					<thead style="margin: 0 auto">
						<tr class="jack-table">
							<th scope="col" class="jack-table">年月日</th>
							<th scope="col" class="jack-table">社員No.</th>
							<th scope="col" class="jack-table">氏名</th>
							<th scope="col" class="jack-table">カテゴリ</th>
							<th scope="col" class="jack-table">評価項目</th>
							<th scope="col" class="jack-table">付与ポイント</th>
							<th scope="col" class="jack-table">備考</th>
						</tr>
					</thead>
					<tbody>
					<%
					for (int i = 0; i < jackList.size(); i++) {
						Jackworks jack = (Jackworks) jackList.get(i);
							String note = jack.getNote();
						
							MyFormat myformat = new MyFormat();
							String date = myformat.breakDateFormat(jack.getPointsGetDate());
						
						if (note == null) {
							note = "";
						}
						if (jack.getAdminFlag() == 1) {
					%>
					
					<tr>
						<td data-label="年月日" class="num" name="date"><%= date %></td>
						<td data-label="社員No" class="num" name="employeeNumber"><%=jack.getEmployeeNumber() %></td>
						<td data-label="氏名" class="text-point" name="name"><%=jack.getName()%></td>
						<td data-label="カテゴリ" class="text-point" name="category"><%=jack.getCategory()%></td>
						<td data-label="評価項目" class="text" name="assessment"><%=jack.getAssessment()%></td>
						<td data-label="付与ポイント" class="num-point" name="point"><%=jack.getPoint()%></td>
						<td data-label="備考" class="text" name="note"><%=note%></td>
					</tr>

					<%
						}
					}
					%>
				</tbody>
				</table>
				<%
				}
				%>
				
				<!-- ページネーション -->
				<div id="data-container"></div>
				<ol class="pagination">
    				<li class="prev" id="prev-btn">前へ</li>
    				<li id="page-btn"></li>
    				<li class="next" id="next-btn"></li>
				</ol>
			</div>
			</div>
		</div>
	</div>
</body>
</html>