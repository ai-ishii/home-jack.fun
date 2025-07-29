<!--
/**
 * ホーム画面
 * 
 * 作成者：石田允彦
 * 
 * 作成日：2025/07/04
 * 最終更新日：2025/07/29
 */
-->

<%@page import="dao.AnnounceDAO"%>
<%@page import="util.MyFormat"%>
<%@page import="bean.Announce"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
ArrayList<Announce> importantList = (ArrayList<Announce>)request.getAttribute("important_list");
ArrayList<Announce> announceList = (ArrayList<Announce>)request.getAttribute("announce_list");
ArrayList<Announce> activityList = (ArrayList<Announce>)request.getAttribute("activity_list");

AnnounceDAO announceDAO = new AnnounceDAO();

MyFormat myformat = new MyFormat();
%>

<html>
<head>
<title></title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
<script src="<%=request.getContextPath()%>/js/script.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<style>
/*-----------------------------------------------------------------------------------*/
/*サイドバー表示*/
#sidebar {
	flex: 1;
	margin-left: 10px;
}

#announce {
	flex: 3;
}


/*テーブル表示*/
.announce-list {
	position: relative;
	list-style: none outside;
	margin: 0;
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
	margin: 0;
	min-width: 130px;
}

.announce-list .item .tag span {
	background: #999999;
	color: #ffffff;
	text-align: center;
	display: inline-block;
	padding: 5px 20px;
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
	color: #0000ff;
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

<body>
	<div id="wrap">
		<%@ include file="../common/header.jsp"%>

		<div id="main" class="container">
			<div class="flex">
				<div id="sidebar" class="container">
					<div class="calendar">
						<p>カレンダー</p>
						<iframe src="https://calendar.google.com/calendar/embed?height=300&wkst=1&ctz=Asia%2FTokyo&showPrint=0&src=dGVzdXRvdS5oYWppbWVAZ21haWwuY29t&src=amEuamFwYW5lc2UjaG9saWRheUBncm91cC52LmNhbGVuZGFyLmdvb2dsZS5jb20&color=%23039be5&color=%230b8043" style="border:solid 1px #777" width="300" height="300" frameborder="0" scrolling="no"></iframe>
					</div>
				</div>

				<div id="announce" class="container">
					<h2>重要なお知らせ</h2>
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
										<span><%= announceDAO.selectByCategory(importantList.get(i).getAnnounceCategoryId()) %></span>
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
						<a href="<%= request.getContextPath() %>/announce">
							<p class="list-link">一覧へ</p>
						</a>
					</div>
					
					<h2>最新のお知らせ</h2>
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
										<span><%= announceDAO.selectByCategory(announceList.get(i).getAnnounceCategoryId()) %></span>
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
						<a href="<%= request.getContextPath() %>/announce">
							<p class="list-link">一覧へ</p>
						</a>
					</div>
					
					<h2>最新のチーム活動</h2>
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
										<span><%= announceDAO.selectByCategory(activityList.get(i).getAnnounceCategoryId()) %></span>
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
						<a href="<%= request.getContextPath() %>/announce">
							<p class="list-link">一覧へ</p>
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>