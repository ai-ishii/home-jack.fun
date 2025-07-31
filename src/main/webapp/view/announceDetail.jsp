<!-- 
お知らせの詳細情報を表示するjsp

作成者 : 大北直弥

作成日 : 2025/07/14
更新日 : 2025/07/30
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="bean.Announce, java.util.ArrayList, java.text.SimpleDateFormat, java.sql.Timestamp, java.util.Date, util.MyFormat"%>

<%
Announce announce = (Announce) request.getAttribute("announce");
ArrayList<Announce> announceList = (ArrayList<Announce>) request.getAttribute("announceList");
int announceId = announce.getAnnounceId();
int announceNum = announceList.indexOf(announce);
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
#announce_box {
	display: flex;
	flex-direction: column;
	align-items: center;
	width: 80%;
	margin: 0 auto;
	background-color: whitesmoke;
}

.title_box {
	display: flex;
	align-items: center;
	position: relative;
	width: 100%;
	height: 150px;
	background-color: #ffffff;
	margin: 70px auto 0 auto;
	border-bottom: 3px solid #FFC465;
	border-top-right-radius: 20px;
	border-top-left-radius: 20px;
}

.title_box p {
	text-align: left;
	font-size: 30px;
	padding: 50px;
	margin: 0;
}

.category {
	position: absolute;
	top: -60px;
	right: 20px;
	min-width: 20px;
	height: 20px;
	color: #aaaaaa;
}

.category p {
	text-align: center;
	font-size: 17px;
	padding: 30px 0 0 0;
}

#content_box {
	display: flex;
	flex-direction: column;
	justify-content: center;
	width: 100%;
	min-height: 500px;
	background-color: #fff;
	margin: 0 auto 70px auto;
	border-bottom-right-radius: 10px;
	border-bottom-left-radius: 10px;
}

.text_box {
	width: 90%;
	min-height: 500px;
	padding: 10px 30px;
}

.text_box p {
	font-size: 16px;
	white-space: pre-line;
}

.info_box {
	display: flex;
	padding: 10px 30px;
	border-bottom: 3px solid #FFC465;
}
.info_box p {
	padding-right: 30px;
}

.like_box {
	display: flex;
	padding: 10px 30px;
}
</style>
</head>
<body>
	<div id="wrap">

		<!-- ヘッダー部分 -->
		<%@include file="../common/header.jsp"%>

		<!-- メイン部分 -->
		<div id="main" class="container">
			<div id="announce_box">
				<div class="title_box">
					<p><%=announce.getTitle()%></p>
					<div class="category">
						<p>
							<%
							categoryId = announce.getAnnounceCategoryId();
							if (categoryId == 1) {
								category = "お知らせ";
							} else if (categoryId == 2) {
								category = "チーム活動";
							} else {
								category = "ナレッジベース";
							}
							%>

							#<%=category%>
						</p>
					</div>
				</div>
				<div id="content_box">
					<div class="text_box">
						<p><%=announce.getText()%></p>
						<!-- できてないよ！ -->
						<p>#チーム活動</p>
					</div>

					<div class="info_box">
						<div>
							<p>
								<%
								timestamp = announce.getRegistDate();
								%>
								<%=myFormat.dateTimeFormat(timestamp)%>
							</p>
						</div>
						<div>
							<p><%=announce.getName()%></p>
						</div>
					</div>
					<div class="like_box">
						<p>いいね！</p>
						<!-- できてないよ！ -->
						<p>10,000</p>
					</div>
				</div>

				<a href="<%=request.getContextPath()%>/announce">一覧へ</a>

				<a href="<%=request.getContextPath()%>/announceDetail
					?announceId=<%=announce.getAnnounceId()%>&cmd=update">編集</a>

				<a href="<%=request.getContextPath()%>/announceDelete
					?announceId=<%=announceId%>">削除</a>

				<%
				if (announceNum > 0) {
					Announce beforeAnnounce = announceList.get(announceNum - 1);
					int beforeAnnounceId = beforeAnnounce.getAnnounceId();
				%>

				<a href="<%=request.getContextPath()%>/announceDetail
					?announceId=<%=beforeAnnounceId%>&cmd=detail">前の記事</a>

				<%
				}
				if (announceNum < announceList.size() - 1) {
				Announce nextAnnounce = announceList.get(announceNum + 1);
				int nextAnnounceId = nextAnnounce.getAnnounceId();
				%>
				
				<a href="<%=request.getContextPath()%>/announceDetail
					?announceId=<%=nextAnnounceId%>&cmd=detail">次の記事</a>

				<%
				}
				%>
			</div>
		</div>
	</div>

</body>
</html>
