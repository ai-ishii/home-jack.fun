<!-- 社員紹介 登録機能（作：石井） -->
<!-- 作成日：7/17　最終更新日：8/1 12:00 -->

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
account = (Account)session.getAttribute("account");
int userId = (int)session.getAttribute("user_id");
String name = (String)session.getAttribute("name");

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
int devloper = 0;
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
	devloper = Integer.parseInt(request.getParameter("devloper"));
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
<title>登録 - 社員紹介</title>
<%
} else if (cmd.equals("registerConfirm")) {
%>
<title>確認画面 - 社員紹介</title>
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
				<form action="<%= request.getContextPath() %>/employeeConfirm" method="post">
						<table id="inputArea">
							<tr id="inputRow">
								<td id="item"><label for="photo">写真</label></td>
								<%
								if (cmd.equals("register") || cmd.equals("reRegister")) {
								%>
								<td id="value"><input type="file" name="photo"></td>
								<%
								} else if (cmd.equals("registerConfirm")) {
								%>
								<td id="value">
									<img src="<%=request.getContextPath()%>/img/<%=photo%>" alt="アップロードした写真">
								</td>
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
								<td id="item"><label for="devloper">開発経験年数</label></td>
								<td id="value"><input id="readonlyInput" type="number" name="devloper" value="<%=devloper%>" style="margin-left: 0;"
									min="0">年</td>
							</tr>
							<tr id="inputRow">
								<td id="item"><label for="langSkill">習得技術（言語）</label></td>
								<td id="value"><input id="readonlyInput" type="text" name="langSkill" value="<%=langSkill%>"></td>
							</tr>
							<tr id="inputRow">
								<td id="item"><label for="middleSkill">習得言語（ミドルウェア）</label></td>
								<td id="value"><input id="readonlyInput" type="text" name="middleSkill" value="<%=middleSkill%>"></td>
							</tr>
							<tr id="inputRow">
								<td id="item"><label for="hobby">趣味</label></td>
								<td id="value"><input id="readonlyInput" type="text" name="hobby" value="<%=hobby%>"></td>
							</tr>
							<tr id="inputRow">
								<td id="item"><label for="talent">特技</label></td>
								<td id="value"><input id="readonlyInput" type="text" name="talent" value="<%=talent%>"></td>
							</tr>
							<tr id="inputRow">
								<td id="item"><label for="intro">自己紹介</label></td>
								<td id="value"><textarea id="readonlyInput" name="intro"><%=intro%></textarea></td>
							</tr>
							<tr id="inputRow">
								<td id="item"><label for="position">役職</label></td>
								<td id="value"><input id="readonlyInput" type="text" name="position" value="<%=position%>"></td>
							</tr>
						</table>

						<%
						if (cmd.equals("register") || cmd.equals("reRegister")) {
						%>
						<a href="<%= request.getContextPath() %>/employee">
							<input type="button" value="キャンセル" style="width: 120px; height: 50px; font-size: large;">
						</a>
						<%
						} else if (cmd.equals("registerConfirm")) {
						%>
							<input type="submit" name="registerSubmit" value="戻る" style="width: 120px; height: 50px; font-size: large;">
						<%
						}
						if (cmd.equals("register") || cmd.equals("reRegister")) {
						%>
							<input type="submit" name="registerSubmit" value="確認画面へ" style="width: 120px; height: 50px; font-size: large;">
						<%
						} else if (cmd.equals("registerConfirm")) {
						%>
							<input type="submit"  name="registerSubmit" value="完了" style="width: 120px; height: 50px; font-size: large;">
						<%
						}
						%>
					</form>
			</div>
		</div>
	</div>

	<script>
	// 変数受け渡し
	const cmd = "<%=cmd%>";

		// 必要な要素を取得
		const readonlyInput = document.querySelectorAll("#readonlyInput");
		const confirmButton = document.querySelectorAll("#confirmButton");
		const hidden = document.querySelector("#hidden");

		if (cmd == "registerConfirm") {
			for (let i = 0; i < readonlyInput.length; i++) {
				readonlyInput[i].readOnly = true;
			}
		}
	</script>

</body>
</html>
