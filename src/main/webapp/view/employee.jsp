<%@page contentType="text/html; charset=UTF-8"%>

<%@page
	import="java.util.ArrayList, util.MyFormat, util.CommonTable, bean.User, dao.UserDAO"%>

<%
// サーブレットから送られてきた情報を取得
ArrayList<User> userList = (ArrayList<User>) request.getAttribute("userList");
String[] photos = (String[]) request.getAttribute("photos");
// フォーマットを使用するためのオブジェクト生成
MyFormat myFormat = new MyFormat();
// フォーマット化された入社年月を格納するための配列宣言
String[] joiningDates = new String[userList.size()];
// タイムスタンプ型のデータを全てフォーマット化
for (int i = 0; i < userList.size(); i++) {
	joiningDates[i] = myFormat.yearMonthFormat(userList.get(i).getJoiningDate());
}

// オブジェクトの生成
User user = new User();
UserDAO userDAO = new UserDAO();
CommonTable commonTable = new CommonTable();

%>

<html>
<head>
<!-- タイトル -->
<title>一覧 - 社員紹介</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<script src="<%=request.getContextPath()%>/js/script.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<style>
/* ページ全体（div）*/
#employee {
	position: relative;
	width: 100%;
	text-align: center;
	overflow-x: hidden;
	z-index: 10;
}

/* タイトル部分*/
table {
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

/* 社員1人分（div）*/
#employee_card {
	display: inline-block;
	margin: 3px;
	width: 200px;
	height: 270px;
	/*	大きさが変わるときのスピード*/
	transition: 0.3s;
}

#employee_card:hover {
	/*	どれくらい大きくなるか*/
	transform: scale(1.1);
}

#employee_card img {
	width: 200px;
	height: 270px;
	/*	縦横比を固定する*/
	object-fit: cover;
}

/* 社員詳細に飛ぶリンク*/
a {
	text-align: center;
	text-decoration: none;
	/*	大きさが変わるときのスピード*/
	transition: 0.3s;
}

a:hover {
	/*	どれくらい大きくなるか*/
	transform: scale(1.1);
}

/* 社員一覧全体（div）*/
#employee_list {
	margin-right: auto;
	margin-left: auto;
}

/* 社員一覧の1行分*/
#employee_line {
	margin-top: 100px;
	margin-bottom: 100px;
	margin-left: 120px;
	text-align: left;
}

/* 社員名（p）*/
#employee_name {
	/*	画像の上に文字を重ねるため*/
	position: relative;
	top: -83px;
	margin: 0;
	width: 200px;
	background-color: rgba(255, 255, 255, 0.8);
	color: black;
	font-size: 25px;
	font-weight: 500;
	cursor: pointer;
}

/* 社員情報（p）*/
#employee_detail {
	/*	画像の上に文字を重ねるため*/
	position: relative;
	top: -83px;
	margin: 0;
	background-color: rgba(255, 255, 255, 0.8);
	color: black;
	font-size: 14px;
	cursor: pointer;
}
</style>

<body>
	<div id="wrap">
		<!-- ヘッダー部分 -->
		<%@ include file="../common/header.jsp"%>

		<!-- メイン部分 -->
		<div id="main" class="container">
			<div id="employee">
				<!-- タイトル部分 -->
				<table style="width: 80%;">
					<tr>
						<td style="width: 20%;"><input type="search" name="search"
							style="height: 20px;"> <img
							src="<%=request.getContextPath()%>/img/searchIcon.png"
							alt="検索アイコン" style="width: 30px; height: auto;"></td>
						<td style="width: 40%;">
							<h1>社員紹介</h1>
						</td>
						<td style="width: 20%;"><a
							href="<%=request.getContextPath()%>/view/employeeRegister.jsp?cmd=register">
								<input type="submit" value="登録"
								style="width: 80px; height: 50px; font-size: large;">
						</a></td>
					</tr>
				</table>

				<div id="employee_list">
					<!-- 社員一覧の1行分（5枚ずつ） -->
					<div id="employee_line">
						<%
						if (userList != null) {
							for (int i = 0; i < userList.size(); i++) {
								user = userDAO.selectByUserId(userList.get(i).getUserId());
								String department = commonTable.selectDepartment(user.getDepartmentId());
								String group = commonTable.selectGroup(user.getGroupId());
						%>
						<a
							href="<%=request.getContextPath()%>/detailEmployee?userId=<%=userList.get(i).getUserId()%>">
							<div id="employee_card">
								<img src="<%=request.getContextPath()%>/img/<%=photos[i]%>"
									alt="社員画像">
								<p id="employee_name"><%=userList.get(i).getName()%></p>
								<p id="employee_detail">
									<%= department %>
								</p>
								<p id="employee_detail">
									<%= group %>
								</p>
								<p id="employee_detail"><%=joiningDates[i]%>入社
								</p>
							</div>
						</a>
						<%
						// 5枚ずつにするため
						if ((i + 1) % 5 == 0) {
						%>
					</div>
					<div id="employee_line">
						<%
						}
						}
						}
						%>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>