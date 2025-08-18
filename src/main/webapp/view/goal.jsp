<!-- 
　個人目標確認機能

　作成者：月向亮太

　作成日：7月23日

　最終更新日：8月18日

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
String groupName = (String) request.getAttribute("groupName");
ArrayList<String> groupCodeList = (ArrayList<String>) request.getAttribute("groupCodeList");
ArrayList<String> userNameList = (ArrayList<String>) request.getAttribute("userNameList");
ArrayList<Integer> userIdList = (ArrayList<Integer>) request.getAttribute("userIdList");

// JSPの上部で、userListから重複しないチームのリスト（Map）を作成
// Map<キーの型, 値の型>
//Map<Integer, String> teamMap = new LinkedHashMap<>();
//if (userList != null) {
//for (User user : userList) {
//teamMap.put(user.getDepartmentId(), "第" + user.getDepartmentId() + "事業部");
//}
//}
//pageContext.setAttribute("teamMap", teamMap);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>個人目標一覧 | Home-Jack</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<script src="${pageContext.request.contextPath}/js/script.js "></script>

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
	padding: 50px;
	height: 500px;
	background-color: cornsilk;
	border: solid 3px orange;
}

/* 所属している写真の名前一覧（a） */
.nameLink {
	color: inherit;
	font-size: 20px;
	line-height: 2.0;
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
						<%
						for (int i = 0; i < groupCodeList.size(); i++) {
							if (groupCodeList.get(i).equals("BS1001")) {
						%>
						<a class="group"
							href="<%=request.getContextPath()%>/goal?groupCode=<%=groupCodeList.get(i)%>&d=1&g=2">
							<li class="tabItem"><%=groupCodeList.get(i)%></li>
						</a>
						<%
						} else if (groupCodeList.get(i).equals("BS1002")) {
						%>
						<a class="group"
							href="<%=request.getContextPath()%>/goal?groupCode=<%=groupCodeList.get(i)%>&d=1&g=3">
							<li class="tabItem"><%=groupCodeList.get(i)%></li>
						</a>
						<%
						} else if (groupCodeList.get(i).equals("BS1003")) {
						%>
						<a class="group"
							href="<%=request.getContextPath()%>/goal?groupCode=<%=groupCodeList.get(i)%>&d=1&g=4">
							<li class="tabItem"><%=groupCodeList.get(i)%></li>
						</a>
						<%
						} else if (groupCodeList.get(i).equals("BS1004")) {
						%>
						<a class="group"
							href="<%=request.getContextPath()%>/goal?groupCode=<%=groupCodeList.get(i)%>&d=1&g=5">
							<li class="tabItem"><%=groupCodeList.get(i)%></li>
						</a>
						<%
						} else if (groupCodeList.get(i).equals("BS2001")) {
						%>
						<a class="group"
							href="<%=request.getContextPath()%>/goal?groupCode=<%=groupCodeList.get(i)%>&d=2&g=2">
							<li class="tabItem"><%=groupCodeList.get(i)%></li>
						</a>
						<%
						} else if (groupCodeList.get(i).equals("BS2002")) {
						%>
						<a class="group"
							href="<%=request.getContextPath()%>/goal?groupCode=<%=groupCodeList.get(i)%>&d=2&g=3">
							<li class="tabItem"><%=groupCodeList.get(i)%></li>
						</a>
						<%
						} else if (groupCodeList.get(i).equals("NX1000")) {
						%>
						<a class="group"
							href="<%=request.getContextPath()%>/goal?groupCode=<%=groupCodeList.get(i)%>&d=4&g=1">
							<li class="tabItem"><%=groupCodeList.get(i)%></li>
						</a>
						<%
						} else if (groupCodeList.get(i).equals("MG1000")) {
						%>
						<a class="group"
							href="<%=request.getContextPath()%>/goal?groupCode=<%=groupCodeList.get(i)%>&d=5&g=1">
							<li class="tabItem"><%=groupCodeList.get(i)%></li>
						</a>
						<%
						} else if (groupCodeList.get(i).equals("SA1000")) {
						%>
						<a class="group"
							href="<%=request.getContextPath()%>/goal?groupCode=<%=groupCodeList.get(i)%>&d=3&g=1">
							<li class="tabItem"><%=groupCodeList.get(i)%></li>
						</a>
						<%
						}
						}
						%>
					</ul>

					<!-- 名前を表示するパネル -->
					<div class="tabPanel">
						<!-- ここに選択された所属社員の名前が一覧で表示される -->
						<h2><%=groupName%></h2>
						<%
						for (int i = 0; i < userNameList.size(); i++) {
						%>
						<!-- 
						<div class="nameListArea"userNameList.get(i)(i) %></div>
						 -->
						<a class="nameLink"
							href="<%=request.getContextPath()%>/goalConfirm?user_id=<%=userIdList.get(i)%>&cmd=manager">
							<%=userNameList.get(i)%>
						</a> <br>
						<%
						}
						%>
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
	let groupCode = "<%=groupCode%>";

	// 必要な要素を取得
	const tabItems = document.querySelectorAll(".tabItem");

	// インデックス
	let index = 0;

	document.addEventListener(('DOMContentLoaded'), () => {
		// ページ読み込み時にアクティブをすべて削除
		tabItems.forEach((item) => {
			item.classList.remove("active");
		});

		// 最初のアクセス時はグループコードがnullなので、最初はBS1001をアクティブ
		if (groupCode == "null") {
			console.log(groupCode);
			tabItems[0].classList.add("active");
		}

		// 受け取ったパラメータに応じてアクティブにするタブを切り替え
		if (groupCode == "BS1001") {
			tabItems[index].classList.add("active");
		} else if (groupCode == "BS1002") {
			tabItems[index + 1].classList.add("active");
		} else if (groupCode == "BS1003") {
			tabItems[index + 2].classList.add("active");
		} else if (groupCode == "BS1004") {
			tabItems[index + 3].classList.add("active");
		} else if (groupCode == "BS2001") {
			tabItems[index + 4].classList.add("active");
		} else if (groupCode == "BS2002") {
			tabItems[index + 5].classList.add("active");
		} else if (groupCode == "NX1000") {
			tabItems[index + 6].classList.add("active");
		} else if (groupCode == "MG1000") {
			tabItems[index + 7].classList.add("active");
		} else if (groupCode == "SA1000") {
			tabItems[index + 8].classList.add("active");
		}
	});
	</script>

</body>
</html>