<!-- 社員紹介 変更機能（作：石井） -->
<!-- 作成日：7/18　最終更新日：8/22 17:00 -->

<%@page contentType="text/html; charset=UTF-8"%>

<%@page
	import="bean.Account, bean.User, bean.Employee, dao.UserDAO, util.CommonTable, util.MyFormat, java.text.SimpleDateFormat, java.util.Date, java.sql.Timestamp"%>

<!-- cmdで確認画面と編集画面分ける -->

<%
//オブジェクトの生成
Account account = new Account();
User user = new User();
UserDAO userDAO = new UserDAO();
Employee employee = new Employee();
CommonTable commonTable = new CommonTable();

//セッションでユーザーのデータを取得
account = (Account) session.getAttribute("account");
int userId_session = (int) session.getAttribute("user_id");

user = (User) request.getAttribute("user");
employee = (Employee) request.getAttribute("employee");

int userId = user.getUserId();
String employeeNumber = user.getEmployeeNumber();
String name = user.getName();
String nameKana = user.getNameKana();
Date birthday = user.getBirthday();
int departmentId = user.getDepartmentId();
int groupId = user.getGroupId();
Timestamp joiningDate = user.getJoiningDate();

//フォーマット化し表示形式を変更
MyFormat myFormat = new MyFormat();
String birthdayStr = myFormat.birthDateFormat(birthday);
String joiningDateStr = myFormat.yearMonthFormat(joiningDate);

//疑似テーブルメソッドからデータを取得
String department = commonTable.selectDepartment(departmentId);
String group = commonTable.selectGroup(groupId);

// cmdを取得
String cmd = (String) request.getAttribute("cmd");

// 変数宣言
int developer = employee.getDeveloper();
String langSkill = employee.getLangSkill();
String middleSkill = employee.getMiddleSkill();
String hobby = employee.getHobby();
String talent = employee.getTalent();
String intro = employee.getIntro();
String position = employee.getPosition();
if (position == null) {
	position = "";
}
%>

<html>
<head>
<!-- タイトル -->

<title>編集画面 | Home-Jack</title>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<script src="<%=request.getContextPath()%>/js/script.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Kosugi+Maru&display=swap')
	;

/* ページ全体（div）*/
#employeeUpdate {
	position: relative;
	width: 100%;
	text-align: center;
	overflow-x: hidden;
	z-index: 10;
}

#inputArea {
	margin: 50px auto;
	width: 80%;
}

#inputRow {
	height: 50px;
}

#item {
	padding-top: 10px;
	width: 20%;
	font-size: large;
	vertical-align: top;
}

#value {
	width: 60%;
}

img {
	width: 200px;
	height: auto;
}

input[type="text"], input[type="textarea"] {
	width: 100%;
}

input[type="text"] {
	height: 40px;
	font-size: large;
}

input[type="date"], input[type="month"] {
	width: 200px;
	height: 40px;
}

select {
	width: 50px;
	height: 40px;
	font-size: large;
}

input[type="number"] {
	margin-right: 5px;
	margin-left: 5px;
	width: 50px;
	height: 40px;
	font-size: large;
}

textarea {
	width: 100%;
	height: 200px;
	font-size: large;
	overflow-y: scroll;
	resize: none;
	line-height: 1.5;
}

a {
	text-decoration: none;
}

/* 以下ファイルアップロードのボタンです */
/* ファイル選択ボタンを完全に非表示にする */
input[type="file"] {
	display: none;
}

/* ファイルボタンの大枠 */
.fileFrame {
	display: flex;
	height: 30px;
}

/* ファイルボタン */
.fileUp {
	display: flex;
	justify-content: center; /* 水平方向の中央揃え */
	align-items: center; /* 垂直方向の中央揃え */
	padding: 0;
	border: 3px solid #000;
	color: #fff;
	text-decoration: none;
	border-radius: 5px;
	cursor: pointer;
	background-color: #7f8c8d;
	transition: .5s;
}

/* ファイルアイコンのボックス */
.fileBox {
	display: flex;
	justify-content: center; /* 水平方向の中央揃え */
	align-items: center; /* 垂直方向の中央揃え */
	height: 100%;
	width: 15%;
	padding: 0 5px 3px;
}

/* ファイルアイコン */
.fileIcon {
	display: inline-block;
	vertical-align: middle;
	stroke: #fff;
	fill: #fff;
	transition: .5s;
}

/* ファイルのテキストボックス */
.imageTextBox {
	display: flex;
	align-items: center; /* 垂直方向の中央揃え */
	height: 100%;
	width: 85%;
	padding: 0 5px;
	overflow: hidden;
}

/* ファイルの文字 */
.imageText {
	display: flex;
	font-size: 16px;
	font-style: italic;
	font-family: "Times New Roman", Times, serif;
}

.fileUp:hover {
	color: #7f8c8d;
	background-color: #fff;
}

.fileUp:hover .fileIcon {
	stroke: #7f8c8d;
	fill: #7f8c8d;
}

.fileUp:active .fileIcon {
	transform: rotateY(360deg);
	animation: rotate 3s forwards;
}

input[readonly] {
	background-color: transparent;
	border: none;
}

/* 以下矢印付きボタンのCSS */
/* aタグの初期CSSのリセット(左) */
.jackResetL {
	text-decoration: none;
	color: #000;
}

/* 矢印の枠 */
/* marginとかは自分で削ったり足したりしてくださいな */
.yoruArrow {
	display: flex;
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

/* アイコン */
.memo {
	display: inline-block;
	vertical-align: middle;
}

.confirmButton {
	display: inline-block;
	padding: 8px 16px;
	background-color: #4682b4;
	border: 3px solid #4682b4;
	border-radius: 5px;
	text-decoration: none;
	text-align: center;
	cursor: pointer;
}

.confirmButton span {
	vertical-align: middle;
	font-family: "Kosugi Maru", sans-serif;
	font-size: 21px;
	font-weight: 300;
	color: #fff;
	letter-spacing: 0.2em;
}

.confirmButton:hover {
	background-color: #fff;
	border: 3px solid #4682b4;
}

.confirmButton:hover .memo .path {
	stroke: #4682b4;
}

.confirmButton:hover span {
	color: #4682b4;
}

.btnList {
	width: 100%;
	margin-left: auto;
	margin-right: auto;
}

.cancel {
	width: 30%;
	padding-left: 50px;
}

.confirm {
	width: 40%;
	text-align: center;
}

.space {
	width: 30%;
}
</style>

<body>
	<div id="wrap">
		<!-- ヘッダー部分 -->
		<%@ include file="../common/header.jsp"%>

		<!-- メイン部分 -->
		<div id="main" class="container">

			<div id="employeeUpdate">

				<!-- 
				<h3>社員紹介 編集画面</h3>
				 -->

				<!-- 入力部分 -->
				<form action="<%=request.getContextPath()%>/employeeUpdate"
					method="post" enctype="multipart/form-data">

					<input type="hidden" name="work" value="update">

					<table id="inputArea">
						<tr id="inputRow">
							<td id="item"><label for="photo">写真</label></td>
							<td id="value">
								<div class="fileFrame">
									<label for="file-upload" class="fileUp">
										<div class="fileBox">
											<svg x="0px" y="0px" viewBox="-4 4 70 40" width="22"
												height="22" class="fileIcon error-file">
							<path d="M 30 2 L 30 42" stroke-width="3" fill="none"
													stroke-linecap="round" />
							<path d="M 30 42 L 30 45" stroke-width="3" fill="none" />
							<path d="M 30 2 L 13 18" stroke-width="3" fill="none" />
							<path d="M 30 2 L 47 18" stroke-width="3" fill="none" />
							<path d="M 0 35 L 0 55" stroke-width="3.5" fill="none" />
							<path d="M 0 55 L 60 55" stroke-width="3.5" fill="none" />
							<path d="M 60 55 L 60 35" stroke-width="3.5" fill="none" />
						</svg>
										</div>
										<div class="imageTextBox">
											<span id="file-name" class="imageText">Select File</span>
										</div>
									</label> <input id="file-upload" type="file" name="photo"
										accept="image/*">
								</div>
							</td>
						</tr>
						<tr id="inputRow">
							<td id="item"><label for="employeeNumber">社員番号</label></td>
							<td id="value"><%=employeeNumber%></td>
						</tr>
						<tr id="inputRow">
							<td id="item"><label for="name">氏名</label></td>
							<td id="value"><%=name%></td>
						</tr>
						<tr id="inputRow">
							<td id="item"><label for="nameKana">氏名（ふりがな）</label></td>
							<td id="value"><%=nameKana%></td>
						</tr>
						<tr id="inputRow">
							<td id="item"><label for="birthday">生年月日</label></td>
							<td id="value"><%=birthdayStr%></td>
						</tr>
						<tr id="inputRow">
							<td id="item"><label for="department">所属</label></td>
							<td><%=department%> <%=group%></td>
						</tr>
						<tr id="inputRow">
							<td id="item"><label for="joiningDate">入社年月</label></td>
							<td id="value"><%=joiningDateStr%></td>
						</tr>
						<tr id="inputRow">
							<td id="item"><label for="developer">開発経験年数</label></td>
							<td id="value"><input id="readonlyInput" type="number"
								name="developer" value="<%=developer%>" style="margin-left: 0;"
								min="0" readonly>年</td>
						</tr>
						<tr id="inputRow">
							<td id="item"><label for="langSkill">習得技術（言語）</label></td>
							<td id="value"><input id="readonlyInput" type="text"
								name="langSkill" value="<%=langSkill%>"></td>
						</tr>
						<tr id="inputRow">
							<td id="item"><label for="middleSkill">習得言語（ミドルウェア）</label></td>
							<td id="value"><input id="readonlyInput" type="text"
								name="middleSkill" value="<%=middleSkill%>"></td>
						</tr>
						<tr id="inputRow">
							<td id="item"><label for="hobby">趣味</label></td>
							<td id="value"><input id="readonlyInput" type="text"
								name="hobby" value="<%=hobby%>"></td>
						</tr>
						<tr id="inputRow">
							<td id="item"><label for="talent">特技</label></td>
							<td id="value"><input id="readonlyInput" type="text"
								name="talent" value="<%=talent%>"></td>
						</tr>
						<tr id="inputRow">
							<td id="item"><label for="intro">自己紹介</label></td>
							<td id="value"><textarea id="readonlyInput" name="intro"><%=intro%></textarea></td>
						</tr>
						<tr id="inputRow">
							<td id="item"><label for="position">役職</label></td>
							<td id="value"><input id="readonlyInput" type="text"
								name="position" value="<%=position%>"></td>
						</tr>
					</table>
					<table class="btnList">
						<tr>
							<td class="cancel">
								<div class="yoruArrow">
									<a
										href="<%=request.getContextPath()%>/employeeDetail
								?user_id=<%=userId%>
								&work=detail"
										class="jackResetL"> <svg class="arrow" width="50"
											height="20">
			<path d="M 0 10 L 50 10" stroke="#000" stroke-width="2" fill="none" />
			<path d="M 0 10 L 25 0" stroke="#000" stroke-width="2" fill="none" />
		</svg> <span class="beaf">CANCEL</span>
									</a>
								</div>
							</td>
							<td class="confirm">
							<!-- 
								<div class="confirmButton">
									<svg class="memo" xmlns="http://www.w3.org/2000/svg"
										viewBox="0 0 48 48" width="48px" height="48px">
										<rect width="48" height="48" fill="none" />
										<polyline class="path"
											points="17.5 23.48 22.5 28.48 30.5 20.48" fill="none"
											stroke="#fff" stroke-linecap="square" stroke-miterlimit="10"
											stroke-width="2" />
										<rect class="path" x="8" y="8" width="32" height="32" rx="2"
											stroke-width="2" stroke="#fff" stroke-linecap="round"
											stroke-linejoin="round" fill="none" /></svg>
									<input type="submit" name="submit" value="確認画面へ"
										style="width: 120px; height: 50px; font-size: large;">
									<input type="hidden" name="userId" value="<%=userId%>">
								</div>
							 -->
							 <button class="confirmButton">
							 <svg class="memo" xmlns="http://www.w3.org/2000/svg"
										viewBox="0 0 48 48" width="48px" height="48px">
										<rect width="48" height="48" fill="none" />
										<polyline class="path"
											points="17.5 23.48 22.5 28.48 30.5 20.48" fill="none"
											stroke="#fff" stroke-linecap="square" stroke-miterlimit="10"
											stroke-width="2" />
										<rect class="path" x="8" y="8" width="32" height="32" rx="2"
											stroke-width="2" stroke="#fff" stroke-linecap="round"
											stroke-linejoin="round" fill="none" /></svg>
							 <span>確認画面へ</span>
							 <input type="hidden" name="userId" value="<%=userId%>">
							 </button>
							</td>
							<td class="space">&nbsp;</td>
						</tr>
					</table>
					<!-- 
					<input type="submit" name="submit"
						value="確認画面へ"
						style="width: 120px; height: 50px; font-size: large;"> <input
						type="hidden" name="userId" value="<%=userId%>">
						 -->
					<!-- <span class="listText"></span> -->
				</form>
			</div>

		</div>
	</div>

	<script>
	//// 変数受け渡し
	//const cmd = "<%=cmd%>";
    //
	//	// 必要な要素を取得
	//	const readonlyInput = document.querySelectorAll("#readonlyInput");
	//	const form = document.querySelector("form");
    //
	//	if (cmd == "updateConfirm") {
	//		for (let i = 0; i < readonlyInput.length; i++) {
	//			readonlyInput[i].readOnly = true;
	//		}
    //
	//		// formに画像データ送信のためのエンコード設定
	//		form.enctype = "multipart/form-data";
	//	}

		// アップロードしたファイルをボタン内に表示
		const fileInput = document.getElementById('file-upload');
		const fileNameDisplay = document.getElementById('file-name');

		fileInput.addEventListener('change', (e) => {
		  // 選択されたファイルリストを取得
		  const files = e.target.files;
		  if (files.length > 0) {
		    // 最初のファイル名を取得して表示要素に設定
		    fileNameDisplay.textContent = files[0].name;
		  } else {
		    // ファイルが選択されていない場合は、元のテキストに戻す
		    fileNameDisplay.textContent = 'No files selected';
		  }
		});
	</script>
</body>
</html>
