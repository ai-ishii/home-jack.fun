<!-- 
お知らせを一覧表示するjsp

作成者 : 大北直弥

作成日 : 2025/07/14
更新日 : 2025/07/31
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="bean.Announce, bean.AnnounceCategory, util.MyFormat, 
	java.util.ArrayList, java.text.SimpleDateFormat, java.sql.Timestamp, java.util.Date"%>

<%
ArrayList<Announce> announceList = (ArrayList<Announce>) request.getAttribute("announceList");
ArrayList<AnnounceCategory> categoryList = (ArrayList<AnnounceCategory>) request.getAttribute("categoryList");
MyFormat myFormat = new MyFormat();
long millis = System.currentTimeMillis();
Timestamp timestamp = new Timestamp(millis);
int categoryId = 0;
String category = null;
%>
<!DOCTYPE html>
<html>
<head>
<title>お知らせ</title>

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
}

.register_box {
	text-align: center;
	margin: 0 10px;
	background-color: orange;
	border-radius: 20px;
	height: 100%;
}

.register_box a {
	color: #fff;
}

.search-form {
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 300px;
    height: 100%;
    overflow: hidden;
    border-radius: 25px;
    background-color: #e8e0fe;
}

.search-form input {
    padding: 5px 15px;
    border: none;
    box-sizing: border-box;
    background-color: #e8e0fe;
    font-size: 1em;
    outline: none;
}

.search-form input::placeholder {
    color: #777777;
}

.search-form button {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 50px;
    height: 100%;
    border: none;
    background-color: transparent;
    cursor: pointer;
}

.search-form button::after {
    width: 20px;
    height: 100%;
    background-image: url('data:image/svg+xml;charset=utf8,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%2024%2024%22%3E%20%3Cpath%20d%3D%22M23.7%2020.8%2019%2016.1c-.2-.2-.5-.3-.8-.3h-.8c1.3-1.7%202-3.7%202-6C19.5%204.4%2015.1%200%209.7%200S0%204.4%200%209.7s4.4%209.7%209.7%209.7c2.3%200%204.3-.8%206-2v.8c0%20.3.1.6.3.8l4.7%204.7c.4.4%201.2.4%201.6%200l1.3-1.3c.5-.5.5-1.2.1-1.6zm-14-5.1c-3.3%200-6-2.7-6-6s2.7-6%206-6%206%202.7%206%206-2.6%206-6%206z%22%20fill%3D%22%23777777%22%3E%3C%2Fpath%3E%20%3C%2Fsvg%3E');
    background-repeat: no-repeat;
    content: '';
}

.filter_box {
	position: relative;
}

/* モーダルを開くボタン */
.modal_open {
	font-size: 16px;
	width: 100px;
	height: 100%;
	color: #777;
	background: #e8e0fe;
	border: none;
	border-radius: 10px;
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
	top: -20px;
	right: -20px;
	width: 40px;
	height: 40px;
	color: #fff;
	background: #000;
	border-radius: 50%;
	cursor: pointer;
}

/* モーダルのコンテンツ部分の指定 */
.modal_content {
	background: #e8e0fe;
	text-align: left;
	line-height: 1.8;
	border-radius: 5px;
	padding: 10px;
	margin-top: 10px;
}

.modal_content label {
	color: #777;
}

/* モーダルのコンテンツ部分のテキストの指定 */
.modal_content p {
	margin: 1em 0;
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
	color: #ffffff;
	background-color: #ff701e;
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
	height: 30px;
	color: #ffffff;
	background-color: orange;
	border-radius: 5px;
}

.announce_flag p {
	font-size: 17px;
	margin: 0;
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
							class="box-link">
							<p>新規投稿</p> 
						</a>
					</div>

					<form action="<%=request.getContextPath()%>/announceSearch"
							method="POST">
						<div class="search-form">
							<input type="text" id="searchInput" name="keyword"
								placeholder="キーワードを入力"> 
							<button type="submit" aria-label="検索"></button>
							<input type="hidden" name="cmd" value="keyword">
						</div>
					</form>

					<div class="filter_box">
						<button type="button" class="modal_open js_modal_open">絞り込み</button>
						<div class="modal js_modal">
							<div class="modal_container">
								<div class="modal_close js_modal_close">×</div>
								<div class="modal_content js_modal_content">
									<form action="<%=request.getContextPath()%>/announceSearch"
										method="POST">
										<div>
											<input type="checkbox" id="important" value="1"
												name="announce_flag"> 
												<label for="important">重要記事</label>
											<input type="hidden" name="announce_flag" value="">
										</div>
										<div>
											<label for="category_select">カテゴリ</label> 
											<select id="category_select" name="category_code">
												<option value="">全カテゴリ</option>
												<%
												for (int i = 0; i < categoryList.size(); i++) {
													AnnounceCategory announceCategory = categoryList.get(i);
												%>
												<option value="1"><%= announceCategory.getCategory() %></option>
												<%
												}
												%>
											</select>
										</div>
										<div>
											<label for="start_date">開始日</label> 
											<input type="datetime-local" id="start_date" name="start_date">
										</div>
										<div>
											<label for="end_date">終了日</label> 
											<input type="datetime-local" id="end_date" name="end_date">
										</div>
										<input type="hidden" name="cmd" value="filter">
										<button type="submit">検索</button>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>

				<!-- タブの中身 -->
				<div class="container main_box">
					<%
					if (announceList != null) {
						for (int i = 0; i < announceList.size(); i++) {
					%>
					<div class="content_box">
						<div class="announce_box">
							<a
								href="<%=request.getContextPath()%>/announceDetail
								?announceId=<%=announceList.get(i).getAnnounceId()%>&cmd=detail"
								class="box_link">
								<div class="date_box">
									<p>
										<%
										timestamp = announceList.get(i).getRegistDate();
										%>
										<%=myFormat.monthDayFormat(timestamp)%>
									</p>
								</div>
								<div class="title_box">
									<p><%=announceList.get(i).getTitle()%></p>
								</div>
							</a>
						</div>
						<div class="category_box">
							<p>
								<%
								categoryId = announceList.get(i).getAnnounceCategoryId();
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
						int announceFlag = announceList.get(i).getAnnounceFlag();
						if (announceFlag == 1) {
						%>
						<div class="announce_flag">
							<p>重要！</p>
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
		open.addEventListener('click', modalOpen);

		function modalClose() {
			modal.classList.remove('is-active');
		}
		close.addEventListener('click', modalClose);

		function modalOut() {
			modal.classList.remove('is-active');
		}
		addEventListener('blur', modalOut);
	</script>
</body>
</html>