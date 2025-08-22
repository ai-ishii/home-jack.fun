<!-- 社員紹介 一覧機能（作：石井） -->
<!-- 作成日：7/2　最終更新日：8/22 12:00 -->

<%@page contentType="text/html; charset=UTF-8"%>

<%@page
	import="java.util.ArrayList, util.MyFormat, util.CommonTable, bean.User, bean.Employee, dao.UserDAO"%>

<%
// サーブレットから送られてきた情報を取得
ArrayList<User> userList = (ArrayList<User>) request.getAttribute("userList");
ArrayList<Employee> employeeList = (ArrayList<Employee>) request.getAttribute("employeeList");
// String[] photos = (String[]) request.getAttribute("photos");
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
	top: -96px;
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
	top: -96px;
	margin: 0;
	background-color: rgba(255, 255, 255, 0.8);
	color: black;
	font-size: 14px;
	cursor: pointer;
	
}

.filter_box {
	position: relative;
}

/* モーダルを開くボタン */
.modal_open {
	font-size: 16px;
	width: 120px;
	height: 50px;
	border: none;
	color: #777;
	background: #e8e0fe;
	cursor: pointer;
}

/* モーダルと背景の指定 */
.modal {
	display: none;
	position: absolute;
	top: 50px;
	width: 200%;
	max-height: 100%;
	text-align: center;
	overflow: visible;
	transition: .3s;
	box-sizing: border-box;
}

/* モーダルの擬似要素の指定 */
.modal:before {
	content: "";
	display: inline-block;
	vertical-align: middle;
	height: 100%;
	margin-left: -0.2em;
}

/* クラスが追加された時の指定 */
.modal.is-active {
	display: block;
	z-index: 20;
}

/* モーダル内側の指定 */
.modal_container {
	position: absolute;
	top: 0;
	width: 100%;
}

/* モーダルを閉じるボタンの指定 */
.modal_close {
	position: absolute;
	display: flex;
	align-items: center;
	justify-content: center;
	top: -20px;
	right: -20px;
	width: 40px;
	height: 40px;
	color: #fff;
	background: #000;
	border-radius: 50%;
	cursor: pointer;
}

/* モーダルのコンテンツ部分の指定 */
.modal_content {
	background: #e8e0fe;
	text-align: left;
	line-height: 1.8;
	border-radius: 5px;
	padding: 10px;
	margin-top: 10px;
}

.modal_content label {
	color: #777;
}

/* モーダルのコンテンツ部分のテキストの指定 */
.modal_content p {
	margin: 1em 0;
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
						
						<td style="width: 20%;">
							<form action="<%=request.getContextPath() %>/employeeSearch" class="search-form">
							<input type="search" name="keyword"
								style="height: 20px;"> 
							<button type="submit" aria-label="検索"></button>
						</form>
						</td>
						
						
						
						
						
						
						
						
						
						
						<!--　絞り込み検索を作成する予定ですというメモです。
						<td>
						<div class="filter_box">
					
					  
						<button type="button" class="modal_open js_modal_open">絞り込み　∨</button>
						
						
						<div class="modal js_modal">
							<div class="modal_container">
								<div class="modal_close js_modal_close">×</div>
						</div>
						</div>
						<div>
							<label for="category">カテゴリ</label>
								<select id="category">
									<option value="">全カテゴリ</option>
								</select>
							</div>
							<div>
								<label for="hobby">趣味</label>
							</div>
						</div>
						
						</td>
						
						-->
						
						
						
						
						
						
						
						
						
						
						
						
						
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
								<img src="<%=request.getContextPath()%>/employeePhoto
									?user_id=<%=userList.get(i).getUserId()%>&work=view"
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
		
	<script>
		const modal = document.querySelector('.js_modal'), 
			open = document.querySelector('.js_modal_open'), 
			close = document.querySelector('.js_modal_close'),
			content = document.querySelector('.js_modal_content');

		function modalOpen() {
			modal.classList.add('is-active');
		}
		open.addEventListener('click', modalOpen);

		function modalClose() {
			modal.classList.remove('is-active');
		}
		close.addEventListener('click', modalClose);

		function modalOut() {
			modal.classList.remove('is-active');
		}
		addEventListener('blur', modalOut);

		
	</script>
</body>
</html>