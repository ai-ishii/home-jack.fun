<%@page contentType="text/html; charset=UTF-8"%>

<%
// セッションでユーザーのデータを取得

// cmdを取得
String cmd = request.getParameter("cmd");
//String cmd = "confirm";

// 変数宣言
String photo = "";
String employeeNumber = "";
String name = "";
String nameKana = "";
String birthday = "";
String department = "";
String group = "";
String joiningDate = "";
int devloper = 0;
String langSkill = "";
String middleSkill = "";
String hobby = "";
String talent = "";
String intro = "";
String position = "";

// 確認画面の場合
if (cmd.equals("confirm") || cmd.equals("reRegister")) {
	// 入力された情報をJSPから取得
	photo = request.getParameter("photo");
	employeeNumber = request.getParameter("employeeNumber");
	name = request.getParameter("name");
	nameKana = request.getParameter("nameKana");

	// String→Dateに変換
	birthday = request.getParameter("birthday");

	department = request.getParameter("department");
	group = request.getParameter("group");

	// String→Timestampに変換
	joiningDate = request.getParameter("joiningDate");

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
				if (cmd.equals("confirm")) {
				%>
				<h3>以下の内容で登録します</h3>
				<%
				}
				%>

				<!-- 入力部分 -->
				<%
				if (cmd.equals("register") || cmd.equals("reRegister")) {
				%>
				<form action="<%=request.getContextPath()%>/view/employeeRegister.jsp" method="post">
					<input type="hidden" name="cmd" value="confirm">
					<%
					} else if (cmd.equals("confirm")) {
					%>
					<form action="<%=request.getContextPath()%>/employeeRegister" method="post">
						<input type="hidden" name="cmd" value="reRegister">
						<%
						}
						%>

						<table id="inputArea">
							<tr id="inputRow">
								<td id="item"><label for="photo">写真</label></td>
								<%
								if (cmd.equals("register") || cmd.equals("reRegister")) {
								%>
								<td id="value"><input type="file" name="photo"></td>
								<%
								} else if (cmd.equals("confirm")) {
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
								<td id="value"><input id="readonlyInput" type="text" name="employeeNumber" value="<%=employeeNumber%>"></td>
							</tr>
							<tr id="inputRow">
								<td id="item"><label for="name">氏名</label></td>
								<td id="value"><input id="readonlyInput" type="text" name="name" value="<%=name%>"></td>
							</tr>
							<tr id="inputRow">
								<td id="item"><label for="nameKana">氏名（ふりがな）</label></td>
								<td id="value"><input id="readonlyInput" type="text" name="nameKana" value="<%=nameKana%>"></td>
							</tr>
							<tr id="inputRow">
								<td id="item"><label for="birthday">生年月日</label></td>
								<td id="value"><input id="readonlyInput" type="date" name="birthday" value="<%=birthday%>"></td>
							</tr>
							<tr id="inputRow">
								<td id="item"><label for="department">所属</label></td>
								<%
								if (cmd.equals("register") || cmd.equals("reRegister")) {
								%>
								<td id="value">
									<select name="department">
										<option value="" selected disabled></option>
										<option value="ビジネスソリューション第1部">ビジネスソリューション第1部</option>
										<option value="ビジネスソリューション第2部">ビジネスソリューション第2部</option>
										<option value="営業部">営業部</option>
										<option value="NEXTINOVATION">NEXTINOVATION</option>
										<option value="経営管理部">経営管理部</option>
									</select> 
									<select name="group">
										<option value="" selected disabled></option>
										<option value="／">／</option>
										<option value="第1グループ">第1グループ</option>
										<option value="第2グループ">第2グループ</option>
										<option value="第3グループ">第3グループ</option>
										<option value="第4グループ">第4グループ</option>
									</select>
								</td>
								<%
								} else if (cmd.equals("confirm")) {
								%>
								<td id="value"><%=department%> <%=group%></td>
								<%
								}
								%>

							</tr>
							<tr id="inputRow">
								<td id="item"><label for="joiningDate">入社年月</label></td>
								<td id="value"><input id="readonlyInput" type="month" name="joiningDate" value="<%=joiningDate%>"></td>
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
						<a href="<%=request.getContextPath()%>/employee">
							<input type="button" value="キャンセル" style="width: 120px; height: 50px; font-size: large;">
						</a>
						<%
						} else if (cmd.equals("confirm")) {
						%>
						<a href="<%=request.getContextPath()%>/view/employeeRegister.jsp?cmd=register">
							<input type="button" value="戻る" style="width: 120px; height: 50px; font-size: large;">
						</a>
						<%
						}
						if (cmd.equals("register") || cmd.equals("reRegister")) {
						%>
						<input type="submit" value="確認画面へ" style="width: 120px; height: 50px; font-size: large;">
						<%
						} else if (cmd.equals("confirm")) {
						%>
						<input type="submit" value="完了" style="width: 120px; height: 50px; font-size: large;">
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

		if (cmd == "confirm") {
			for (let i = 0; i < readonlyInput.length; i++) {
				readonlyInput[i].readOnly = true;
			}
		}
	</script>

</body>
</html>
