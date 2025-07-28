<%@page contentType="text/html; charset=UTF-8"%>

<%@page
	import="java.text.SimpleDateFormat, java.util.Date, java.sql.Timestamp"%>

<!-- cmdで確認画面と編集画面分ける -->

<%
// cmdを取得
String cmd = (String)request.getAttribute("cmd");
System.out.print(cmd);
//String cmd = "confirm";

// 変数宣言
String photo = "";
String employeeNumber = "";
String name = "";
String nameKana = "";
String birthday = "";
String department = "";
String team = "";
String joiningDate = "";
int devloper = 0;
String langSkill = "";
String middleSkill = "";
String hobby = "";
String talent = "";
String intro = "";
String position = "";

// 確認画面の場合
if (cmd.equals("confirm")) {
// 入力された情報をJSPから取得
photo = request.getParameter("photo");
employeeNumber = request.getParameter("employeeNumber");
name = request.getParameter("name");
nameKana = request.getParameter("nameKana");

// String→Dateに変換
birthday = request.getParameter("birthday");
//String pattern = "yyyy-MM-dd";
//SimpleDateFormat format = new SimpleDateFormat(pattern);
//Date birthdayUtil = null;
//birthdayUtil = format.parse(dateString);
//java.sql.Date birthday = new java.sql.Date(birthdayUtil.getTime());

department = request.getParameter("department");
team = request.getParameter("team");

// String→Timestampに変換
joiningDate = request.getParameter("joiningDate");
//SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM");
//Date parsedTime = dateFormat.parse(timeString);
//Timestamp joiningDate = new Timestamp(parsedTime.getTime());

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
if (cmd.equals("update")) {
%>
<title>編集 - 社員紹介</title>
<%
} else if (cmd.equals("confirm")) {
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
</style>

<body>
	<div id="wrap">
		<!-- ヘッダー部分 -->
		<%@ include file="../common/header.jsp"%>

		<!-- メイン部分 -->
		<div id="main" class="container">

			<div id="employeeUpdate">
			
				<%
				if (cmd.equals("confirm")) {
				%>
				<h3>以下の内容で登録します</h3>
				<%
				}
				%>
			
				<!-- 入力部分 -->
				<form action="<%= request.getContextPath() %>/employeeRegister" method="post">
					<table id="inputArea">
						<tr id="inputRow">
							<td id="item"><label for="photo">写真</label></td>
						<%
						if (cmd.equals("update")) {
						%>
							<td id="value"><input type="file" name="photo"></td>
						<%
						} else if (cmd.equals("confirm")) {
						%>
							<td id="value"><img
								src="<%= request.getContextPath() %>/img/<%= photo %>"
								alt="アップロードした写真"></td>
						<%
						}
						%>
						</tr>
						<tr id="inputRow">
							<td id="item"><label for="employeeNumber">社員番号</label></td>
							<td id="value"><input id="readonlyInput" type="text"
								name="employeeNumber" value="<%= employeeNumber %>"></td>
						</tr>
						<tr id="inputRow">
							<td id="item"><label for="name">氏名</label></td>
							<td id="value"><input id="readonlyInput" type="text"
								name="name" value="<%= name %>"></td>
						</tr>
						<tr id="inputRow">
							<td id="item"><label for="nameKana">氏名（ふりがな）</label></td>
							<td id="value"><input id="readonlyInput" type="text"
								name="nameKana" value="<%= nameKana %>"></td>
						</tr>
						<tr id="inputRow">
							<td id="item"><label for="birthday">生年月日</label></td>
							<td id="value"><input id="readonlyInput" type="date"
								name="birthday" value="<%= birthday %>"></td>
						</tr>
						<tr id="inputRow">
							<td id="item"><label for="department">部</label> <label
								for="team">・グループ</label></td>
						<%
						if (cmd.equals("update")) {
						%>
							<td id="value">第 <select name="department">
									<option value=""></option>
									<option value="1">1</option>
									<option value="2">2</option>
							</select> 事業部 第 <select name="team">
									<option value=""></option>
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
							</select> グループ
							</td>
						<%
						} else if (cmd.equals("confirm")) {
						%>
							<td id="value">第 <%= department %> 事業部 第 <%= team %> グループ
							</td>
						<%
						}
						%>

						</tr>
						<tr id="inputRow">
							<td id="item"><label for="joiningDate">入社年月</label></td>
							<td id="value"><input id="readonlyInput" type="month"
								name="joiningDate" value="<%= joiningDate %>">
							</td>
						</tr>
						<tr id="inputRow">
							<td id="item"><label for="devloper">開発経験年数</label></td>
							<td id="value"><input id="readonlyInput" type="number"
								name="devloper" value="<%= devloper %>" style="margin-left: 0;"
								min="0">年</td>
						</tr>
						<tr id="inputRow">
							<td id="item"><label for="langSkill">習得技術（言語）</label></td>
							<td id="value"><input id="readonlyInput" type="text"
								name="langSkill" value="<%= langSkill %>"></td>
						</tr>
						<tr id="inputRow">
							<td id="item"><label for="middleSkill">習得言語（ミドルウェア）</label>
							</td>
							<td id="value"><input id="readonlyInput" type="text"
								name="middleSkill" value="<%= middleSkill %>">
							</td>
						</tr>
						<tr id="inputRow">
							<td id="item"><label for="hobby">趣味</label></td>
							<td id="value"><input id="readonlyInput" type="text"
								name="hobby" value="<%= hobby %>"></td>
						</tr>
						<tr id="inputRow">
							<td id="item"><label for="talent">特技</label></td>
							<td id="value"><input id="readonlyInput" type="text"
								name="talent" value="<%= talent %>"></td>
						</tr>
						<tr id="inputRow">
							<td id="item"><label for="intro">自己紹介</label></td>
							<td id="value"><textarea id="readonlyInput" name="intro"><%= intro %></textarea>
							</td>
						</tr>
						<tr id="inputRow">
							<td id="item"><label for="position">役職</label></td>
							<td id="value"><input id="readonlyInput" type="text"
								name="position" value="<%= position %>"></td>
						</tr>
					</table>

					<a href="<%= request.getContextPath() %>/view/employeeRegister.jsp">
						<input type="button" value="戻る"
						style="width: 120px; height: 50px; font-size: large;">
					</a> <input type="submit" value="完了"
						style="width: 120px; height: 50px; font-size: large;">
				</form>

			</div>

		</div>
	</div>

	<script>
	// 変数受け渡し
	const cmd = "<%= cmd %>";

	// 必要な要素を取得
	const readonlyInput = document.querySelectorAll("#readonlyInput");

	if (cmd == "confirm") {
		for (let i = 0; i < readonlyInput.length; i++) {
			readonlyInput[i].readOnly = true;
		}
	}
	</script>
</body>
</html>
