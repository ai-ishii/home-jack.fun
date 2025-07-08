<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>お知らせ</title>
<link rel = "stylesheet" href = "<%= request.getContextPath() %>/css/style.css">
<style>
.tab {
	max-width: 90%;
	margin: 0 auto;
	margin-top: 120px;
}

/* タブメニュー */
.tab__menu {
	display: flex;
	align-items: flex-end; /* メニューを下揃え&高さを調整 */
	justify-content: center;
	min-height: 50px; /* メニュー切替時にタブがズレないように */
	padding: 0;
	margin: 0;
}

.tab__menu-item {
	list-style: none;
	width: 200px;
	padding: 8px 5px; /* メニューに高さを付ける */
	text-align: center;
	margin-right: 6px;
	background-color: #cdcdcd;
	border-top-left-radius: 10px;
	border-top-right-radius: 10px;
	cursor: pointer;
	transition: all .3s; /* アニメーション */
	z-index: 10;
}

.tab__menu-item:last-of-type {
	margin-right: 0px;
}

/* is-activeがついている時のスタイル */
.tab__menu-item.tab_panel001.is-active {
	background-color: rgba(48, 172, 249);
	color: #ffffff;
	padding: 12px 5px;
}

.tab__menu-item.tab_panel002.is-active {
	background-color: rgba(220, 30, 30);
	color: #ffffff;
	padding: 12px 5px;
}

.tab__menu-item.tab_panel003.is-active {
	background-color: rgba(90, 200, 90);
	color: #ffffff;
	padding: 12px 5px;
}

/* タブパネル */
.tab__panel {
	width: 100%;
}

.tab__panel-box {
	min-height: 400px; /* テキスト量が多くなっても対応できるように */
	padding: 10px 30px;
	border-radius: 10px;
}

.tab__panel-box001 {
	background-color: rgb(205, 246, 246);
	display: none;
}

.tab__panel-box002 {
	background-color: rgb(249, 227, 243);
	display: none;
}

.tab__panel-box003 {
	background-color: rgb(200, 248, 195);
	display: none;
}

/* is-showがついている時のスタイル */
.tab__panel-box.is-show {
	display: block;
}
</style>

</head>
<body>
	
	<%@include file = "../common/header.jsp" %>
	
	<div class="tab">
		<!-- タブ -->
		<ul class="tab__menu">
			<li class="tab__menu-item tab_panel001 is-active" data-tab="01">お知らせ</li>
			<li class="tab__menu-item tab_panel002" data-tab="02">チーム活動</li>
			<li class="tab__menu-item tab_panel003" data-tab="03">ナレッジベース</li>
		</ul>
		<!-- タブの中身 -->
		<div class="tab__panel">
			<div class="tab__panel-box tab__panel-box001 is-show" data-panel="01">
				<p class="tab__panel-text">初期表示のタブです。初期表示のタブです。初期表示のタブです。初期表示のタブです。初期表示のタブです。初期表示のタブです。初期表示のタブです。初期表示のタブです。</p>
			</div>
			<div class="tab__panel-box tab__panel-box002" data-panel="02">
				<p class="tab__panel-text">2枚目のタブです。2枚目のタブです。2枚目のタブです。2枚目のタブです。2枚目のタブです。2枚目のタブです。2枚目のタブです。2枚目のタブです。2枚目のタブです。2枚目のタブです。</p>
			</div>
			<div class="tab__panel-box tab__panel-box003" data-panel="03">
				<p class="tab__panel-text">3枚目のタブです。3枚目のタブです。3枚目のタブです。3枚目のタブです。3枚目のタブです。3枚目のタブです。3枚目のタブです。3枚目のタブです。3枚目のタブです。3枚目のタブです。</p>
			</div>
		</div>

		<script>

		'use strict'; /* 厳格にエラーをチェック */

		{ /* ローカルスコープ */

		// DOM取得
		const tabMenus = document.querySelectorAll('.tab__menu-item');
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
		  const tabList = e.currentTarget.closest('.tab__menu');
		  console.log(tabList);
		  const tabItems = tabList.querySelectorAll('.tab__menu-item');
		  console.log(tabItems);
		  // クリックされた要素の親要素の兄弟要素の子要素を取得
		  const tabPanelItems = tabList.
		  nextElementSibling.querySelectorAll('.tab__panel-box');
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
		
		<script src="<%= request.getContextPath() %>/js/script.js"></script>
</body>
</html>