<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.util.ArrayList, java.text.SimpleDateFormat, java.sql.Timestamp, java.util.Date, bean.Announce, util.MyFormat"%>

<%
ArrayList<Announce> announceList = (ArrayList<Announce>) request.getAttribute("announceList");
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
	width: 90%;
	margin: 0 auto;
	margin-top: 120px;
}

/* タブメニュー */
.tab_menu {
	display: flex;
	flex-direction: column;
}

.tab_menu-item {
	width: 80%;
	padding: 8px 5px; /* メニューに高さを付ける */
	text-align: center;
	margin: 5px 10px;
	background-color: #cdcdcd;
	border-radius: 20px;
}

.tab_panel-box {
	min-height: 400px; /* テキスト量が多くなっても対応できるように */
	padding: 10px;
	border-radius: 10px;
}

.main_box {
	display: flex;
	flex-direction: column;
	align-items: center;
}

.content_box {
	display: flex;
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

.blank_box {
	height: 30px;
}
</style>

</head>
<body>
	<div id="wrap">

		<!-- ヘッダー部分 -->
		<%@include file="../common/header.jsp"%>

		<!-- メイン部分 -->
		<div id="main" class="container">
			<div class="tab">
				<!-- タブ -->
				<div class="tab_menu">
					<div class="tab_menu-item">
						<a href="<%=request.getContextPath()%>/view/announceRegister.jsp">新規投稿</a>
					</div>

					<form action="<%=request.getContextPath()%>/announceSearch"
						method="GET">
						<div>
							<input type="text" id="searchInput" name="keyword"
								placeholder="キーワードを入力してください"> <input type="hidden"
								name="cmd" value="keyword">
							<button type="submit">検索</button>
						</div>
					</form>


					<form action="<%=request.getContextPath()%>/announceSearch"
						method="GET">
						<div>
							<input type="hidden" name="announceFlag" value=""> <input
								type="checkbox" id="important" value="1" name="announceFlag">
							<label for="important">重要記事</label>
						</div>
						<div>
							<label for="categorySelect">重要記事</label> <select
								id="categorySelect" name="categoryId">
								<option value="">全カテゴリ</option>
								<option value="1">お知らせ</option>
								<option value="2">チーム活動</option>
								<option value="3">ナレッジベース</option>
								<option value="9">その他</option>
							</select>
						</div>
						<div>
							<label for="startDate">開始日</label>
								<input type="datetime-local" id="startDate" name="startDate">
							<label for="endDate">終了日</label>
								<input type="datetime-local" id="endDate" name="endDate">
						</div>
						<input type="hidden" name="cmd" value="filter">
						<button type="submit">検索</button>
					</form>
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
								href="<%=request.getContextPath()%>/detailAnnounce?announceId=<%=announceList.get(i).getAnnounceId()%>&cmd=detail"
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
					</div>
					<%
					}
					}
					%>
				</div>
			</div>
		</div>
	</div>



</body>
</html>