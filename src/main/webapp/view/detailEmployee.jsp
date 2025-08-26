<!-- 社員紹介 詳細機能（作：石井） -->
<!-- 作成日：7/2　最終更新日：8/25 14:26 -->

<%@page contentType="text/html; charset=UTF-8"%>

<%@page
	import="java.util.Arrays, java.util.ArrayList, util.MyFormat, util.CommonTable, bean.Employee, bean.User, dao.EmployeeDAO"%>

<%
// オブジェクトの生成
EmployeeDAO employeeDAO = new EmployeeDAO();
CommonTable commonTable = new CommonTable();

//サーブレットから送られてきた情報を取得
User user = (User) request.getAttribute("User");
Employee employee = (Employee) request.getAttribute("Employee");
int userId = user.getUserId();
ArrayList<User> userListBySameBelong = (ArrayList<User>) request.getAttribute("UserListBySameBelong");
ArrayList<User> userListBySameJoiningDate = (ArrayList<User>) request.getAttribute("UserListBySameJoinDate");

//フォーマットを使用するためのオブジェクト生成
MyFormat myFormat = new MyFormat();

//タイムスタンプ型、Date型のデータを全てフォーマット化
String joiningDate = myFormat.yearMonthFormat(user.getJoiningDate());
String birthday = myFormat.birthDateFormat(user.getBirthday());

//--------入社年月の取得-----------
//フォーマット化された入社年月を格納するための配列宣言
String[] joiningDatesBySameBelong = new String[userListBySameBelong.size()];
String[] joiningDatesBySameJoin = new String[userListBySameJoiningDate.size()];
//タイムスタンプ型のデータを全てフォーマット化
for (int i = 0; i < userListBySameBelong.size(); i++) {
	joiningDatesBySameBelong[i] = myFormat.yearMonthFormat(userListBySameBelong.get(i).getJoiningDate());
}
for (int i = 0; i < userListBySameJoiningDate.size(); i++) {
	joiningDatesBySameJoin[i] = myFormat.yearMonthFormat(userListBySameJoiningDate.get(i).getJoiningDate());
}

String department = commonTable.selectDepartment(user.getDepartmentId());
String group = commonTable.selectGroup(user.getGroupId());
%>

<html>
<head>
<!-- タイトル -->
<title>社員紹介 | Home-Jack</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<script src="<%=request.getContextPath()%>/js/script.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<style>
/* ページ全体（div）*/
#detailEmployee {
	margin-right: auto;
	margin-left: auto;
	width: 90%;
	text-align: center;
	z-index: 10;
}

#detailEmployee #buttonList {
	margin-top: 30px;
	margin-right: 30px;
	text-align: right;
    display: flex;
    justify-content: flex-end;
}

#detailEmployee #mainEmployee {
	margin-top: 50px;
	margin-right: auto;
	margin-bottom: 50px;
	margin-left: auto;
	width: 80%;
}

#detailEmployee #employee_imgArea {
	width: 40%;
}

#detailEmployee #employee_infoArea {
	width: 40%;
}

/* メインで出す社員画像（img）*/
#detailEmployee #employee_img {
	margin-top: auto;
	margin-right: 30px;
	margin-bottom: auto;
	width: 420px;
	height: auto;
	/*	縦横比を固定する*/
	object-fit: none;
}

#detailEmployee #belong_img, #joinTiming_img {
	width: 220px;
	height: 300px;
	/*	縦横比を固定する*/
	object-fit: cover;
}

/* 社員情報をまとめた領域（div）*/
#detailEmployee #employee_info {
	margin-left: 10px;
	width: 600px;
	text-align: left;
}

/* メインで出す社員名（p）*/
#detailEmployee #detailEmployee_name {
	margin: 0;
	margin-right: 20px;
	font-size: 80px;
}

/*社員名と社員名フリガナを横並びにする*/
#detailEmployee #detailEmployee_name, #detailEmployee_kana {
	display: inline-block;
}

/*社員所属と社員入社年を横並びにする*/
#detailEmployee #detailEmployee_belong, #detailEmployee_joinTiming {
	line-height: 0.8;
}

/* 入社年月の下に線*/
#detailEmployee #detailEmployee_joinTiming+p {
	padding-top: 10px;
	margin: 0;
	border-top: solid 1px gray;
}

#detailEmployee #intro_area {
	padding: 10px 30px;
	margin-right: auto;
	margin-bottom: 120px;
	margin-left: auto;
	width: 70%;
	border-radius: 30px;
	background-color: white;
	text-align: left;
	letter-spacing: 1px;
	line-height: 1.5;
}

/* 社員候補エリア（div）*/
#detailEmployee #imgSlider_area {
	margin-right: auto;
	margin-bottom: 100px;
	margin-left: auto;
	width: 80%;
}

/* 社員候補のタイトル（div）*/ /*タイトルを2つのidにまとめる必要ないかも*/
#detailEmployee #belong_title, #joinTiming_title {
	margin-bottom: 30px;
	text-align: left;
	font-size: 30px;
	font-weight: 500;
	padding-left: 15px;
	border-left: solid 5px darkorange;
}

/* 画像スライダー（div）*/
#detailEmployee #img_slider {
	display: flex;
	align-items: center;
	justify-content: center;
}

#detailEmployee a {
	text-decoration: none;
}

#detailEmployee #belong_link, #joinTiming_link {
	display: inline-block;
	height: 300px;
}

/* 画像スライダーの中の社員1人分の画像&情報（div）*/
#detailEmployee #employee_card {
	display: inline-block;
	margin: 5px;
	height: 100%;
	/*	大きさが変わるときのスピード*/
	transition: 0.3s;
}

#detailEmployee #employee_card:hover {
	/*	どれくらい大きくなるか*/
	transform: scale(1.1);
}

/* 同じ所属の社員名（p）*/
#detailEmployee #belong_link #employee_name {
	/*	画像の上に文字を重ねるため*/
	position: relative;
	top: -86px;
	margin: 0;
	color: black;
	font-size: 30px;
	font-weight: 500;
	cursor: pointer;
}

/* 同じ所属の社員情報（p）*/
#detailEmployee #belong_link #employee_detail {
	position: relative;
	top: -86px;
	margin: 0;
	color: black;
	font-size: 15px;
	cursor: pointer;
}

/* 同じ入社年月の社員名（p）*/
#detailEmployee #joinTiming_link #employee_name {
	/*	画像の上に文字を重ねるため*/
	position: relative;
	top: -86px;
	margin: 0;
	color: black;
	font-size: 30px;
	font-weight: 500;
	cursor: pointer;
}

/* 同じ入社年月の社員情報（p）*/
#detailEmployee #joinTiming_link #employee_detail {
	/*	画像の上に文字を重ねるため*/
	position: relative;
	top: -86px;
	margin: 0;
	color: black;
	font-size: 15px;
	cursor: pointer;
}

/* 社員1人分の名前と所属と入社年月（p）*/
#detailEmployee #employee_name, #employee_detail {
	width: 220px;
	background-color: rgba(255, 255, 255, 0.8);
}

/* 画像をスライダーさせるボタン（button）*/
#detailEmployee #img_slider button {
	width: 50px;
	height: 50px;
	cursor: pointer;
}

/*左ボタン（button）*/
#detailEmployee #prev {
	margin-right: 20px;
	cursor: pointer;
}

/*右ボタン（button）*/
#detailEmployee #next {
	margin-left: 20px;
	cursor: pointer;
}

#detailEmployee #prev:hover .cls-2{
	stroke: orange;
}

#detailEmployee #next:hover .cls-2 {
	stroke: orange;
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
	margin: 10px;
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
.editButton{
display: inline-block;			 /* パディングや幅を設定できるようにする */
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
text-decoration: none;			/* 下線を消す */
text-align: center; 			/* テキストを中央揃えにする */
cursor: pointer; 				/* マウスカーソルをポインターにする */
align-items: center;
margin: 10px;
}


/* ボタンの文字 */
.editText{
vertical-align: middle;
font-family: "Kosugi Maru", sans-serif;
font-size: 21px;
color: #fff;
}

.editButton:hover{
background-color: #fff;
border: 3px solid #6eddb3;
}

.editButton:hover .memo{
stroke: #6eddb3;
fill: #6eddb3;
}

.editButton:hover .editText{
color: #6eddb3;
}
</style>

<body>
	<div id="wrap">
		<!-- ヘッダー部分 -->
		<%@ include file="../common/header.jsp"%>

		<!-- メイン部分 -->
		<div id="main" class="container">
			<div id="detailEmployee">
				<!-- 一覧に戻るボタン・編集ボタン -->
				<div id="buttonList">
					<a class="listButton" href="<%=request.getContextPath()%>/employee">
						<svg class="memo" xmlns="http://www.w3.org/2000/svg"
							viewBox="0 0 640 640" style="width: 30px; height: 30px;">
				<!--!Font Awesome Free v7.0.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.-->
				<path
								d="M104 112C90.7 112 80 122.7 80 136L80 184C80 197.3 90.7 208 104 208L152 208C165.3 208 176 197.3 176 184L176 136C176 122.7 165.3 112 152 112L104 112zM256 128C238.3 128 224 142.3 224 160C224 177.7 238.3 192 256 192L544 192C561.7 192 576 177.7 576 160C576 142.3 561.7 128 544 128L256 128zM256 288C238.3 288 224 302.3 224 320C224 337.7 238.3 352 256 352L544 352C561.7 352 576 337.7 576 320C576 302.3 561.7 288 544 288L256 288zM256 448C238.3 448 224 462.3 224 480C224 497.7 238.3 512 256 512L544 512C561.7 512 576 497.7 576 480C576 462.3 561.7 448 544 448L256 448zM80 296L80 344C80 357.3 90.7 368 104 368L152 368C165.3 368 176 357.3 176 344L176 296C176 282.7 165.3 272 152 272L104 272C90.7 272 80 282.7 80 296zM104 432C90.7 432 80 442.7 80 456L80 504C80 517.3 90.7 528 104 528L152 528C165.3 528 176 517.3 176 504L176 456C176 442.7 165.3 432 152 432L104 432z" /></svg>
						<span class="listText">一覧へ</span>
					</a>
						<a class="editButton" href="<%=request.getContextPath()%>/employeeDetail?work=update&user_id=<%=user.getUserId()%>">
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

				<!-- プロフ欄 -->
				<table id="mainEmployee">
					<tr>
						<td id="employee_imgArea">
							<!-- 社員画像 --> <img id="employee_img"
							src="<%=request.getContextPath()%>/employeePhoto
									?user_id=<%=employee.getUserId()%>&work=view"
							alt="社員画像">
						</td>
						<td id="employee_infoArea">
							<!-- 社員情報 -->
							<div id="employee_info">
								<%
								if (user != null || employee != null) {
								%>
								<p>
									社員番号
									<%=user.getEmployeeNumber()%></p>
								<p id="detailEmployee_name"><%=user.getName()%></p>
								<p id="detailEmployee_kana"><%=user.getNameKana()%></p>
								<p id="detailEmployee_belong">
									<%=department%>
									<%=group%>
								</p>
								<p id="detailEmployee_joinTiming"><%=joiningDate%>入社
								</p>
								<p>
									習得言語
									<%=employee.getLangSkill()%></p>
								<p>
									習得技術
									<%=employee.getMiddleSkill()%></p>
								<p>
									開発年数
									<%=employee.getDeveloper()%>年
								</p>
								<p>
									生年月日
									<%
								if (birthday != null) {
								%>
									<%=birthday%>
									<%
									}
									%>
								</p>
								<p>
									趣味
									<%
								if (employee.getHobby() != null) {
								%>
									<%=employee.getHobby()%>
									<%
									}
									%>
								</p>
								<p>
									特技
									<%
								if (employee.getTalent() != null) {
								%>
									<%=employee.getTalent()%>
									<%
									}
									%>
								</p>
								<p>
									役職
									<%
								if (employee.getPosition() != null) {
								%>
									<%=employee.getPosition()%>
									<%
									}
									%>
								</p>
								<%
								}
								%>
							</div>
						</td>
					</tr>
				</table>

				<!-- 自己紹介欄 -->
				<div id="intro_area">
					<p><%=employee.getIntro()%></p>
				</div>

				<!-- 社員候補リスト（同じ所属） -->
				<div id="imgSlider_area">
					<div id="belong_title">
						<%=department%>
						<%=group%>
					</div>
					<div id="img_slider">
						<%
						if (userListBySameBelong != null) {
							if (userListBySameBelong.size() >= 3) {
						%>

						<svg id="prev" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 48 48" width="64px" height="64px"><defs><style>.cls-1,.cls-2{fill:none;}.cls-2{stroke:#000;stroke-linecap:round;stroke-linejoin:round;stroke-width:2px;}</style></defs><g id="レイヤー_2" data-name="レイヤー 2"><g id="Rectangle"><rect class="cls-1" width="48" height="48"/></g><g id="icon_data"><polyline class="cls-2" points="27 30.25 21 24.25 27 18"/><path class="cls-2" d="M24.16,6.25A18,18,0,1,1,15.43,8.5"/></g></g></svg>

						<%
						}
						for (int i = 0; i < 3 && i < userListBySameBelong.size(); i++) {
						department = commonTable.selectDepartment(user.getDepartmentId());
						group = commonTable.selectGroup(user.getGroupId());
						%>
						<a id="belong_link"
							href="employeeDetail?user_id=<%=userListBySameBelong.get(i).getUserId()%>&work=detail">
							<div id="employee_card">
								<img id="belong_img"
									src="<%=request.getContextPath()%>/employeePhoto
									?user_id=<%=userListBySameBelong.get(i).getUserId()%>&work=view"
									alt="社員画像">
								<p id="employee_name" class="sameBelong_employeeName"><%=userListBySameBelong.get(i).getName()%></p>
								<p id="employee_detail">
									<%=department%>
									<%=group%>
								</p>
								<p id="employee_detail" class="employee_joinTiming"><%=joiningDatesBySameBelong[i]%>入社
								</p>
							</div>
						</a>
						<%
						}
						if (userListBySameBelong.size() >= 3) {
						%>

						<svg id="next" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 48 48" width="64px" height="64px"><defs><style>.cls-1,.cls-2{fill:none;}.cls-2{stroke:#000;stroke-linecap:round;stroke-linejoin:round;stroke-width:2px;}</style></defs><g id="レイヤー_2" data-name="レイヤー 2"><g id="Rectangle"><rect class="cls-1" width="48" height="48"/></g><g id="icon_data"><polyline class="cls-2" points="22 18 28 24 22 30.25"/><path class="cls-2" d="M24,6.25A18,18,0,1,1,15.27,8.5"/></g></g></svg>

						<%
						}
						}
						%>
					</div>
				</div>

				<!-- 社員候補リスト（同じ入社年月） -->
				<div id="imgSlider_area">
					<div id="joinTiming_title"><%=joiningDate%>入社
					</div>
					<div id="img_slider">
						<%
						if (userListBySameJoiningDate != null) {
							if (userListBySameJoiningDate.size() >= 3) {
						%>
						<svg id="prev" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 48 48" width="64px" height="64px"><defs><style>.cls-1,.cls-2{fill:none;}.cls-2{stroke:#000;stroke-linecap:round;stroke-linejoin:round;stroke-width:2px;}</style></defs><g id="レイヤー_2" data-name="レイヤー 2"><g id="Rectangle"><rect class="cls-1" width="48" height="48"/></g><g id="icon_data"><polyline class="cls-2" points="27 30.25 21 24.25 27 18"/><path class="cls-2" d="M24.16,6.25A18,18,0,1,1,15.43,8.5"/></g></g></svg>

						<%
						}
						for (int i = 0; i < 3 && i < userListBySameJoiningDate.size(); i++) {
						%>
						<a id="joinTiming_link"
							href="employeeDetail?user_id=<%=userListBySameJoiningDate.get(i).getUserId()%>&work=detail">
							<div id="employee_card">
								<img id="joinTiming_img"
									src="<%=request.getContextPath()%>/employeePhoto
									?user_id=<%=userListBySameJoiningDate.get(i).getUserId()%>&work=view"
									alt="社員画像">
								<p id="employee_name" class="sameJoinTiming_employeeName"><%=userListBySameJoiningDate.get(i).getName()%></p>
								<p id="employee_detail" class="employee_belong">
									第<%=userListBySameJoiningDate.get(i).getDepartmentId()%>事業部 第<%=userListBySameJoiningDate.get(i).getGroupId()%>グループ
								</p>
								<p id="employee_detail"><%=joiningDatesBySameJoin[i]%>入社
								</p>
							</div>
						</a>
						<%
						}
						if (userListBySameJoiningDate.size() >= 3) {
						%>

						<svg id="next" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 48 48" width="64px" height="64px"><defs><style>.cls-1,.cls-2{fill:none;}.cls-2{stroke:#000;stroke-linecap:round;stroke-linejoin:round;stroke-width:2px;}</style></defs><g id="レイヤー_2" data-name="レイヤー 2"><g id="Rectangle"><rect class="cls-1" width="48" height="48"/></g><g id="icon_data"><polyline class="cls-2" points="22 18 28 24 22 30.25"/><path class="cls-2" d="M24,6.25A18,18,0,1,1,15.27,8.5"/></g></g></svg>

						<%
						}
						}
						%>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%
	// Javaの変数をJavaScriptに受け渡し
	int userListBySameBelongSize = userListBySameBelong.size();
	int userListBySameJoiningDateSize = userListBySameJoiningDate.size();

	// -------------ユーザーID（同じ所属）---------------
	int idListByBelongElement; // リストの要素を一つ一つ代入するための変数
	int[] arrayIdListB = new int[userListBySameBelongSize]; // リストの要素分の配列を宣言
	for (int i = 0; i < userListBySameBelongSize; i++) {
		idListByBelongElement = userListBySameBelong.get(i).getUserId(); // 値を一つ一つ取ってきて代入していく
		arrayIdListB[i] = idListByBelongElement; // 代入された値を配列に入れていく
	}
	String idListByBelong = Arrays.toString(arrayIdListB); // 配列を文字列に変換して受け渡す

	// -------------ユーザーID（同じ入社年月）---------------
	int idListByJoinElement; // リストの要素を一つ一つ代入するための変数
	int[] arrayIdListJ = new int[userListBySameJoiningDateSize]; // リストの要素分の配列を宣言
	for (int i = 0; i < userListBySameJoiningDateSize; i++) {
		idListByJoinElement = userListBySameJoiningDate.get(i).getUserId(); // 値を一つ一つ取ってきて代入していく
		arrayIdListJ[i] = idListByJoinElement; // 代入された値を配列に入れていく
	}
	String idListByJoin = Arrays.toString(arrayIdListJ); // 配列を文字列に変換して受け渡す

	// -------------名前（同じ所属）---------------
	String nameListByBelongElement = ""; // リストの要素を一つ一つ代入するための変数
	String[] arrayNameListB = new String[userListBySameBelongSize]; // リストの要素分の配列を宣言
	for (int i = 0; i < userListBySameBelongSize; i++) {
		nameListByBelongElement = userListBySameBelong.get(i).getName(); // 値を一つ一つ取ってきて代入していく
		arrayNameListB[i] = nameListByBelongElement; // 代入された値を配列に入れていく
	}
	String nameListByBelong = Arrays.toString(arrayNameListB); // 配列を文字列に変換して受け渡す

	// -------------名前（同じ入社年月）---------------
	String nameListByJoinElement = ""; // リストの要素を一つ一つ代入するための変数
	String[] arrayNameListJ = new String[userListBySameJoiningDateSize]; // リストの要素分の配列を宣言
	for (int i = 0; i < userListBySameJoiningDateSize; i++) {
		nameListByJoinElement = userListBySameJoiningDate.get(i).getName(); // 値を一つ一つ取ってきて代入していく
		arrayNameListJ[i] = nameListByJoinElement; // 代入された値を配列に入れていく
	}
	String nameListByJoin = Arrays.toString(arrayNameListJ); // 配列を文字列に変換して受け渡す

	// -------------社員画像（同じ所属）---------------
	// String imgListByBelongElement = "";	// リストを一つ一つ代入するための変数
	// String[] arrayImgListB = new String[userListBySameBelongSize];	// リストの要素分の配列を宣言
	// for (int i = 0; i < userListBySameBelongSize; i++) {
	// 	imgListByBelongElement = sameBelong_imgList[i];	// 値を一つ一つ取ってきて代入していく
	// 	arrayImgListB[i] = imgListByBelongElement;		// 代入された値を配列に入れていく
	// }
	// String imgListByBelong = Arrays.toString(arrayImgListB);	// 配列を文字列に変換して受け渡す

	// -------------社員画像（同じ入社年月）---------------
	// String imgListByJoinElement = "";	// リストを一つ一つ代入するための変数
	// String[] arrayImgListJ = new String[userListBySameJoiningDateSize];	// リストの要素分の配列を宣言
	// for (int i = 0; i < userListBySameJoiningDateSize; i++) {
	// 	imgListByJoinElement = sameJoinTiming_imgList[i];	// 値を一つ一つ取ってきて代入していく
	// 	arrayImgListJ[i] = imgListByJoinElement;		// 代入された値を配列に入れていく
	// }
	// String imgListByJoin = Arrays.toString(arrayImgListJ);	// 配列を文字列に変換して受け渡す

	// -------------入社年月---------------
	String joiningDateListElement = ""; // リストを一つ一つ代入するための変数
	String[] arrayJoiningDateList = new String[userListBySameBelongSize]; // リストの要素分の配列を宣言
	for (int i = 0; i < userListBySameBelongSize; i++) {
		joiningDateListElement = joiningDatesBySameBelong[i]; // 値を一つ一つ取ってきて代入していく
		arrayJoiningDateList[i] = joiningDateListElement; // 代入された値を配列に入れていく
	}
	String joiningDateList = Arrays.toString(arrayJoiningDateList); // 配列を文字列に変換して受け渡す

	// -------------部・グループ（部）---------------
	int departmentListElement = 0; // リストを一つ一つ代入するための変数
	int[] arrayDepartmentList = new int[userListBySameJoiningDateSize]; // リストの要素分の配列を宣言
	for (int i = 0; i < userListBySameJoiningDateSize; i++) {
		departmentListElement = userListBySameJoiningDate.get(i).getDepartmentId(); // 値を一つ一つ取ってきて代入していく
		arrayDepartmentList[i] = departmentListElement; // 代入された値を配列に入れていく
	}
	String departmentList = Arrays.toString(arrayDepartmentList); // 配列を文字列に変換して受け渡す

	// -------------部・グループ（グループ）---------------
	int teamListElement = 0; // リストを一つ一つ代入するための変数
	int[] arrayTeamList = new int[userListBySameJoiningDateSize]; // リストの要素分の配列を宣言
	for (int i = 0; i < userListBySameJoiningDateSize; i++) {
		teamListElement = userListBySameJoiningDate.get(i).getGroupId(); // 値を一つ一つ取ってきて代入していく
		arrayTeamList[i] = teamListElement; // 代入された値を配列に入れていく
	}
	String teamList = Arrays.toString(arrayTeamList); // 配列を文字列に変換して受け渡す
	%>

	<script>
	// 変数受け渡し
	const userListBySameBelongSize = <%=userListBySameBelongSize%>;
	const userListBySameJoiningDateSize = <%=userListBySameJoiningDateSize%>;

	// -------------ユーザーID（同じ所属）---------------
	let stringIdListByBelong = "<%=idListByBelong%>";
	stringIdListByBelong = stringIdListByBelong.replace("[", "").replace("]", "");	// 文字列に[]が残っているので消す
	const sameBelong_idList = stringIdListByBelong.split(", ");	// 要素の間にある「, 」で分ける（配列の完成）

	// -------------ユーザーID（同じ入社年月）---------------
	let stringIdListByJoin = "<%=idListByJoin%>";
	stringIdListByJoin = stringIdListByJoin.replace("[", "").replace("]", "");	// 文字列に[]が残っているので消す
	const sameJoinTiming_idList = stringIdListByJoin.split(", ");	// 要素の間にある「, 」で分ける（配列の完成）

	// -------------名前（同じ所属）---------------
	let stringNameListByBelong = "<%=nameListByBelong%>";
	stringNameListByBelong = stringNameListByBelong.replace("[", "").replace("]", "");	// 文字列に[]が残っているので消す
	const sameBelong_nameList = stringNameListByBelong.split(", ");	// 要素の間にある「, 」で分ける（配列の完成）

	// -------------名前（同じ入社年月）---------------
	let stringNameListByJoin = "<%=nameListByJoin%>";
	stringNameListByJoin = stringNameListByJoin.replace("[", "").replace("]", "");	// 文字列に[]が残っているので消す
	const sameJoinTiming_nameList = stringNameListByJoin.split(", ");	// 要素の間にある「, 」で分ける（配列の完成）

	// -------------社員画像（同じ所属）---------------
	// let stringImgListByBelong = "%= imgListByBelong %>";
	// stringImgListByBelong = stringImgListByBelong.replace("[", "").replace("]", "");	// 文字列に[]が残っているので消す
	// const sameBelong_imgList = stringImgListByBelong.split(", ");	// 要素の間にある「, 」で分ける（配列の完成）

	// -------------社員画像（同じ入社年月）---------------
	// let stringImgListByJoin = "%= imgListByJoin %>";
	// stringImgListByJoin = stringImgListByJoin.replace("[", "").replace("]", "");	// 文字列に[]が残っているので消す
	// const sameJoinTiming_imgList = stringImgListByJoin.split(", ");	// 要素の間にある「, 」で分ける（配列の完成）

	// -------------入社年月---------------
	let stringJoiningDateList = "<%=joiningDateList%>";
	stringJoiningDateList = stringJoiningDateList.replace("[", "").replace("]", "");	// 文字列に[]が残っているので消す
	const joinTimingList = stringJoiningDateList.split(", ");	// 要素の間にある「, 」で分ける（配列の完成）
	
	// -------------部・グループ（部）---------------
	let stringDepartmentList = "<%=departmentList%>";
	stringDepartmentList = stringDepartmentList.replace("[", "").replace("]", "");	// 文字列に[]が残っているので消す
	const departmentList = stringDepartmentList.split(", ");	// 要素の間にある「, 」で分ける（配列の完成）
	
	// -------------部・グループ（グループ）---------------
	let stringTeamList = "<%=teamList%>";
	stringTeamList = stringTeamList.replace("[", "").replace("]", "");	// 文字列に[]が残っているので消す
	const teamList = stringTeamList.split(", ");	// 要素の間にある「, 」で分ける（配列の完成）

	// 部の配列とグループの配列を合わせた文字列の作成
	const belongList = [];
	for (let i = 0; i < userListBySameBelongSize + userListBySameJoiningDateSize; i++) {
		belongList[i] = "第" + departmentList[i] + "事業部 第" + teamList[i] + "グループ";
	}

	//必要な要素を取得
	const prevButtons = document.querySelectorAll("#prev");
	const nextButtons = document.querySelectorAll("#next");
	const sameBelong_id = document.querySelectorAll("#belong_link");
	const sameBelong_imgs = document.querySelectorAll("#belong_img");
	const sameBelong_names = document.getElementsByClassName("sameBelong_employeeName");
	const sameBelong_joinTimings = document.getElementsByClassName("employee_joinTiming");
	const sameJoinTiming_id = document.querySelectorAll("#joinTiming_link");
	const sameJoinTiming_imgs = document.querySelectorAll("#joinTiming_img");
	const sameJoinTiming_names = document.getElementsByClassName("sameJoinTiming_employeeName");
	const sameJoinTiming_belongs = document.getElementsByClassName("employee_belong");

	//現在のインデックスを保持するための変数
	let indexLeft_0 = 0;
	let indexCenter_0 = 1;
	let indexRight_0 = 2;
	let indexLeft_1 = 0;
	let indexCenter_1 = 1;
	let indexRight_1 = 2;

	// ページが読み込まれたときに最初の情報を表示
	document.addEventListener('DOMContentLoaded', () => {
		//sameBelong_imgs[0].src = "<%=request.getContextPath()%>/file/" + sameBelong_imgList[indexLeft_0];
		//sameBelong_imgs[1].src = "<%=request.getContextPath()%>/file/" + sameBelong_imgList[indexCenter_0];
		//sameBelong_imgs[2].src = "<%=request.getContextPath()%>/file/" + sameBelong_imgList[indexRight_0];
		
		sameBelong_names[0].textContent = sameBelong_nameList[indexLeft_0];
		sameBelong_names[1].textContent = sameBelong_nameList[indexCenter_0];
		sameBelong_names[2].textContent = sameBelong_nameList[indexRight_0];
		
		sameBelong_joinTimings[0].textContent = joinTimingList[indexLeft_0] + "入社";
		sameBelong_joinTimings[1].textContent = joinTimingList[indexCenter_0] + "入社";
		sameBelong_joinTimings[2].textContent = joinTimingList[indexRight_0] + "入社";
		
		//sameJoinTiming_imgs[0].src = "<%=request.getContextPath()%>/file/" + sameJoinTiming_imgList[indexLeft_1];
		//sameJoinTiming_imgs[1].src = "<%=request.getContextPath()%>/file/" + sameJoinTiming_imgList[indexCenter_1];
		//sameJoinTiming_imgs[2].src = "<%=request.getContextPath()%>/file/" + sameJoinTiming_imgList[indexRight_1];
		
		sameJoinTiming_names[0].textContent = sameJoinTiming_nameList[indexLeft_1];
		sameJoinTiming_names[1].textContent = sameJoinTiming_nameList[indexCenter_1];
		sameJoinTiming_names[2].textContent = sameJoinTiming_nameList[indexRight_1];
		
		sameJoinTiming_belongs[0].textContent = belongList[indexLeft_1];
		sameJoinTiming_belongs[1].textContent = belongList[indexCenter_1];
		sameJoinTiming_belongs[2].textContent = belongList[indexRight_1];
	});

	// ▶ボタン（同じ所属）が押されたら画像を1つ進める
	nextButtons[0].addEventListener('click', () => {
		//	インデックスを1つ進める
		indexLeft_0 += 1;
		indexCenter_0 += 1;
		indexRight_0 += 1;
		
		//	インデックスがリストの範囲を超えた場合の処理
		if (indexRight_0 >= sameBelong_nameList.length) {
			indexLeft_0 = sameBelong_nameList.length - 3;
			indexCenter_0 = sameBelong_nameList.length - 2;
			indexRight_0 = sameBelong_nameList.length - 1;
		}

		//	現在のインデックスを指定でリストから取ってくる
		sameBelong_id[0].href = "detailEmployee?userId=" + sameBelong_idList[indexLeft_0];
		sameBelong_id[1].href = "detailEmployee?userId=" + sameBelong_idList[indexCenter_0];
		sameBelong_id[2].href = "detailEmployee?userId=" + sameBelong_idList[indexRight_0];
		
		//sameBelong_imgs[0].src = "<%=request.getContextPath()%>/file/" + sameBelong_imgList[indexLeft_0];
		//sameBelong_imgs[1].src = "<%=request.getContextPath()%>/file/" + sameBelong_imgList[indexCenter_0];
		//sameBelong_imgs[2].src = "<%=request.getContextPath()%>/file/" + sameBelong_imgList[indexRight_0];

		console.log(sameBelong_nameList);
		
		sameBelong_names[0].textContent = sameBelong_nameList[indexLeft_0];
		sameBelong_names[1].textContent = sameBelong_nameList[indexCenter_0];
		sameBelong_names[2].textContent = sameBelong_nameList[indexRight_0];
		
		sameBelong_joinTimings[0].textContent = joinTimingList[indexLeft_0] + "入社";
		sameBelong_joinTimings[1].textContent = joinTimingList[indexCenter_0] + "入社";
		sameBelong_joinTimings[2].textContent = joinTimingList[indexRight_0] + "入社";
	})

	// ▶ボタン（同じ入社年月）が押されたら画像を1つ進める
	nextButtons[1].addEventListener('click', () => {
		//	インデックスを1つ進める
		indexLeft_1 += 1;
		indexCenter_1 += 1;
		indexRight_1 += 1;
		
		//	インデックスがリストの範囲を超えた場合の処理
		if (indexRight_1 >= sameJoinTiming_nameList.length) {
			indexLeft_1 = sameJoinTiming_nameList.length - 3;
			indexCenter_1 = sameJoinTiming_nameList.length - 2;
			indexRight_1 = sameJoinTiming_nameList.length - 1;
		}
		
		//	現在のインデックスを指定でリストから取ってくる
		sameJoinTiming_id[0].href = "detailEmployee?userId=" + sameJoinTiming_idList[indexLeft_1];
		sameJoinTiming_id[1].href = "detailEmployee?userId=" + sameJoinTiming_idList[indexCenter_1];
		sameJoinTiming_id[2].href = "detailEmployee?userId=" + sameJoinTiming_idList[indexRight_1];
		
		//sameJoinTiming_imgs[0].src = "<%=request.getContextPath()%>/file/" + sameJoinTiming_imgList[indexLeft_1];
		//sameJoinTiming_imgs[1].src = "<%=request.getContextPath()%>/file/" + sameJoinTiming_imgList[indexCenter_1];
		//sameJoinTiming_imgs[2].src = "<%=request.getContextPath()%>/file/" + sameJoinTiming_imgList[indexRight_1];
		
		sameJoinTiming_names[0].textContent = sameJoinTiming_nameList[indexLeft_1];
		sameJoinTiming_names[1].textContent = sameJoinTiming_nameList[indexCenter_1];
		sameJoinTiming_names[2].textContent = sameJoinTiming_nameList[indexRight_1];
		
		sameJoinTiming_belongs[0].textContent = belongList[indexLeft_1];
		sameJoinTiming_belongs[1].textContent = belongList[indexCenter_1];
		sameJoinTiming_belongs[2].textContent = belongList[indexRight_1];
	})

	// ◀ボタン（同じ所属）が押されたら画像を1つ戻す
	prevButtons[0].addEventListener('click', () => {
		//	インデックスを1つ戻す
		indexLeft_0 -= 1;
		indexCenter_0 -= 1;
		indexRight_0 -= 1;
		
		//	インデックスがリストの範囲を超えた場合の処理
		if (indexLeft_0 < 0) {
			indexLeft_0 = 0;
			indexCenter_0 = 1;
			indexRight_0 = 2;
		}
		
		//	現在のインデックスを指定でリストから取ってくる
		sameBelong_id[0].href = "detailEmployee?userId=" + sameBelong_idList[indexLeft_0];
		sameBelong_id[1].href = "detailEmployee?userId=" + sameBelong_idList[indexCenter_0];
		sameBelong_id[2].href = "detailEmployee?userId=" + sameBelong_idList[indexRight_0];
		
		//sameBelong_imgs[0].src = "<%=request.getContextPath()%>/file/" + sameBelong_imgList[indexLeft_0];
		//sameBelong_imgs[1].src = "<%=request.getContextPath()%>/file/" + sameBelong_imgList[indexCenter_0];
		//sameBelong_imgs[2].src = "<%=request.getContextPath()%>/file/" + sameBelong_imgList[indexRight_0];
		
		sameBelong_names[0].textContent = sameBelong_nameList[indexLeft_0];
		sameBelong_names[1].textContent = sameBelong_nameList[indexCenter_0];
		sameBelong_names[2].textContent = sameBelong_nameList[indexRight_0];
		
		sameBelong_joinTimings[0].textContent = joinTimingList[indexLeft_0] + "入社";
		sameBelong_joinTimings[1].textContent = joinTimingList[indexCenter_0] + "入社";
		sameBelong_joinTimings[2].textContent = joinTimingList[indexRight_0] + "入社";
	})

	// ◀ボタン（同じ入社年月）が押されたら画像を1つ戻す
	prevButtons[1].addEventListener('click', () => {
		//	インデックスを1つ戻す
		indexLeft_1 -= 1;
		indexCenter_1 -= 1;
		indexRight_1 -= 1;
		
		//	インデックスがリストの範囲を超えた場合の処理
		if (indexLeft_1 < 0) {
			indexLeft_1 = 0;
			indexCenter_1 = 1;
			indexRight_1 = 2;
		}
		
		//	現在のインデックスを指定でリストから取ってくる
		sameJoinTiming_id[0].href = "detailEmployee?userId=" + sameJoinTiming_idList[indexLeft_1];
		sameJoinTiming_id[1].href = "detailEmployee?userId=" + sameJoinTiming_idList[indexCenter_1];
		sameJoinTiming_id[2].href = "detailEmployee?userId=" + sameJoinTiming_idList[indexRight_1];
		
		//sameJoinTiming_imgs[0].src = "<%=request.getContextPath()%>/file/" + sameJoinTiming_imgList[indexLeft_1];
		//sameJoinTiming_imgs[1].src = "<%=request.getContextPath()%>/file/" + sameJoinTiming_imgList[indexCenter_1];
		//sameJoinTiming_imgs[2].src = "<%=request.getContextPath()%>/file/" + sameJoinTiming_imgList[indexRight_1];
		
		sameJoinTiming_names[0].textContent = sameJoinTiming_nameList[indexLeft_1];
		sameJoinTiming_names[1].textContent = sameJoinTiming_nameList[indexCenter_1];
		sameJoinTiming_names[2].textContent = sameJoinTiming_nameList[indexRight_1];
		
		sameJoinTiming_belongs[0].textContent = belongList[indexLeft_1];
		sameJoinTiming_belongs[1].textContent = belongList[indexCenter_1];
		sameJoinTiming_belongs[2].textContent = belongList[indexRight_1];

	})
	</script>

</body>
</html>