<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, java.text.SimpleDateFormat, java.sql.Timestamp, java.util.Date, bean.Announce, util.MyFormat"%>

<%
ArrayList<Announce> announceList = (ArrayList<Announce>) request.getAttribute("announceList");
MyFormat myFormat = new MyFormat();
long millis = System.currentTimeMillis();
Timestamp timestamp = new Timestamp(millis);
%>
<!DOCTYPE html>
<html>
<head>
<title>お知らせ</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<style>
.tab {
	display: flex;
	flex-direction: row;
	max-width: 90%;
	margin: 0 auto;
	margin-top: 120px;
}

/* タブメニュー */
.tab_menu {
	display: flex;
	align-items: flex-start;
	justify-content: flex-center;
	min-height: 50px; /* メニュー切替時にタブがズレないように */
	padding: 0;
	margin: 0;
	flex-direction: column;
}

.tab_menu-item {
	list-style: none;
	width: 200px;
	padding: 8px 5px; /* メニューに高さを付ける */
	text-align: center;
	margin: 5px 10px;
	background-color: #cdcdcd;
	border-radius: 20px;
	cursor: pointer;
	transition: all .3s; /* アニメーション */
	z-index: 10;
}

.tab_menu-item:last-of-type {
	margin-right: 0px;
}

/* is-activeがついている時のスタイル */
.tab_menu-item.tab_panel001.is-active {
	background-color: #dd9933;
	color: #ffffff;
	padding: 12px 5px;
}

.tab_menu-item.tab_panel002.is-active {
	background-color: rgba(48, 172, 249);
	color: #ffffff;
	padding: 12px 5px;
}

.tab_menu-item.tab_panel003.is-active {
	background-color: rgba(220, 30, 30);
	color: #ffffff;
	padding: 12px 5px;
}

.tab_menu-item.tab_panel004.is-active {
	background-color: rgba(90, 200, 90);
	color: #ffffff;
	padding: 12px 5px;
}

/* タブパネル */
.tab_panel {
	width: 100%;
}

.tab_panel-box {
	min-height: 400px; /* テキスト量が多くなっても対応できるように */
	padding: 10px 30px;
	border-radius: 10px;
}

.tab_panel-box001 {
	background-color: whitesmoke;
	display: none;
}

.tab_panel-box002 {
	background-color: rgb(205, 246, 246);
	display: none;
}

.tab_panel-box003 {
	background-color: rgb(249, 227, 243);
	display: none;
}

.tab_panel-box004 {
	background-color: rgb(200, 248, 195);
	display: none;
}

/* is-showがついている時のスタイル */
.tab_panel-box.is-show {
	display: block;
}

.announce_box {
	display: flex;
	justify-content: center;
	margin: 5px;
}

.date_box {
	min-height: 100px;
	width: 20%;
	background-color: #ffffff;
	padding: 0 20px;
	border-top-left-radius: 10px;
	border-bottom-left-radius: 10px;
}

.date_box p {
	text-align: center;
	font-size: 50px;
	color: #000000;
	padding: 10px 0;
	margin: 0;
}

.category_box {
	width: 10%;
	background-color: whitesmoke;
}

.category_box p {
	color: #aaaaaa;
	font-size: 17px;
	text-align: center;
	margin: 0;
}

.content_box {
	min-height: 100px;
	width: 70%;;
	background-color: #ffffff;
	border-top-right-radius: 10px;
	border-bottom-right-radius: 10px;
}

.content_box p {
	text-align: left;
	font-size: 22px;
	color: #000000;
	padding: 30px 0;
	margin: 0;
}

.blank_box {
	height: 30px;
}
</style>

</head>
<body>

	<%@include file="../common/header.jsp"%>

	<div class="tab">
		<!-- タブ -->
		<ul class="tab_menu">
			<li class="tab_menu-item tab_panel001 is-active" data-tab="01">すべてのお知らせ</li>
			<li class="tab_menu-item tab_panel002" data-tab="02">お知らせ</li>
			<li class="tab_menu-item tab_panel003" data-tab="03">チーム活動</li>
			<li class="tab_menu-item tab_panel004" data-tab="04">ナレッジベース</li>
		</ul>
		<!-- タブの中身 -->
		<div class="tab_panel">
			<div class="tab_panel-box tab_panel-box001 is-show" data-panel="01">
				<%
				for (int i = 0; i < announceList.size(); i++) {
				%>
				<div class="announce_box">
					<div class="date_box">
						<p>
						<%
						timestamp = announceList.get(i).getRegistDate();
						%>
						<%=myFormat.monthDayFormat(timestamp) %>
						</p>
					</div>
					<div class="content_box">
						<p><%=announceList.get(i).getTitle()%></p>
					</div>
					<div class="category_box">
						<p>#お知らせ</p>
					</div>
				</div>
				<%
				}
				%>
				<div class="announce_box">
					<div class="date_box">
						<p>7/7</p>
					</div>
					<div class="content_box">
						<p>タイトル</p>
					</div>
					<div class="category_box">
						<p>#お知らせ</p>
					</div>
				</div>
			</div>
			<div class="tab_panel-box tab_panel-box002" data-panel="02">
				<div class="blank_box"></div>
				<div class="announce_box">
					<div class="date_box">
						<p>7/7</p>
					</div>
					<div class="category_box">
						<p>お知らせ</p>
					</div>
					<div class="content_box">
						<p>タイトル</p>
					</div>
				</div>
			</div>
			<div class="tab_panel-box tab_panel-box003" data-panel="03">
				<p class="tab_panel-text">2枚目のタブです。2枚目のタブです。2枚目のタブです。2枚目のタブです。2枚目のタブです。2枚目のタブです。2枚目のタブです。2枚目のタブです。2枚目のタブです。2枚目のタブです。</p>
			</div>
			<div class="tab_panel-box tab_panel-box004" data-panel="04">
				<p class="tab_panel-text">3枚目のタブです。3枚目のタブです。3枚目のタブです。3枚目のタブです。3枚目のタブです。3枚目のタブです。3枚目のタブです。3枚目のタブです。3枚目のタブです。3枚目のタブです。</p>
			</div>
		</div>
	</div>

	<script>

		'use strict'; /* 厳格にエラーをチェック */

		{ /* ローカルスコープ */

		// DOM取得
		const tabMenus = document.querySelectorAll('.tab_menu-item');
		console.log(tabMenus);

		// イベント付加
		tabMenus.forEach((tabMenu) => {
		  tabMenu.addEventListener('click', tabSwitch);
		})

		// イベントの処理
		function tabSwitch(e) {

		  // クリックされた要素のデータ属性を取得
		  const tabTargetData = e.currentTarget.dataset.tab;
		  // クリックされた要素の親要素と、その子要素を取得
		  const tabList = e.currentTarget.closest('.tab_menu');
		  console.log(tabList);
		  const tabItems = tabList.querySelectorAll('.tab_menu-item');
		  console.log(tabItems);
		  // クリックされた要素の親要素の兄弟要素の子要素を取得
		  const tabPanelItems = tabList.
		  nextElementSibling.querySelectorAll('.tab_panel-box');
		  console.log(tabPanelItems);

		  // クリックされたtabの同階層のmenuとpanelのクラスを削除
		  tabItems.forEach((tabItem) => {
		    tabItem.classList.remove('is-active');
		  })
		  tabPanelItems.forEach((tabPanelItem) => {
		    tabPanelItem.classList.remove('is-show');
		  })

		  // クリックされたmenu要素にis-activeクラスを付加
		  e.currentTarget.classList.add('is-active');
		  // クリックしたmenuのデータ属性と等しい値を持つパネルにis-showクラスを付加
		  tabPanelItems.forEach((tabPanelItem) => {
		    if (tabPanelItem.dataset.panel ===  tabTargetData) {
		      tabPanelItem.classList.add('is-show');
		    }
		  })

		}

		}

		</script>

</body>
</html>