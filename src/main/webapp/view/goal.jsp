<!-- 
　個人目標確認機能

　作成者：月向亮太

　作成日：7月23日

　最終更新日：8月1日

　第〇事業部第〇グループと表示させなければならないのですが、
"第〇グループ"を表示する機能を作り忘れてました。
ごめんなさい。
 -->
<%@page contentType="text/html; charset=UTF-8"%>
<%@page
	import="java.util.ArrayList,java.util.Map,java.util.LinkedHashMap,bean.User"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
// サーブレットから渡されたuserListを取得
ArrayList<User> userList = (ArrayList<User>) request.getAttribute("userList");

// JSPの上部で、userListから重複しないチームのリスト（Map）を作成
// Map<キーの型, 値の型>
Map<Integer, String> teamMap = new LinkedHashMap<>();
if (userList != null) {
	for (User user : userList) {
		teamMap.put(user.getDepartmentId(), "第" + user.getDepartmentId() + "事業部");
	}
}
pageContext.setAttribute("teamMap", teamMap);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>個人目標一覧 | Home-Jack</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<script src="${pageContext.request.contextPath}/js/script.js "></script>

<script>

</script>
<style>
/* 所属している社員一覧が表示されるエリア（div） */
.nameList {
	margin-top: 50px;
	margin-right: auto;
	margin-left: auto;
	width: 80%;
}

/* タブ親（ul） */
.tabList {
	padding-left: 0;
	margin: 0;
}

/* タブ（li） */
.tabItem {
	display: inline-block;
	padding: 10px 12px;
	border-width: 3px 3px 0 3px;
	border-style: solid;
	border-color: orange;
	border-radius: 10px 10px 0 0;
	font-weight: bold;
	list-style: none;
	letter-spacing: 1px;
}

.tabItem:hover {
	background-color: cornsilk;
	cursor: pointer;
}

/* タブがアクティブなときはスタイルを変える */
.tabItem.active {
	background-color: orange;
	color: white;
}

/* グループのタブ内のリンク（a） */
.group {
	color: inherit;
	text-decoration: none;
}

/* 所属している社員の名前一覧が表示されるエリア（div） */
.tabPanel {
	display: none; /*基本的には非表示*/
	padding: 50px;
	height: 500px;
	background-color: cornsilk;
	border: solid 3px orange;
}

/* activeがついているときだけ表示 */
.tabPanel.active {
	display: block;
}
</style>

</head>
<body>
	<div id="wrap">
		<%@ include file="../common/header.jsp"%>

		<!-- メイン部分 -->
		<div id="main" class="container">

			<div class="Goaltitle">
				<h1 style="text-align: center">チーム内個人目標一覧</h1>

				<!-- 所属社員一覧 -->
				<div class="nameList">
					<!-- 部署のタブ -->
					<ul class="tabList">
						<li class="tabItem active">
							<!-- おそらくの遷移先 たぶんここでサーブレットに遷移して、所属社員の名前をDAOで取ってくる --> <!-- <%= request.getContextPath() %>/view/goal?groupCode=BS1001 -->
							<a class="group" href="">BS1001</a>
						</li>
						<li class="tabItem"><a class="group" href="">BS1002</a></li>
						<li class="tabItem"><a class="group" href="">BS1003</a></li>
						<li class="tabItem"><a class="group" href="">BS1004</a></li>
						<li class="tabItem"><a class="group" href="">BS1005</a></li>
						<li class="tabItem"><a class="group" href="">BS2001</a></li>
						<li class="tabItem"><a class="group" href="">BS2002</a></li>
						<li class="tabItem"><a class="group" href="">NX1000</a></li>
						<li class="tabItem"><a class="group" href="">MG1000</a></li>
						<li class="tabItem"><a class="group" href="">SA1000</a></li>
					</ul>

					<!-- 名前を表示するパネル（BS1001） -->
					<div class="tabPanel active">
						<!-- ここに選択された所属の社員の名前が一覧で表示される -->
						いちのいちです
					</div>
					<!-- 名前を表示するパネル（BS1002） -->
					<div class="tabPanel">
						<!-- ここに選択された所属の社員の名前が一覧で表示される -->
						いちのにです
					</div>
					<!-- 名前を表示するパネル（BS1003） -->
					<div class="tabPanel">
						<!-- ここに選択された所属の社員の名前が一覧で表示される -->
						いちのさんです
					</div>
					<!-- 名前を表示するパネル（BS1004） -->
					<div class="tabPanel">
						<!-- ここに選択された所属の社員の名前が一覧で表示される -->
						いちのよんです
					</div>
					<!-- 名前を表示するパネル（BS1005） -->
					<div class="tabPanel">
						<!-- ここに選択された所属の社員の名前が一覧で表示される -->
						いちのごです
					</div>
					<!-- 名前を表示するパネル（BS2001） -->
					<div class="tabPanel">
						<!-- ここに選択された所属の社員の名前が一覧で表示される -->
						にのいちです
					</div>
					<!-- 名前を表示するパネル（BS2002） -->
					<div class="tabPanel">
						<!-- ここに選択された所属の社員の名前が一覧で表示される -->
						にのにです
					</div>
					<!-- 名前を表示するパネル（NX1000） -->
					<div class="tabPanel">
						<!-- ここに選択された所属の社員の名前が一覧で表示される -->
						ねくすといのべーしょんです
					</div>
					<!-- 名前を表示するパネル（MG1000） -->
					<div class="tabPanel">
						<!-- ここに選択された所属の社員の名前が一覧で表示される -->
						けいえいかんりです
					</div>
					<!-- 名前を表示するパネル（SA1000） -->
					<div class="tabPanel">
						<!-- ここに選択された所属の社員の名前が一覧で表示される -->
						えいぎょうです
					</div>
				</div>

			</div>
		</div>
	</div>

	<%
	// 変数受け渡し
	String groupCode = request.getParameter("groupCode");
	%>

	<script>
	// 変数受け渡し
	const groupCode = '<%= groupCode %>';
	
	// 必要な要素を取得
	const tabItems = document.querySelectorAll(".tabItem");
	const groupLink = document.querySelectorAll(".group");
	const tabPanels = document.querySelectorAll(".tabPanel");

	tabItems.forEach((tabItem) => {
		// タブをクリックしたら
		tabItem.addEventListener('click', () => {
			// 一度各タブをすべて非アクティブにする
			tabItems.forEach((t) => {
				t.classList.remove("active");
			});

			for (let i = 0; i < groupLink.length; i++) {
				// クリックされたタブをアクティブにする
				if (groupCode == groupLink[i].textContent) {
				tabItems[i].classList.add("active");
				}
			}

			// タブに合わせてパネルもアクティブにする
			for (let i = 0; i < tabItems.length; i++) {
				if (tabItems[i].classList.contains("active")) {
					// 一度各タブをすべて非アクティブにする
					tabPanels.forEach((tabPanel) => {
						tabPanel.classList.remove("active");
					});
					tabPanels[i].classList.add("active");
				}
			}
		});
	});
	</script>

</body>
</html>