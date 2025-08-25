<!-- 社員紹介 登録機能（作：石井） -->
<!-- 作成日：7/17　最終更新日：8/25 14:26 -->

<%@page contentType="text/html; charset=UTF-8"%>

<%@page
	import="bean.Account, bean.User, dao.UserDAO, util.CommonTable, util.MyFormat, java.sql.Timestamp, java.util.Date, java.text.SimpleDateFormat"%>

<!-- cmdで確認画面と登録画面分ける -->

<%
// オブジェクトの生成
Account account = new Account();
User user = new User();
UserDAO userDAO = new UserDAO();
CommonTable commonTable = new CommonTable();

// セッションでユーザーのデータを取得
account = (Account) session.getAttribute("account");
int userId = (int) session.getAttribute("user_id");
String name = (String) session.getAttribute("user_name");

// セッションからユーザー情報を取得
user = userDAO.selectByUserId(userId);

String employeeNumber = user.getEmployeeNumber();
String nameKana = user.getNameKana();
Date birthday = user.getBirthday();
int departmentId = user.getDepartmentId();
int groupId = user.getGroupId();
Timestamp joiningDate = user.getJoiningDate();

// フォーマット化し表示形式を変更
MyFormat myFormat = new MyFormat();
String birthdayStr = myFormat.birthDateFormat(birthday);
String joiningDateStr = myFormat.yearMonthFormat(joiningDate);

// 疑似テーブルメソッドからデータを取得
String department = commonTable.selectDepartment(departmentId);
String group = commonTable.selectGroup(groupId);

// cmdを取得
String cmd = request.getParameter("cmd");

// 変数宣言
String photo = "";
int developer = 0;
String langSkill = "";
String middleSkill = "";
String hobby = "";
String talent = "";
String intro = "";
String position = "";

// 確認画面の場合と登録画面に戻った場合
if (cmd.equals("registerConfirm") || cmd.equals("reRegister")) {
	// 入力された情報をJSPから取得
	photo = request.getParameter("photo");
	developer = Integer.parseInt(request.getParameter("developer"));
	langSkill = request.getParameter("langSkill");
	middleSkill = request.getParameter("middleSkill");
	hobby = request.getParameter("hobby");
	talent = request.getParameter("talent");
	intro = request.getParameter("intro");
	position = request.getParameter("position");
}
%>

<html>
<head>
<!-- タイトル -->
<%
if (cmd.equals("register") || cmd.equals("reRegister")) {
%>
<title>社員紹介登録 | Home-Jack</title>
<%
} else if (cmd.equals("registerConfirm")) {
%>
<title>確認画面 | Home-Jack</title>
<%
}
%>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<script src="<%=request.getContextPath()%>/js/script.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<style>
/* ページ全体（div）*/
#employeeRegister {
	position: relative;
	width: 100%;
	text-align: center;
	overflow-x: hidden;
	z-index: 10;
}

/* タイトル部分*/
#title {
	margin-right: auto;
	margin-left: auto;
	background-image: linear-gradient(90deg, #b2d5de 0 25%, #ddcfb3 25% 50%, #b3ddb4 50% 75%,
		#ddbab3 75%);
	background-repeat: no-repeat;
	background-size: 100% 0.3rem;
	background-position: bottom;
	color: #353535;
	font-weight: bold;
	text-align: center;
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
	width: 300px;
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

/* 以下矢印付きボタンのCSS */
/* aタグの初期CSSのリセット(左) */
.jackResetL{
text-decoration: none;
color: #000;
}

/* 矢印の枠 */
/* marginとかは自分で削ったり足したりしてくださいな */
.yoruArrow{
display: flex;
align-items: center;
height: 30px;
width: 85%;
margin: 30px auto 0;
}

/* 矢印 */
.arrow{
display: inline-block;
vertical-align: middle;
transition: transform 0.5s ease;
overflow: visible; 				/* はみ出た内容を表示させる */
}

/* 矢印文字 */
.beaf{
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
</style>

<body>
	<div id="wrap">
		<!-- ヘッダー部分 -->
		<%@ include file="../common/header.jsp"%>

		<!-- メイン部分 -->
		<div id="main" class="container">
			<div id="employeeRegister">
				<!-- タイトル部分 -->
				<table id="title" style="width: 80%;">
					<tr>
						<td style="width: 20%;">&nbsp;</td>
						<td style="width: 40%;">
							<h1>社員登録</h1>
						</td>
						<td style="width: 20%;">&nbsp;</td>
						</a>
					</tr>
				</table>

				<%
				if (cmd.equals("registerConfirm")) {
				%>
				<h3>以下の内容で登録します</h3>
				<%
				}
				%>

				<!-- 入力部分 -->
				<form action="<%=request.getContextPath()%>/employeeConfirm"
					method="post">
					<table id="inputArea">
						<tr id="inputRow">
							<td id="item"><label for="photo">写真</label></td>
							<%
							if (cmd.equals("register") || cmd.equals("reRegister")) {
							%>
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
									</label> <input id="file-upload" type="file"
										accept=".png, .jpg, .jpeg, .gif" name="image" value="" />
								</div>
							</td>
							<%
							} else if (cmd.equals("registerConfirm")) {
							%>
							<td id="value"><img
								src="<%=request.getContextPath()%>/img/<%=photo%>"
								alt="アップロードした写真"></td>
							<%
							}
							%>
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
								min="0">年</td>
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

					<%
					if (cmd.equals("register") || cmd.equals("reRegister")) {
					%>
					<div class="yoruArrow">
						<a href="<%=request.getContextPath()%>/employee"
							class="jackResetL"> <svg class="arrow" width="50" height="20">
			<path d="M 0 10 L 50 10" stroke="#000" stroke-width="2" fill="none" />
			<path d="M 0 10 L 25 0" stroke="#000" stroke-width="2" fill="none" />
		</svg> <span class="beaf">CANCEL</span>
						</a>
					</div>
					<%
					} else if (cmd.equals("registerConfirm")) {
					%>
					<input type="submit" name="registerSubmit" value="戻る"
						style="width: 120px; height: 50px; font-size: large;">
					<%
					}
					if (cmd.equals("register") || cmd.equals("reRegister")) {
					%>
					<input type="submit" name="registerSubmit" value="確認画面へ"
						style="width: 120px; height: 50px; font-size: large;">
					<%
					} else if (cmd.equals("registerConfirm")) {
					%>
					<input type="submit" name="registerSubmit" value="完了"
						style="width: 120px; height: 50px; font-size: large;">
					<%
					}
					%>
				</form>
			</div>
		</div>
	</div>

	<script>
	// 変数受け渡し
	//const cmd = "<%=cmd%>";
    //
	//// 必要な要素を取得
	//const readonlyInput = document.querySelectorAll("#readonlyInput");
	//const confirmButton = document.querySelectorAll("#confirmButton");
	//const hidden = document.querySelector("#hidden");
	//
	//if (cmd == "registerConfirm") {
	//	for (let i = 0; i < readonlyInput.length; i++) {
	//		readonlyInput[i].readOnly = true;
	//	}
	//}

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
