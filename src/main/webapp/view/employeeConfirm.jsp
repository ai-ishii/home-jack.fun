<!-- 社員紹介 変更確認機能（作：石井） -->
<!-- 作成日：7/18　最終更新日：8/22 16:00 -->

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
account = (Account)session.getAttribute("account");
int userId_session = (int)session.getAttribute("user_id");
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
String work = (String) request.getAttribute("work");

// 画像のURLを取得
// String tempFileName = (String) request.getAttribute("tempFileName");

// 変数宣言
int developer = employee.getDeveloper();
String langSkill = employee.getLangSkill();
String middleSkill = employee.getMiddleSkill();
String hobby = employee.getHobby();
String talent = employee.getTalent();
String intro = employee.getIntro();
String position = employee.getPosition();

%>

<html>
<head>
<!-- タイトル -->
<title>確認画面 - 社員紹介</title>
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


				<h3>以下の内容で変更します</h3>

				<!-- 入力部分 -->
				<form action="<%= request.getContextPath() %>/employeeCommit" method="post" >
					
						<table id="inputArea">
							<tr id="inputRow">
								<td id="item"><label for="photo">写真</label></td>
								
								<td id="value">
									<img src="employeePhoto?user_id=<%= user.getUserId() %>&work=<%=work%>" 
									alt="アップロードした写真">
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
								<td id="value"><input id="readonlyInput" type="number" name="developer" value="<%=developer%>" style="margin-left: 0;" min="0">年</td>
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

						
						<input type="submit" name="confirm" value="編集画面に戻る" style="width: 120px; height: 50px; font-size: large;">
						<input type="hidden" name="userId" value="<%= userId %>">
						
						<input type="hidden" name="user_id" value="<%= user.getUserId() %>">
						<input type="submit" name="confirm" value="完了" style="width: 120px; height: 50px; font-size: large;">
						
					</form>
			</div>

		</div>
	</div>

	<script>
	// 変数受け渡し
	// const cmd = "%=cmd%>";

		// 必要な要素を取得
		// const readonlyInput = document.querySelectorAll("#readonlyInput");
		// const form = document.querySelector("form");

		// if (cmd == "updateConfirm") {
		// 	for (let i = 0; i < readonlyInput.length; i++) {
		// 		readonlyInput[i].readOnly = true;
		// 	}

			// formに画像データ送信のためのエンコード設定
		// 	form.enctype = "multipart/form-data";
		// }
	</script>
</body>
</html>
