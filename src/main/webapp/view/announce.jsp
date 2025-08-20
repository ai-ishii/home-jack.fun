<!-- 
お知らせを一覧表示するjsp

作成者 : 大北直弥

作成日 : 2025/07/14
更新日 : 2025/08/05
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bean.Announce" import="bean.CategoryMap"
	import="util.MyFormat" import="java.util.ArrayList"
	import="java.time.LocalDateTime" import="java.text.SimpleDateFormat"
	import="java.sql.Timestamp" import="java.util.Date"%>

<%
// 変数宣言
int categoryId = 0;
String category = null;

//オブジェクト変数宣言
MyFormat myFormat = new MyFormat();
long millis = System.currentTimeMillis();
Timestamp timestamp = new Timestamp(millis);

// パラメータの取得
String cmd = (String) request.getAttribute("cmd");
String keyword = (String) request.getAttribute("keyword");
ArrayList<Announce> announceList = (ArrayList<Announce>) request.getAttribute("announceList");
ArrayList<CategoryMap> categoryList = (ArrayList<CategoryMap>) request.getAttribute("categoryList");

String strAnnounceFlag = (String) request.getAttribute("announceFlag");

if(strAnnounceFlag == null){
	strAnnounceFlag = ""; 
}

if(cmd == null){
	cmd = ""; 
}

/*
* リクエストスコープから直接int型にキャストすると
* うまくいかなかったので下記のような記述にしてます
*/
int announceCategoryId = 0;
Object objAnnounceCategoryId = request.getAttribute("announceCategoryId");
LocalDateTime localDateTimeStart = (LocalDateTime) request.getAttribute("localDateTimeStart");
LocalDateTime localDateTimeEnd = (LocalDateTime) request.getAttribute("localDateTimeEnd");
%>
<!DOCTYPE html>
<html>
<head>
<title>お知らせ | Home-Jack</title>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<script src="<%=request.getContextPath()%>/js/script.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<style>
.tab {
	display: flex;
	flex-direction: column;
	align-items: center;
	margin-top: 50px;
}

/* タブメニュー */
.tab_menu {
	display: flex;
	flex-direction: row;
	height: 50px;
	align-items: center;
}

/*
.register_box {
	text-align: center;
	padding: 10px 5px;
	margin: 0 10px;
	width: 100px;
	height: 20px;
	background-color: orange;
	border-radius: 20px;
}
*/
.register_box a {
	padding: 10px 20px;
	margin: 0 15px;
	width: 100px;
	height: 20px;
	border-radius: 20px;
	border: solid 2px orange;
	background-color: orange;
	text-align: center;
	color: #fff;
	letter-spacing: 0.1em;
}

.register_box a:hover {
	background-color: #fff;
	color: orange;
	border: solid 2px orange;
}

.search-form {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-right: 5px;
	margin-left: 20px;
	width: 300px;
	height: 50px;
	overflow: hidden;
	border-radius: 25px;
	background-color: #feffe0;
	margin: 0;
}

.search-form input {
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
	margin-top: 30px;
	width: 50px;
	height: 100%;
	border: none;
	background-color: transparent;
	cursor: pointer;
}

.search-form button::after {
	width: 20px;
	height: 100%;
	background-image:
		url('data:image/svg+xml;charset=utf8,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%2024%2024%22%3E%20%3Cpath%20d%3D%22M23.7%2020.8%2019%2016.1c-.2-.2-.5-.3-.8-.3h-.8c1.3-1.7%202-3.7%202-6C19.5%204.4%2015.1%200%209.7%200S0%204.4%200%209.7s4.4%209.7%209.7%209.7c2.3%200%204.3-.8%206-2v.8c0%20.3.1.6.3.8l4.7%204.7c.4.4%201.2.4%201.6%200l1.3-1.3c.5-.5.5-1.2.1-1.6zm-14-5.1c-3.3%200-6-2.7-6-6s2.7-6%206-6%206%202.7%206%206-2.6%206-6%206z%22%20fill%3D%22%23d9811c%22%3E%3C%2Fpath%3E%20%3C%2Fsvg%3E');
	background-repeat: no-repeat;
	content: '';
}

/* 検索窓のデザイン維持 */
input:-webkit-autofill, input:-webkit-autofill:hover, input:-webkit-autofill:focus,
	input:-webkit-autofill:active {
	/* 背景色を元の色に戻す */
	-webkit-box-shadow: 0 0 0px 1000px #feffe0 inset !important;
}

.filter_box {
	position: relative;
}

.filter_circle {
	position: absolute;
	top: 0;
	right: 0;
	width: 20px;
	color: coral;
}

/* モーダルを開くボタン */
.modal_open {
	font-size: 16px;
	width: 120px;
	height: 50px;
	margin: 0px 5px;
	border: solid 1px orange;
	color: #d9811c;
	background: #feffe0;
	cursor: pointer;
}

/* モーダルと背景の指定 */
.modal {
	display: none;
	position: absolute;
	top: 50px;
	width: 200%;
	max-height: 100%;
	text-align: center;
	overflow: visible;
	transition: .3s;
	box-sizing: border-box;
}

/* モーダルの擬似要素の指定 */
.modal:before {
	content: "";
	display: inline-block;
	vertical-align: middle;
	height: 100%;
	margin-left: -0.2em;
}

/* クラスが追加された時の指定 */
.modal.is-active {
	display: block;
	z-index: 20;
}

/* モーダル内側の指定 */
.modal_container {
	position: absolute;
	top: 0;
	width: 100%;
}

/* モーダルを閉じるボタンの指定 */
.modal_close {
	position: absolute;
	display: flex;
	align-items: center;
	justify-content: center;
	top: 0;
	right: 0;
	width: 40px;
	height: 50px;
	color: #d9811c;
	cursor: pointer;
	font-size: 40px;
}

/* モーダルのコンテンツ部分の指定 */
.modal_content {
    height: 220px;
	background: rgba(254, 255, 224, 0.95);
	line-height: 1.8;
	border-radius: 5px;
	padding: 10px;
	margin-top: 10px;
}

.modal_content label {
	color: #d9811c;
}

/* モーダルのコンテンツ部分のテキストの指定 */
.modal_content p {
	margin: 1em 0;
}

.modal_content select {
	height: 20px;
}

.modal_content select, input {
	color: saddlebrown;
}

input[type="checkbox"] {
	width: 20px;
	height: 20px;
	vertical-align: bottom;
	accent-color: chocolate;
}

/* 絞り込み検索のモーダル内の検索ボタン（input[type="submit"]） */
.filterSearch {
    border: 1px solid #ffd8b2;
	background: #f1e767;
	background: -webkit-gradient(linear, left top, left bottom, from(#fdfbfb), to(#fff));
	background: -webkit-linear-gradient(top, #fdfbfb 0%, #fff 100%);
    background: linear-gradient(to bottom, #ffefe0 0%, #fff 100%);
	-webkit-box-shadow: inset 1px 1px 1px #fff;
    box-shadow: inset 1px 1px 1px #ffddbc;
	width: 50px;
	margin-top: 10px;
	margin-right: 5px;
	padding: 5px;
	color: saddlebrown;
}

.filterSearch:hover {
	background: -webkit-gradient(linear, left bottom, left top, from(#ffc993), to(#fff));
	background: -webkit-linear-gradient(bottom, #ffc993 0%, #fff 100%);
	background: linear-gradient(to top, #ffe5cc 0%, #fff 100%);
}

/* 絞り込み検索のモーダル内の各項目（div） */
.filter {
	margin: 10px;
	text-align: left;
}

/* 検索ボタンのエリア（div） */
.searchBtn {
	text-align: right;		/*divで囲って親要素で指定しないと効かない*/
}

.main_box {
	display: flex;
	flex-direction: column;
	align-items: center;
	margin-top: 50px;
}

.content_box {
	display: flex;
	position: relative;
	width: 80%;
}

.announce_box {
	display: flex;
	justify-content: center;
	width: 90%;
	margin: 5px;
	color: #000000;
	background-color: #ffffff;
	transition: all 0.5s 0s ease;
	border-radius: 10px;
	background-color: #ffffff;
}

.announce_box :hover {
	background-color: #ffd8b2;
	border-radius: 10px;
}

.date_box {
	min-height: 100px;
	width: 20%;
}

.date_box p {
	text-align: center;
	font-size: 40px;
	padding: 20px 0;
	margin: 0;
}

.title_box {
	min-height: 100px;
	width: 80%;;
}

.title_box p {
	text-align: left;
	font-size: 18px;
	padding: 35px 0;
	margin: 0;
}

.category_box {
	width: 10%;
	background-color: whitesmoke;
	overflow: visible;
	white-space: nowrap;
}

.category_box p {
	color: #aaaaaa;
	font-size: 17px;
	text-align: left;
	margin: 0;
}

a {
	text-decoration: none;
	color: #000000;
}

.box_link {
	display: flex;
	width: 100%;
}

.announce_flag {
	position: absolute;
	top: 0;
	left: 0;
	padding: 2px;
	width: 40px;
	height: 40px;
	color: #ffffff;
	text-align: center;
	background-color: orange;
	border-radius: 50%;
	/*上下中央揃えにするため*/
	display: flex;
	align-items: center;
	justify-content: center;
}

.announce_flag p {
	font-size: 30px;
	font-weight: bold;
	margin: 0;
}


/* spanタグの空白をなくすため */
.no-space{
display: flex;
gap: 0				/* 子要素の間隔を0にする */
}

/* 絞り込み検索のアイコン（svg） */
.filterIcon {
	width: 22px;
	height: 22px;
	vertical-align: bottom;
}
</style>


</head>
<body>
	<div id="wrap">

		<!-- ヘッダー部分 -->
		<%@include file="../common/header.jsp"%>

		<!-- メイン部分 -->
		<div id="main" class="container">
			<div class="tab container">
				<!-- タブ -->
				<div class="tab_menu">
					<div class="register_box">
						<a href="<%=request.getContextPath()%>/view/announceRegister.jsp"
							class="box-link">新規投稿</a>
					</div>

					<form action="<%=request.getContextPath()%>/announceSearch"
						method="POST">
						<div class="search-form">
							<input type="text" id="searchInput" name="keyword"
								placeholder="キーワードを入力">
							<button class="searchIcon" type="submit" aria-label="検索"></button>
							<input type="hidden" name="cmd" value="keyword">
						</div>
					</form>

					<div class="filter_box">

						<button type="button" class="modal_open js_modal_open">
							<svg class="filterIcon" xmlns="http://www.w3.org/2000/svg"
								viewBox="0 0 48 48">
								<defs>
								<style>
									.a, .b {
										fill: none;
									}
									
									.b {
										stroke: #d9811c;
										stroke-linecap: round;
										stroke-linejoin: round;
										stroke-width: 4px;
									}
								</style>
								</defs>
								<title>511_s_f</title><rect class="a" width="48" height="48" />
								<circle class="b" cx="32" cy="15" r="5" />
								<line class="b" x1="2" y1="15" x2="20" y2="15" />
								<line class="b" x1="37.5" y1="15" x2="46" y2="15" />
								<line class="b" x1="2" y1="33" x2="11" y2="33" />
								<circle class="b" cx="16" cy="33" r="5" />
								<line class="b" x1="27" y1="33" x2="46" y2="33" /></svg>
							絞り込み
						</button>

						<%
						if (cmd != null) {
							if (!strAnnounceFlag.equals("") || objAnnounceCategoryId != null || 
									localDateTimeStart != null || localDateTimeEnd != null) {
						%>

						<div class="filter_circle">●</div>

						<%
							}
						}
						%>

						<div class="modal js_modal">
							<div class="modal_container">
								<div class="modal_close js_modal_close">×</div>
								<div class="modal_content js_modal_content">
									<form action="<%=request.getContextPath()%>/announceSearch"
										method="POST">
										<div class="filter">
											<label for="important">重要記事</label>
											<input type="checkbox" switch
												id="important" value="1" name="announce_flag"
												<%
											if (cmd != null) {
												if (cmd.equals("filter")) {
													/*
													* 重要記事にチェックをつけて検索したとき、
													* チェックを検索フォームに再表示する
													*/
													if (strAnnounceFlag.equals("1")) {
											%>
												checked="checked"
												<%
													}
												}
											}
											%>>
											<input type="hidden" name="announce_flag" value="">
										</div>
										<div class="filter">
											<label for="category_select">カテゴリ</label> <select
												id="category_select" name="category_id">
												<option value="">全カテゴリ</option>
												<%
												for (int i = 0; i < categoryList.size(); i++) {
													CategoryMap categoryMap = categoryList.get(i);
												%>

												<option value="<%= categoryMap.getId() %>"
													<%
													if (cmd != null) {
														/*
														* カテゴリを選んで検索すると、カテゴリが検索後に
														* 再表示される
														*/
														if (objAnnounceCategoryId != null &&
																objAnnounceCategoryId instanceof Integer) {
															announceCategoryId = (Integer) objAnnounceCategoryId;
															if (announceCategoryId == i + 1) {
													%>
													selected
													<%
														}
														}
													}
													%>>
													<%= categoryMap.getName() %>
												</option>
												<%
												}
												%>
											</select>
										</div>
										<div class="filter">
											<label for="start_date">開始日</label> <input
												type="datetime-local" id="start_date" name="start_date"
												max="9999-12-31 23:59"
												<%
											if (cmd != null) {
												/*
												* 時間で検索したとき、入力した時間が検索フォームに再表示される
												*/
												if (localDateTimeStart != null) {
											%>
												value="<%= localDateTimeStart %>"
												<%
												}
											}
											%>>
										</div>
										<div class="filter">
											<label for="end_date">終了日</label> <input
												type="datetime-local" id="end_date" name="end_date"
												max="9999-12-31 23:59"
												<%
											if (cmd != null) {
												/*
												* 時間で検索したとき、入力した時間が検索フォームに再表示される
												*/
												if (localDateTimeEnd != null) {
											%>
												value="<%= localDateTimeEnd %>"
												<%
												}
											}
											%>>
										</div>
										<input type="hidden" name="cmd" value="filter">
										<div class="searchBtn">
										<button class="filterSearch" type="submit">検索</button>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>

				<!-- タブの中身 -->
				<div class="container main_box">
					<%
					if (cmd != null) {
						if (cmd.equals("keyword")) {
	
							/*
							* 検索ワードがnullではないかつ空文字ではないとき、
							* 検索ワードを表示する
							*/
							if (keyword != null && !keyword.equals("")) {
					%>
					<div>
						<p>
							"<%= keyword %>"の検索結果
						</p>
					</div>
					<%
							}
						}
					}
					%>

					<!-- 検索結果が0件の場合メッセージを表示 -->
					<%
					if(cmd.equals("no-result")){ 
						//キーワード検索が0件の場合
						if(keyword != null){
					%>
					<div class="no-space">
					<span>"<%= keyword %>"の</span>
					<%
						}
					%>
						<span>検索結果は0件です。</span>
					</div>
					<p>内容を変更して再度検索をしてください。</p>
					<%
					}
					%>

					<%
					if (announceList != null) {
						for (int j = 0; j < announceList.size(); j++) {
					%>
					<div class="content_box">
						<div class="announce_box">
							<a
								href="<%=request.getContextPath()%>/announceDetail
								?announceId=<%=announceList.get(j).getAnnounceId()%>&cmd=detail"
								class="box_link">
								<div class="date_box">
									<p>
										<%
										timestamp = announceList.get(j).getRegistDate();
										%>
										<%=myFormat.monthDayFormat(timestamp)%>
									</p>
								</div>
								<div class="title_box">
									<p><%=announceList.get(j).getTitle()%></p>
								</div>
							</a>
						</div>
						<div class="category_box">
							<p class="categoryTag">
								<%
								categoryId = announceList.get(j).getAnnounceCategoryId();
								if (categoryId == 1) {
									category = "お知らせ";
								} else if (categoryId == 2) {
									category = "チーム活動";
								} else if (categoryId == 3) {
									category = "ナレッジベース";
								} else {
									category = "その他";
								}
								%>

								#<%=category%>
							</p>
						</div>
						<%
						int announceFlag = announceList.get(j).getAnnounceFlag();
						if (announceFlag == 1) {
						%>
						<div class="announce_flag">
							<p>！</p>
						</div>
						<%
						}
						%>
					</div>
					<%
					}
					}
					%>
				</div>
			</div>
		</div>
	</div>
	<script>
		const modal = document.querySelector('.js_modal'), 
			open = document.querySelector('.js_modal_open'), 
			close = document.querySelector('.js_modal_close'),
			content = document.querySelector('.js_modal_content');

		function modalOpen() {
			modal.classList.add('is-active');
		}

		function modalClose() {
			modal.classList.remove('is-active');
		}
		close.addEventListener('click', modalClose);

		function modalOut() {
			modal.classList.remove('is-active');
		}

		// 絞り込み検索ボタンが押されたとき
		open.addEventListener(('click'), () => {
			// モーダルウインドウが開いているときは閉じる
			if (modal.classList.contains("is-active")) {
				modalClose();
			} else {
				modalOpen();
			}
		});
		
		document.addEventListener(('click'), (event) => {
			// openをクリックしたときの影響をなくす
			// content部分がクリックされたときはreturnで何も起きないようにする
			if (open.contains(event.target) || content.contains(event.target)) {
				return;
			}
			// それ以外のときは必ずcloseにする
			modalClose();
		});

		// 必要な要素を取得
		const categoryList = document.querySelectorAll(".categoryTag");

		// カテゴリーごとに文字色を変更
		for (let i = 0; i < categoryList.length; i++) {
			if(categoryList[i].textContent.trim() == "#お知らせ") {
				categoryList[i].style.color = "olivedrab";
			} else if (categoryList[i].textContent.trim() == "#チーム活動") {
				categoryList[i].style.color = "palevioletred";
			} else if (categoryList[i].textContent.trim() == "#ナレッジベース") {
				categoryList[i].style.color = "steelblue";
			} else if (categoryList[i].textContent.trim() == "#その他") {
				categoryList[i].style.color = "dimgray";
			}
		}
	</script>
</body>
</html>