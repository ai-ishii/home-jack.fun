<%--
個人情報詳細画面

作成者:月向亮太

作成日: 2025/8/21
更新日: 2025/8/27
 --%>

<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.ArrayList, bean.User, util.MyFormat"%>
<%@page import="bean.Authority"%>
<%@page import="bean.AuthorityHaving"%>
<%
//個人情報を格納したuserを受け取る
User user = (User) request.getAttribute("user");
//String cmd = (String) request.getAttribute("cmd");
ArrayList<Authority> authorityList = (ArrayList<Authority>) request.getAttribute("authority_list");
ArrayList<AuthorityHaving> authorityHavingList = (ArrayList<AuthorityHaving>) request
		.getAttribute("authority_having_list");

MyFormat myFormat = new MyFormat();
String birthday = myFormat.breakDateFormat(user.getBirthday());
%>

<html>
<head>
<!-- タイトル -->
<title>個人情報詳細 | HomeJack</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<script src="<%=request.getContextPath()%>/js/script.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<style>
#contents {
	width: 90%;
	margin-right: auto;
	margin-left: auto;
}

#link-line {
	padding: 1rem 0;
	margin-bottom: 0.2rem;
	background-image: linear-gradient(90deg, #b2d5de 0 25%, #ddcfb3 25% 50%, #b3ddb4 50% 75%,
		#ddbab3 75%);
	background-repeat: no-repeat;
	background-size: 100% 0.3rem;
	background-position: bottom;
	color: #353535;
	font-weight: bold;
	font-size: 26px;
	text-align: center;
}

#link-title {
	text-align: center;
}

#koji-name {
	margin: 0;
}

/* 追加したよ */
#detail-list {
	margin: 0 auto;
}

#detail-list {
	margin: 0 auto;
	padding: 0;
	width: 60%;
	border-collapse: collapse;
}

#detail-list tr {
	background-color: #fff;
	border-bottom: 2px solid #fff;
	height: 50px
}

#detail-list th, #detail-list td {
	padding: .20em 1em;
}

#detail-title {
	margin: 0 auto;
	padding: 0;
	width: 60%;
}

.title {
	width: 60%;
}

.btn {
	text-align: right;
	padding: 0;
}

.table-double {
	border-right: 3px double #fcc800; /* 二重線を適用 */
	padding: 8px;
	width: 90px;
}

.table-single {
	border-bottom: 0.5px solid #f4dda5;
}

.button-container {
	text-align: center;
	margin-top: 30px;
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

/* 編集ボタンだよ */
/* 編集ボタンの大枠 */

/* 編集ボタンデザイン */
.editButton {
	display: inline-block; /* パディングや幅を設定できるようにする */
	padding: 8px 16px;
	background-color: #6eddb3;
	border: 3px solid #6eddb3;
	/* 丸形の場合 */
	/*
border-radius: 30px;
padding: 9px 25px;
*/
	/* 四角型の場合 */
	border-radius: 5px;
	text-decoration: none; /* 下線を消す */
	text-align: center; /* テキストを中央揃えにする */
	cursor: pointer; /* マウスカーソルをポインターにする */
	align-items: center;
	margin: 10px;
}

/* ボタンの文字 */
.editText {
	vertical-align: middle;
	font-family: "Kosugi Maru", sans-serif;
	font-size: 21px;
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
</style>
</head>

<body>
	<div id="wrap">
		<!-- ヘッダー部分 -->
		<%@ include file="../common/header.jsp"%>

		<!-- メイン部分 -->
		<div id="main" class="container">
			<div id="contents">
				<div id="link-title">
					<h1 id="link-line">個人情報詳細</h1>
				</div>
				<br>


				<form action="<%=request.getContextPath()%>/userConfirm"
					method="post">

					<table id="detail-title">
						<tr>
							<td class="title"><h3 id="koji-name">
									個人情報：<%=user.getName()%></h3></td>
							<%
							for (int i = 0; i < authorityHavingList.size(); i++) {
								AuthorityHaving having = authorityHavingList.get(i);
								if (having.getAuthorityCode().equals("APR_ADMN")) {
							%>
							<td class="btn">
								<!-- 詳細から一覧へ戻るボタン --> <a class="listButton"
								href="<%=request.getContextPath()%>/userList"> <svg class="memo"
										xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 640"
										style="width: 30px; height: 30px;">
				<!--!Font Awesome Free v7.0.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.-->
				<path
											d="M104 112C90.7 112 80 122.7 80 136L80 184C80 197.3 90.7 208 104 208L152 208C165.3 208 176 197.3 176 184L176 136C176 122.7 165.3 112 152 112L104 112zM256 128C238.3 128 224 142.3 224 160C224 177.7 238.3 192 256 192L544 192C561.7 192 576 177.7 576 160C576 142.3 561.7 128 544 128L256 128zM256 288C238.3 288 224 302.3 224 320C224 337.7 238.3 352 256 352L544 352C561.7 352 576 337.7 576 320C576 302.3 561.7 288 544 288L256 288zM256 448C238.3 448 224 462.3 224 480C224 497.7 238.3 512 256 512L544 512C561.7 512 576 497.7 576 480C576 462.3 561.7 448 544 448L256 448zM80 296L80 344C80 357.3 90.7 368 104 368L152 368C165.3 368 176 357.3 176 344L176 296C176 282.7 165.3 272 152 272L104 272C90.7 272 80 282.7 80 296zM104 432C90.7 432 80 442.7 80 456L80 504C80 517.3 90.7 528 104 528L152 528C165.3 528 176 517.3 176 504L176 456C176 442.7 165.3 432 152 432L104 432z" /></svg>
									<span class="listText">一覧へ</span>
							</a>
							</td>
							<%
							}
							}
							%>

							<td class="btn"><button class="editButton" name="registerConfirm" value="変更する">
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
							</button></td>
						</tr>
					</table>

					<table id="detail-list">
						<tr class="table-single">
							<td class="table-double">社員番号</td>
							<td colspan="2"><%=user.getEmployeeNumber()%></td>
						</tr>
						<tr class="table-single">
							<td class="table-double">所属</td>
							<td colspan="2">第<%=user.getDepartmentId()%>部&nbsp;第<%=user.getGroupId()%>グループ
							</td>
						</tr>
						<tr class="table-single">
							<td class="table-double">氏名</td>
							<td colspan="2"><%=user.getName()%></td>
						</tr>
						<tr class="table-single">
							<td class="table-double">ふりがな</td>
							<td colspan="2"><%=user.getNameKana()%></td>
						</tr>
						<tr class="table-single">
							<td class="table-double">生年月日</td>
							<td colspan="2"><%=birthday%></td>
						</tr>
						<tr class="table-single">
							<td class="table-double">性別</td>
							<td colspan="2"><%=user.getSex()%></td>
						</tr>
						<tr class="table-single">
							<td class="table-double">電話番号</td>
							<td colspan="2"><%=user.getPhone()%></td>
						</tr>
						<tr class="table-single">
							<td class="table-double">郵便番号</td>
							<td colspan="2"><%=user.getPost()%></td>
						</tr>
						<tr class="table-single">
							<td class="table-double">住所</td>
							<td colspan="2"><%=user.getAddress()%></td>
						</tr>
						<tr class="table-single">
							<td class="table-double">子供</td>
							<td colspan="2">
								<%
								if (user.getChildren() != 0) {
								%> <%=user.getChildren()%>人 <%
 }
 %>
							</td>
						</tr>
						<tr class="table-single">
							<td class="table-double">勤務年数</td>
							<td colspan="2"><%=user.getWorkHistory()%>年</td>
						</tr>
						<tr class="table-single">
							<td class="table-double">最寄り駅</td>
							<td colspan="2"><%=user.getNearestStation()%></td>
						</tr>
						<tr class="table-single">
							<td class="table-double">交通手段</td>
							<td colspan="2"><%=user.getTransportation()%></td>
						</tr>
						<tr class="table-single">
							<td class="table-double">資格</td>
							<td colspan="2"><%=user.getQualification()%></td>


						</tr>
						<tr class="table-single">
							<td class="table-double">権限</td>

							<td>
								<%
								for (AuthorityHaving having : authorityHavingList) {
									for (Authority authority : authorityList) {
										if (having.getAuthorityCode().equals(authority.getAuthorityCode())) {
								%> <%=authority.getAuthorityName()%> <br> <%
 }
 }
 }
 %>
							</td>
							<td><a
								href="<%=request.getContextPath()%>/view/authorityUpdate.jsp"><p>権限付与はコチラ!</p></a>

							</td>
						</tr>



					</table>

				</form>

			</div>
		</div>
	</div>
</body>
</html>