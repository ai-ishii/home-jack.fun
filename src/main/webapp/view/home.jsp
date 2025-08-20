<%--
/**
 * ホーム画面
 * 
 * 作成者：石田允彦
 * 
 * 作成日：2025/07/04
 
 * 最終更新日：2025/08/20
 */
--%>

<%@page import="util.CommonTable"%>
<%@page import="dao.AnnounceDAO"%>
<%@page import="util.MyFormat"%>
<%@page import="bean.Announce"%>
<%@page import="bean.CategoryMap"%>
<%@page import="java.util.ArrayList"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
ArrayList<Announce> importantList = (ArrayList<Announce>)request.getAttribute("important_list");
ArrayList<Announce> announceList = (ArrayList<Announce>)request.getAttribute("announce_list");
ArrayList<Announce> activityList = (ArrayList<Announce>)request.getAttribute("activity_list");
ArrayList<CategoryMap> categoryList = (ArrayList<CategoryMap>)request.getAttribute("category_list");

AnnounceDAO announceDAO = new AnnounceDAO();

MyFormat myformat = new MyFormat();

Boolean profile = (Boolean) session.getAttribute("profile");
%>

<html>
<head>
<title>Home-Jack</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
<script src="<%=request.getContextPath()%>/js/script.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<style>
/*-----------------------------------------------------------------------------------*/
/*ホーム画面（body）*/
.home {
	width: 100%;
}

/*サイドバー表示*/
#sidebar {
	flex: 1;
	margin: 100px auto;
	width: 80%;
}

#announce {
	margin-right: auto;
	margin-left: auto;
	width: 80%;
}

/*「カレンダー」*/
.calendar p {
	display: inline-block;
	padding: 5px 10px;
	margin-bottom: 0;
	border-radius: 10px 10px 0 0;
	background-color: sienna;
	color: snow;
	font-size: 30px;
}

.overflow {
	overflow: hidden;
}

/*テーブル表示*/
.announce-list {
	position: relative;
	list-style: none outside;
	margin-bottom: 30px;
	padding: 0;
	width: 100%;
	z-index: 10;
}

.announce-list li {
	list-style: none;
}

.announce-list .item {
	width: 100%;
}

.announce-list .item a {
	display: flex;
	flex-wrap: wrap;
	flex-wrap: nowrap;
	text-decoration: none;
	align-items: center;
	color: #333333;
	border-bottom: 1px solid #cccccc;
	padding: 20px 0;
	width: 100%;
}

.announce-list .item:first-child a {
	border-top: 1px solid #cccccc;
	text-decoration: none;
}

.announce-list .item .date {
	margin: 0;
	min-width: 150px;
	color: #999999;
}

.announce-list .item .tag {
	margin-right: 20px;
	text-align: center;
	min-width: 100px;
}

.announce-list .item .tag span {
	color: #ffffff;
	display: inline-block;
	padding: 5px;
	font-size: 12px;
	line-height: 1;
}

.announce-list .item .article {
	width: 650px;
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}

.announce-list .item .title {
	margin: 0;
	padding: 0 auto;
	width: 100%;
}

.announce-list .item .name {
	position: relative;
	margin: -5px 0 0 0;
	min-width: 140px;
	padding: 0 20px 0 0;
	color: #999999;
}

.announce-list .item:hover a {
	background-color: #eeeeee;
}

.announce-list .item a:hover .title {
	color: chocolate;
}

.linkToAnnounce {
	display: inline-block;
	color: #303030;
	text-decoration: none;
}

h2 {
	padding-left: 15px;
	border-left: solid 5px sienna;
}

/*お知らせ表示部分*/
ul {
	padding: 0;
}

/*一覧へ飛ぶリンク（a）*/
.list-link {
	margin-left: 900px;
	color: #303030;
	font-weight: bold;
	text-decoration: none;
	vertical-align: bottom;
}

.list-link:hover {
	color: sienna;
}

/*一覧へのリンク横についてる右矢印アイコン*/
.linkIcon {
	margin-bottom: 2px;
    margin-left: 8px;
    width: 20px;
    height: 15px;
    vertical-align: bottom;
}

.announce

@media screen and (max-width: 767px) {
	.announce-list .item a {
		flex-wrap: wrap;
	}
	.announce-list .item .date {
		min-width: 100px;
	}
	.announce-list .item .title {
		margin-top: 10px;
	}
}


/*-----------------------------------------------------------------------------------*/
</style>

<body class="home">
	<div id="wrap">
		<%@ include file="../common/header.jsp"%>

		<div id="main" class="container">
		
		<%
		if (Boolean.FALSE.equals(profile)){
		%>
			<div>
				プロフィールが未登録です。
				<a href="<%=request.getContextPath()%>/view/userRegister.jsp">こちらから登録してください。</a>
			</div>
			
		<%
		}
		%>
		
			<div class="overflow">
				
				<div id="announce" class="container">
					<a class="linkToAnnounce" href="<%= request.getContextPath() %>/announce">
						<h2>重要なお知らせ</h2>
					</a>
					<div class="announce-list">
						<ul>
							<%
							if (importantList == null || importantList.size() == 0) {
							%>
							<p>重要なお知らせはありません</p>
							
							<%
							} else {
								for (int i = 0; i < importantList.size(); i++){
							%>
						
							<li class="item">
								<a href="<%= request.getContextPath() %>/announceDetail?cmd=detail&announceId=<%= importantList.get(i).getAnnounceId() %>">
									<p class="date"><%= myformat.dateFormat(importantList.get(i).getRegistDate()) %></p>
									<p class="tag">
										<span><%= CommonTable.selectCategory(importantList.get(i).getAnnounceCategoryId(), categoryList) %></span>
									</p>
									<div class="title">
										<p class="article"><%= importantList.get(i).getTitle() %></p>
										<p class="name"><%= importantList.get(i).getName() %></p>
									</div>
								</a>
							</li>
							
							<%
								}
							}
							%>
						</ul>
						<a class="list-link" href="<%= request.getContextPath() %>/announce">一覧へ
						<img class="linkIcon" src="<%= request.getContextPath() %>/img/linkIcon-right.png" alt="リンク用アイコン">
						</a>
					</div>
					<a class="linkToAnnounce" href="<%= request.getContextPath() %>/announce">
					<h2>最新のお知らせ</h2>
					</a>
					<div class="announce-list">
						<ul>
							<%
							if (announceList == null || announceList.size() == 0) {
							%>
							<p>最新のお知らせはありません</p>
							
							<%
							} else {
								for (int i = 0; i < announceList.size(); i++){
							%>
						
							<li class="item">
								<a href="<%= request.getContextPath() %>/announceDetail?cmd=detail&announceId=<%= announceList.get(i).getAnnounceId() %>">
									<p class="date"><%= myformat.dateFormat(announceList.get(i).getRegistDate()) %></p>
									<p class="tag">
										<span><%= CommonTable.selectCategory(announceList.get(i).getAnnounceCategoryId(), categoryList) %></span>
									</p>
									<div class="title">
										<p class="article"><%= announceList.get(i).getTitle() %></p>
										<p class="name"><%= announceList.get(i).getName() %></p>
									</div>
								</a>
							</li>
							
							<%
								}
							}
							%>
						</ul>
						<a class="list-link" href="<%= request.getContextPath() %>/announce">一覧へ
						<img class="linkIcon" src="<%= request.getContextPath() %>/img/linkIcon-right.png" alt="リンク用アイコン">
						</a>
					</div>
					<a class="linkToAnnounce" href="<%= request.getContextPath() %>/announce">
					<h2>最新のチーム活動</h2>
					</a>
					<div class="announce-list">
						<ul>
							<%
							if (activityList == null || activityList.size() == 0) {
							%>
							<p>最新のチーム活動はありません</p>
							
							<%
							} else {
								for (int i = 0; i < activityList.size(); i++){
							%>
						
							<li class="item">
								<a href="<%= request.getContextPath() %>/announceDetail?cmd=detail&announceId=<%= activityList.get(i).getAnnounceId() %>">
									<p class="date"><%= myformat.dateFormat(activityList.get(i).getRegistDate()) %></p>
									<p class="tag">
										<span><%= CommonTable.selectCategory(activityList.get(i).getAnnounceCategoryId(), categoryList) %></span>
									</p>
									<div class="title">
										<p class="article"><%= activityList.get(i).getTitle() %></p>
										<p class="name"><%= activityList.get(i).getName() %></p>
									</div>
								</a>
							</li>
							<%
								}
							}
							%>
						</ul>
						<a class="list-link" href="<%= request.getContextPath() %>/announce">一覧へ
						<img class="linkIcon" src="<%= request.getContextPath() %>/img/linkIcon-right.png" alt="リンク用アイコン">
						</a>
					</div>
				</div>
				<div id="sidebar" class="container">
					<div class="calendar">
						<p>カレンダー</p>
						<iframe src="https://calendar.google.com/calendar/embed?height=300&wkst=1&ctz=Asia%2FTokyo&showPrint=0&src=dGVzdXRvdS5oYWppbWVAZ21haWwuY29t&src=amEuamFwYW5lc2UjaG9saWRheUBncm91cC52LmNhbGVuZGFyLmdvb2dsZS5jb20&color=%23039be5&color=%230b8043" style="border:solid 5px sienna" width="100%" height="100%" frameborder="0" scrolling="no"></iframe>
					</div>
				</div>
				
			</div>
		</div>
	</div>
	
	<script>
		// 必要な要素を取得
		const spanList = document.querySelectorAll(".tag");

		// カテゴリーごとに背景色を変更
		for (let i = 0; i < spanList.length; i++) {
			if(spanList[i].textContent.trim() == "お知らせ") {
				spanList[i].style.backgroundColor = "olivedrab";
			} else if (spanList[i].textContent.trim() == "チーム活動") {
				spanList[i].style.backgroundColor = "palevioletred";
			} else if (spanList[i].textContent.trim() == "ナレッジベース") {
				spanList[i].style.backgroundColor = "steelblue";
			} else if (spanList[i].textContent.trim() == "その他") {
				spanList[i].style.backgroundColor = "dimgray";
			}
		}
	</script>
</body>
</html>