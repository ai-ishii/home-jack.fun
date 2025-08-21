<!-- 
お知らせの詳細情報を表示するjsp

作成者 : 大北直弥

作成日 : 2025/07/14
更新日 : 2025/08/21
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
<title>お知らせ | Home-Jack</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<script src="<%=request.getContextPath()%>/js/script.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Kosugi+Maru&display=swap')
	;

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
	align-items: center;
	padding: 10px 30px;
}

.editButton {
	display: inline-block;
	padding: 8px 16px;
	background-color: #6eddb3;
	border: 3px solid #6eddb3;
	border-radius: 5px;
	text-decoration: none;
	text-align: center;
	cursor: pointer;
	position: absolute;
	top: -60px;
	right: 20px;
}

*, *:before, *:after {
	-webkit-box-sizing: inherit;
	box-sizing: inherit;
}

/* アイコン */
.memo {
	display: inline-block;
	vertical-align: middle;
	stroke: #fff;
	fill: #fff;
}

/* ボタンの文字 */
.editText {
	vertical-align: middle;
	font-family: "Kosugi Maru", sans-serif;
	font-size: 21px;
	font-weight: 300;
	color: #fff;
}

.editButton:hover {
	background-color: #fff;
	border: 3px solid #6eddb3;
}

.editButton:hover .memo {
	stroke: #6eddb3;
	fill: #6eddb3;
}

.editButton:hover .editText {
	color: #6eddb3;
}

/* aタグの初期CSSのリセット(左) */
.jackResetL {
	text-decoration: none;
	color: #000;
}

/* aタグの初期CSSのリセット(右) */
.jackResetR{
text-decoration: none;
color: #000;
}

/* 矢印の枠 */
/* marginとかは自分で削ったり足したりしてくださいな */
.yoruArrow {
	align-items: center;
	height: 30px;
	width: 85%;
	margin: 30px auto 0;
}

/* 矢印 */
.arrow {
	display: inline-block;
	vertical-align: middle;
	transition: transform 0.5s ease;
	overflow: visible; /* はみ出た内容を表示させる */
}

/* 矢印文字 */
.beaf {
	height: 100%;
	font-family: "Yomogi", cursive;
	font-size: 25px;
}

/* 矢印ホバー時の動き(左) */
.jackResetL:hover svg path {
	transform: translateX(-10px);
	stroke: #f9de95;
	fill: #f9de95;
}

/* 矢印ホバー時の動き(右) */
.jackResetR:hover svg path {
	transform: translateX(10px);
	stroke: #f9de95;
	fill: #f9de95;
}

.links {
	width: 100%;
    height: 100px;
}

.prev, .next {
	width: 30%;
}

.next {
	text-align: right;
}

.list {
	width: 40%;
    text-align: center;
    vertical-align: bottom;
}

/* アイコン */
.memo {
	display: inline-block;
	vertical-align: middle;
	stroke: #fff;
	fill: #fff;
}

/* ボタンの文字 */
.listText {
	vertical-align: middle;
	font-family: "Kosugi Maru", sans-serif;
	font-size: 21px;
	font-weight: 300;
	color: #fff;
}

.listButton {
	display: inline-block;
	padding: 8px 16px;
	background-color: #fdd35c;
	border: 3px solid #fdd35c;
	border-radius: 5px;
	text-decoration: none;
	text-align: center;
	cursor: pointer;
}

.listButton:hover {
	background-color: #fff;
	border: 3px solid #fdd35c;
}

.listButton:hover .memo {
	stroke: #fdd35c;
	fill: #fdd35c;
}

.listButton:hover .listText {
	color: #fdd35c;
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
						<p class="categoryTag">
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
					<a class="editButton"
						href="<%=request.getContextPath()%>/announceDetail?announceId=<%=announce.getAnnounceId()%>&cmd=update">
						<svg class="memo" version="1.1" id="_x31_0"
							xmlns="http://www.w3.org/2000/svg"
							xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
							viewBox="0 0 512 512"
							style="width: 25px; height: 25px; opacity: 1;"
							xml:space="preserve">
				<g>
				<path
								d="M453.394,226.605v-0.226l-61.477,61.477v160.535c0,0.766-0.847,1.614-1.613,1.614H222.746L62.75,449.852
					l-0.352-0.156c-0.305-0.078-0.614-0.387-0.922-1.305V121.176c0-0.847,0.77-1.613,1.613-1.613h162.684l35.969-35.969l25.508-25.348
					h-0.161l0.161-0.16H63.09C28.282,58.086,0,86.364,0,121.176v327.215c0,15.211,5.535,29.969,15.371,41.11
					c0.77,0.926,1.703,1.691,2.527,2.562c0.461,0.484,0.93,0.957,1.394,1.41c0.809,0.786,1.508,1.68,2.375,2.406
					c11.453,10.066,26.133,15.602,41.422,15.602h327.215c34.809,0,63.09-28.281,63.09-63.09V318.422l0.114-91.93L453.394,226.605z">
				</path>
				<path
								d="M505.711,84.672L427.855,6.812c-4.062-4.058-9.402-6.297-15.027-6.293c-5.332-0.004-10.309,2.039-14.011,5.742
					L153.25,251.828l-41.231,132.054c-1.453,4.645-0.152,9.715,3.375,13.246c2.523,2.527,5.942,3.973,9.39,3.973
					c1.305,0,2.602-0.199,3.864-0.59l132.054-41.234L506.27,113.715C514.125,105.86,513.871,92.832,505.711,84.672z M269.23,310.567
					c-1.469-4.18-3.73-8.055-6.66-11.348l168.629-168.625l9.051,9.05L320.871,259.024L269.23,310.567z M246.539,333.356l-0.946,0.946
					l-79.058,24.683l-12.988-12.992l24.683-79.058l0.946-0.942l10.878-0.57c2.883-0.152,5.602,0.886,7.645,2.93
					c2.039,2.039,3.078,4.754,2.926,7.641c-0.5,9.656,3.126,19.11,9.965,25.942c6.836,6.839,16.294,10.469,25.946,9.969
					c2.882-0.157,5.598,0.894,7.649,2.945c2.034,2.031,3.074,4.742,2.926,7.625L246.539,333.356z M201.938,243.227l170.946-170.95
					l9.054,9.055L213.313,249.953c-2.852-2.527-6.176-4.442-9.703-5.898C203.039,243.793,202.523,243.469,201.938,243.227z
					 M235.278,287.828c-2.887,0.148-5.602-0.891-7.645-2.938c-2.039-2.039-3.078-4.754-2.93-7.641
					c0.207-3.977-0.293-7.953-1.457-11.758l171.43-171.426l23.781,23.785l-171.43,171.426
					C243.23,288.113,239.25,287.613,235.278,287.828z M385.625,59.543l27.438-27.441l67.363,67.367l-27.438,27.437L385.625,59.543z">
					</path>
				</g>
			</svg> <span class="editText">編集</span>
					</a>
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
						<svg version="1.1" id="レイヤー_1" xmlns="http://www.w3.org/2000/svg"
							xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
							viewBox="0 0 256 256"
							style="width: 30px; height: 30px; enable-background: new 0 0 256 256;"
							xml:space="preserve">
						<style type="text/css">
.st0 {
	fill: #FFFFFF;
	stroke: #000000;
	stroke-width: 8.7931;
	stroke-linecap: round;
	stroke-linejoin: round;
	stroke-miterlimit: 10;
}
</style>
						<path class="st0"
								d="M101.5,175.5c3.9,5.9,16.6,9.3,16.6,9.3h58.6c13.2-4.4,5.9-17.1,5.9-17.1s7.8-1,11.2-9.3
							c3.4-8.3-3.4-12.7-3.4-12.7s10.3-1.5,10.3-11.2c0-12.2-11.7-10.3-11.7-10.3s10.7,1,10.7-11.7s-11.2-10.7-11.2-10.7h-40.1
							c0,0,2.9-8.3,3.4-14.7c0.5-6.4,2.9-18.6-7.8-28.8s-17.1-4.4-17.1-4.4v22.5c0,0,0.1,5.1-3.4,10.1l-15.3,29.7l-6.7,4.6" />
						<path class="st0"
								d="M101.5,120.8v59.6c0,0,0.5,7.3-4.9,7.3H65.4c0,0-6.4-0.5-6.4-4.9v-60.1c0,0,0.5-8.3,4.9-8.3h30.8
							C94.7,114.4,101.5,113.4,101.5,120.8z" />
						</svg>
						&nbsp;
						<!-- できてないよ！ -->
						<p>10,000</p>
					</div>
				</div>

				<table class="links">
				<tr>
				
				<td class="prev">

				<%
				if (announceNum > 0) {
					Announce beforeAnnounce = announceList.get(announceNum - 1);
					int beforeAnnounceId = beforeAnnounce.getAnnounceId();
				%>

				<div class="yoruArrow">
					<a
						href="<%=request.getContextPath()%>/announceDetail
					?announceId=<%=beforeAnnounceId%>&cmd=detail"
						class="jackResetL"> <svg class="arrow" width="50" height="20">
			<path d="M 0 10 L 50 10" stroke="#000" stroke-width="2" fill="none" />
			<path d="M 0 10 L 25 0" stroke="#000" stroke-width="2" fill="none" />
		</svg> <span class="beaf">PREV</span>
					</a>
				</div>
				
				<%
				}
				%>
				
				</td>
				<td class="list">
				<a class="listButton" href="<%=request.getContextPath()%>/announce">
				<svg class="memo" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 640" style="width: 30px; height: 30px;">
				<!--!Font Awesome Free v7.0.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.-->
				<path d="M104 112C90.7 112 80 122.7 80 136L80 184C80 197.3 90.7 208 104 208L152 208C165.3 208 176 197.3 176 184L176 136C176 122.7 165.3 112 152 112L104 112zM256 128C238.3 128 224 142.3 224 160C224 177.7 238.3 192 256 192L544 192C561.7 192 576 177.7 576 160C576 142.3 561.7 128 544 128L256 128zM256 288C238.3 288 224 302.3 224 320C224 337.7 238.3 352 256 352L544 352C561.7 352 576 337.7 576 320C576 302.3 561.7 288 544 288L256 288zM256 448C238.3 448 224 462.3 224 480C224 497.7 238.3 512 256 512L544 512C561.7 512 576 497.7 576 480C576 462.3 561.7 448 544 448L256 448zM80 296L80 344C80 357.3 90.7 368 104 368L152 368C165.3 368 176 357.3 176 344L176 296C176 282.7 165.3 272 152 272L104 272C90.7 272 80 282.7 80 296zM104 432C90.7 432 80 442.7 80 456L80 504C80 517.3 90.7 528 104 528L152 528C165.3 528 176 517.3 176 504L176 456C176 442.7 165.3 432 152 432L104 432z"/></svg>
				<span class="listText">一覧へ</span></a>
				</td>
				<td class="next">

				<%
				if (announceNum < announceList.size() - 1) {
				Announce nextAnnounce = announceList.get(announceNum + 1);
				int nextAnnounceId = nextAnnounce.getAnnounceId();
				%>

				<div class="yoruArrow">
					<a
						href="<%=request.getContextPath()%>/announceDetail
					?announceId=<%=nextAnnounceId%>&cmd=detail"
						class="jackResetR"> <span class="beaf">NEXT</span> <svg
							class="arrow" viewBox="0 0 50 20" x="0px" y="0px" width="50"
							height="20">
			<path d="M 0 10 L 50 10" stroke="#000" stroke-width="2" fill="none" />
			<path d="M 50 10 L 25 0" stroke="#000" stroke-width="2" fill="none" />
		</svg>
					</a>
				</div>
				<%
				}
				%>
				</td>
				</tr>
				</table>
			</div>
		</div>
	</div>

	<script>
		// 必要な要素を取得
		const categoryList = document.querySelectorAll(".categoryTag");

		// カテゴリーごとに文字色を変更
		for (let i = 0; i < categoryList.length; i++) {
			if (categoryList[i].textContent.trim() == "#お知らせ") {
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
