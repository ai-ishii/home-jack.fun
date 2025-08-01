<%@page contentType="text/html; charset=UTF-8"%>

<html>
<head>
<!-- タイトル -->
<title>登録 - 社員紹介</title>
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
			
			<!-- 入力部分 -->
			<form action="<%= request.getContextPath() %>/view/employeeUpdate.jsp" method="post">
			<input type="hidden" name="cmd" value="confirm">
			<table id="inputArea">
				<tr id="inputRow">
					<td id="item">
						<label for="photo">写真</label>
					</td>
					<td id="value">
						<input type="file" name="photo">
					</td>
				</tr>
				<tr id="inputRow">
					<td id="item">
						<label for="employeeNumber">社員番号</label>
					</td>
					<td id="value">
						<input type="text" name="employeeNumber">
					</td>
				</tr>
				<tr id="inputRow">
					<td id="item">
						<label for="name">氏名</label>
					</td>
					<td id="value">
						<input type="text" name="name">
					</td>
				</tr>
				<tr id="inputRow">
					<td id="item">
						<label for="nameKana">氏名（ふりがな）</label>
					</td>
					<td id="value">
						<input type="text" name="nameKana">
					</td>
				</tr>
				<tr id="inputRow">
					<td id="item">
						<label for="birthday">生年月日</label>
					</td>
					<td id="value">
						<input type="date" name="birthday">
					</td>
				</tr>
				<tr id="inputRow">
					<td id="item">
					<!-- 
						<label for="department">部</label>
						<label for="team">・グループ</label>
					 -->
					 <label for="belong">所属</label>
					</td>
					<td id="value">
						第
						<select name="department">
							<option value=""></option>
							<option value="1">1</option>
							<option value="2">2</option>
						</select>
						事業部　
						第
						<select name="team">
							<option value=""></option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
						</select>
						グループ
					</td>
				</tr>
				<tr id="inputRow">
					<td id="item">
						<label for="joiningDate">入社年月</label>
					</td>
					<td id="value">
						<input type="month" name="joiningDate">
					</td>
				</tr>
				<tr id="inputRow">
					<td id="item">
						<label for="devloper">開発経験年数</label>
					</td>
					<td id="value">
						<input type="number" name="devloper" style="margin-left: 0;" min="0">年
					</td>
				</tr>
				<tr id="inputRow">
					<td id="item">
						<label for="langSkill">習得技術（言語）</label>
					</td>
					<td id="value">
						<input type="text" name="langSkill">
					</td>
				</tr>
				<tr id="inputRow">
					<td id="item">
						<label for="middleSkill">習得言語（ミドルウェア）</label>
					</td>
					<td id="value">
						<input type="text" name="middleSkill">
					</td>
				</tr>
				<tr id="inputRow">
					<td id="item">
						<label for="hobby">趣味</label>
					</td>
					<td id="value">
						<input type="text" name="hobby">
					</td>
				</tr>
				<tr id="inputRow">
					<td id="item">
						<label for="talent">特技</label>
					</td>
					<td id="value">
						<input type="text" name="talent">
					</td>
				</tr>
				<tr id="inputRow">
					<td id="item">
						<label for="intro">自己紹介</label>
					</td>
					<td id="value">
						<textarea name="intro"></textarea>
					</td>
				</tr>
				<tr id="inputRow">
					<td id="item">
						<label for="position">役職</label>
					</td>
					<td id="value">
						<input type="text" name="position">
					</td>
				</tr>
			</table>
			
			<a href="<%= request.getContextPath() %>/employee">
			<input type="button" value="キャンセル" style="width: 120px; height: 50px; font-size: large;">
			</a>
			<input type="submit" value="確認画面へ" style="width: 120px; height: 50px; font-size: large;">
			</form>
			</div>
		</div>
	</div>
</body>
</html>