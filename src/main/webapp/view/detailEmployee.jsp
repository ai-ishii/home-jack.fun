<%@page contentType="text/html; charset=UTF-8"%>

<%@page
	import="java.util.Arrays, java.util.ArrayList, util.MyFormat, bean.Employee, bean.User, dao.EmployeeDAO"%>

<%
EmployeeDAO employeeDAO = new EmployeeDAO();

//サーブレットから送られてきた情報を取得
Employee employee = (Employee) request.getAttribute("Employee");
User user = (User) request.getAttribute("User");
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

//--------画像の取得-----------
String[] sameBelong_imgList = new String[userListBySameBelong.size()];
String[] sameJoinTiming_imgList = new String[userListBySameJoiningDate.size()];
for (int i = 0; i < userListBySameBelong.size(); i++) {
	sameBelong_imgList[i] = employeeDAO.selectPhotoByUserId(userListBySameBelong.get(i).getUserId());
}
for (int i = 0; i < userListBySameJoiningDate.size(); i++) {
	sameJoinTiming_imgList[i] = employeeDAO.selectPhotoByUserId(userListBySameJoiningDate.get(i).getUserId());
}
%>

<html>
<head>
<!-- タイトル -->
<title>社員紹介 - 詳細</title>
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

#buttonList {
	margin-top: 30px;
	margin-right: 30px;
	text-align: right;
}

#mainEmployee {
	margin-top: 50px;
	margin-right: auto;
	margin-bottom: 50px;
	margin-left: auto;
	width: 80%;
}

#employee_imgArea {
	width: 40%;
}

#employee_infoArea {
	width: 40%;
}

/* メインで出す社員画像（img）*/
#employee_img {
	margin-top: auto;
	margin-right: 30px;
	margin-bottom: auto;
	width: 420px;
	height: auto;
	/*	縦横比を固定する*/
	object-fit: none;
}

#belong_img, #joinTiming_img {
	width: 220px;
	height: 300px;
	/*	縦横比を固定する*/
	object-fit: cover;
}

/* 社員情報をまとめた領域（div）*/
#employee_info {
	margin-left: 10px;
	width: 500px;
	text-align: left;
}

/* メインで出す社員名（p）*/
#detailEmployee_name {
	margin: 0;
	margin-right: 20px;
	font-size: 80px;
}

/*社員名と社員名フリガナを横並びにする*/
#detailEmployee_name, #detailEmployee_kana {
	display: inline-block;
}

/*社員所属と社員入社年を横並びにする*/
#detailEmployee_belong, #detailEmployee_joinTiming {
	line-height: 0.8;
}

#intro_area {
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
#imgSlider_area {
	margin-top: 30px;
	margin-right: auto;
	margin-left: auto;
	width: 80%;
}

/* 社員候補のタイトル（div）*/
#belong_title, #joinTiming_title {
	margin-bottom: 30px;
	text-align: left;
	font-size: 30px;
	font-weight: 500;
}

/* 入社年月の下に線*/
#detailEmployee_joinTiming+p {
	padding-top: 10px;
	margin: 0;
	border-top: solid 1px gray;
}

/* 画像スライダー（div）*/
#img_slider {
	position: relative;
	height: 20%;
}

a {
	text-decoration: none;
}

/* 画像スライダーの中の社員1人分の画像&情報（div）*/
#employee_card {
	display: inline-block;
	margin-right: 25px;
	margin-left: 25px;
	width: 20%;
	height: 200px;
	/*	大きさが変わるときのスピード*/
	transition: 0.3s;
}

#employee_card:hover {
	/*	どれくらい大きくなるか*/
	transform: scale(1.1);
}

/* 社員名（p）*/
#employee_name {
	/*	画像の上に文字を重ねるため*/
	position: relative;
	top: -90px;
	margin: 0;
	width: 220px;
	background-color: rgba(255, 255, 255, 0.8);
	color: black;
	font-size: 30px;
	font-weight: 500;
	cursor: pointer;
}

/* 社員情報（p）*/
#employee_detail {
	/*	画像の上に文字を重ねるため*/
	position: relative;
	top: -90px;
	margin: 0;
	width: 220px;
	background-color: rgba(255, 255, 255, 0.8);
	color: black;
	cursor: pointer;
}

/* 社員1人分の名前と所属と入社年月（p）*/
#employee_name, #employee_detail {
	width: 220px;
	background-color: rgba(255, 255, 255, 0.8);
}

/* 画像をスライダーさせるボタン（button）*/
#img_slider button {
	position: absolute;
	top: 40%;
	width: 10%;
}

/*左ボタン（button）*/
#prev {
	left: 30px;
}

/*右ボタン（button）*/
#next {
	right: -15px;
}
</style>

<body>
	<div id="wrap">
		<!-- ヘッダー部分 -->
		<%@ include file="../common/header.jsp"%>

		<!-- メイン部分 -->
		<div id="main" class="container">
			<div id="detailEmployee">
				<!-- 一覧に戻るボタン・編集ボタン・削除ボタン -->
				<div id="buttonList">
					<a href="<%=request.getContextPath()%>/employee"> <input
						id="backEmployeeList_button" type="submit" value="一覧へ"
						style="width: 80px; height: 50px; font-size: large;">
					</a>&nbsp;&nbsp;&nbsp; <a href="<%= request.getContextPath() %>/view/employeeUpdate.jsp?cmd=update"> <input
						id="update_button" type="submit" value="編集"
						style="width: 80px; height: 50px; font-size: large;">
					</a> <a> <input id="delete_button" type="submit" value="削除"
						style="width: 80px; height: 50px; font-size: large;">
					</a>
				</div>

				<!-- プロフ欄 -->
				<table id="mainEmployee">
					<tr>
						<td id="employee_imgArea">
							<!-- 社員画像 --> <img id="employee_img"
							src="<%=request.getContextPath()%>/img/<%=employee.getPhoto()%>"
							alt="社員画像">
						</td>
						<td id="employee_infoArea">
							<!-- 社員情報 -->
							<div id="employee_info">
								<p>
									社員番号
									<%=user.getEmployeeNumber()%></p>
								<p id="detailEmployee_name"><%=user.getName()%></p>
								<p id="detailEmployee_kana"><%=user.getNameKana()%></p>
								<p id="detailEmployee_belong">
									第<%=user.getDepartment()%>事業部 第<%=user.getTeam()%>グループ
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
									<%=employee.getDevloper()%>年
								</p>
								<p>
									生年月日
									<%=birthday%></p>
								<p>
									趣味
									<%=employee.getHobby()%></p>
								<p>
									特技
									<%=employee.getTalent()%></p>
								<p>
									役職
									<%=employee.getPosition()%></p>
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
						第<%=user.getDepartment()%>事業部 第<%=user.getTeam()%>グループ
					</div>
					<div id="img_slider">
						<button id="prev">◀</button>

						<%
						if (userListBySameBelong != null) {
							for (int i = 0; i < 3; i++) {
						%>
						<a id="belong_link" href="detailEmployee?userId=<%= userListBySameBelong.get(i).getUserId() %>">
							<div id="employee_card">
								<img id="belong_img"
									src="<%=request.getContextPath()%>/img/<%=sameBelong_imgList[i]%>" alt="社員画像">
								<p id="employee_name" class="sameBelong_employeeName"><%=userListBySameBelong.get(i).getName()%></p>
								<p id="employee_detail">
									第<%=userListBySameBelong.get(i).getDepartment()%>事業部 第<%=userListBySameBelong.get(i).getTeam()%>グループ
								</p>
								<p id="employee_detail" class="employee_joinTiming"><%=joiningDatesBySameBelong[i]%>入社
								</p>
							</div>
						</a>
						<%
							}
						}
						%>

						<button id="next">▶</button>
					</div>
				</div>

				<!-- 社員候補リスト（同じ入社年月） -->
				<div id="imgSlider_area">
					<div id="joinTiming_title"><%=joiningDate%>入社
					</div>
					<div id="img_slider">
						<button id="prev">◀</button>
						
						<%
						if (userListBySameJoiningDate != null) {
							for (int i = 0; i < 3; i++) {
						%>
						<a id="joinTiming_link" href="detailEmployee?userId=<%= userListBySameJoiningDate.get(i).getUserId() %>">
							<div id="employee_card">
								<img id="joinTiming_img"
									src="<%=request.getContextPath()%>/img/<%=sameJoinTiming_imgList[i]%>" alt="社員画像">
								<p id="employee_name" class="sameJoinTiming_employeeName"><%=userListBySameJoiningDate.get(i).getName()%></p>
								<p id="employee_detail" class="employee_belong">
									第<%=userListBySameJoiningDate.get(i).getDepartment()%>事業部 第<%=userListBySameJoiningDate.get(i).getTeam()%>グループ
								</p>
								<p id="employee_detail"><%=joiningDatesBySameJoin[i]%>入社
								</p>
							</div>
						</a>
						<%
							}
						}
						%>
						
						<button id="next">▶</button>
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
	int idListByBelongElement;	// リストの要素を一つ一つ代入するための変数
	int[] arrayIdListB = new int[userListBySameBelong.size()];	// リストの要素分の配列を宣言
	for (int i = 0; i < userListBySameBelong.size(); i++) {
		idListByBelongElement = userListBySameBelong.get(i).getUserId();	// 値を一つ一つ取ってきて代入していく
		arrayIdListB[i] = idListByBelongElement;		// 代入された値を配列に入れていく
	}
	String idListByBelong = Arrays.toString(arrayIdListB);	// 配列を文字列に変換して受け渡す

	// -------------ユーザーID（同じ入社年月）---------------
	int idListByJoinElement;	// リストの要素を一つ一つ代入するための変数
	int[] arrayIdListJ = new int[userListBySameJoiningDate.size()];	// リストの要素分の配列を宣言
	for (int i = 0; i < userListBySameJoiningDate.size(); i++) {
		idListByJoinElement = userListBySameJoiningDate.get(i).getUserId();	// 値を一つ一つ取ってきて代入していく
		arrayIdListJ[i] = idListByJoinElement;		// 代入された値を配列に入れていく
	}
	String idListByJoin = Arrays.toString(arrayIdListJ);	// 配列を文字列に変換して受け渡す
	
	// -------------名前（同じ所属）---------------
	String nameListByBelongElement = "";	// リストの要素を一つ一つ代入するための変数
	String[] arrayNameListB = new String[userListBySameBelong.size()];	// リストの要素分の配列を宣言
	for (int i = 0; i < userListBySameBelong.size(); i++) {
		nameListByBelongElement = userListBySameBelong.get(i).getName();	// 値を一つ一つ取ってきて代入していく
		arrayNameListB[i] = nameListByBelongElement;		// 代入された値を配列に入れていく
	}
	String nameListByBelong = Arrays.toString(arrayNameListB);	// 配列を文字列に変換して受け渡す
	
	// -------------名前（同じ入社年月）---------------
	String nameListByJoinElement = "";	// リストの要素を一つ一つ代入するための変数
	String[] arrayNameListJ = new String[userListBySameJoiningDate.size()];	// リストの要素分の配列を宣言
	for (int i = 0; i < userListBySameJoiningDate.size(); i++) {
		nameListByJoinElement = userListBySameJoiningDate.get(i).getName();	// 値を一つ一つ取ってきて代入していく
		arrayNameListJ[i] = nameListByJoinElement;		// 代入された値を配列に入れていく
	}
	String nameListByJoin = Arrays.toString(arrayNameListJ);	// 配列を文字列に変換して受け渡す
	
	// -------------社員画像（同じ所属）---------------
	String imgListByBelongElement = "";	// リストを一つ一つ代入するための変数
	String[] arrayImgListB = new String[userListBySameBelong.size()];	// リストの要素分の配列を宣言
	for (int i = 0; i < userListBySameBelong.size(); i++) {
		imgListByBelongElement = sameBelong_imgList[i];	// 値を一つ一つ取ってきて代入していく
		arrayImgListB[i] = imgListByBelongElement;		// 代入された値を配列に入れていく
	}
	String imgListByBelong = Arrays.toString(arrayImgListB);	// 配列を文字列に変換して受け渡す
	
	// -------------社員画像（同じ入社年月）---------------
	String imgListByJoinElement = "";	// リストを一つ一つ代入するための変数
	String[] arrayImgListJ = new String[userListBySameJoiningDate.size()];	// リストの要素分の配列を宣言
	for (int i = 0; i < userListBySameJoiningDate.size(); i++) {
		imgListByJoinElement = sameJoinTiming_imgList[i];	// 値を一つ一つ取ってきて代入していく
		arrayImgListJ[i] = imgListByJoinElement;		// 代入された値を配列に入れていく
	}
	String imgListByJoin = Arrays.toString(arrayImgListJ);	// 配列を文字列に変換して受け渡す
	
	// -------------入社年月---------------
	String joiningDateListElement = "";	// リストを一つ一つ代入するための変数
	String[] arrayJoiningDateList = new String[userListBySameBelong.size()];	// リストの要素分の配列を宣言
	for (int i = 0; i < userListBySameBelong.size(); i++) {
		joiningDateListElement = joiningDatesBySameBelong[i];	// 値を一つ一つ取ってきて代入していく
		arrayJoiningDateList[i] = joiningDateListElement;		// 代入された値を配列に入れていく
	}
	String joiningDateList = Arrays.toString(arrayJoiningDateList);	// 配列を文字列に変換して受け渡す

	// -------------部・グループ（部）---------------
	String departmentListElement = "";	// リストを一つ一つ代入するための変数
	String[] arrayDepartmentList = new String[userListBySameJoiningDate.size()];	// リストの要素分の配列を宣言
	for (int i = 0; i < userListBySameJoiningDate.size(); i++) {
		departmentListElement = userListBySameJoiningDate.get(i).getDepartment();	// 値を一つ一つ取ってきて代入していく
		arrayDepartmentList[i] = departmentListElement;		// 代入された値を配列に入れていく
	}
	String departmentList = Arrays.toString(arrayDepartmentList);	// 配列を文字列に変換して受け渡す

	// -------------部・グループ（グループ）---------------
	String teamListElement = "";	// リストを一つ一つ代入するための変数
	String[] arrayTeamList = new String[userListBySameJoiningDate.size()];	// リストの要素分の配列を宣言
	for (int i = 0; i < userListBySameJoiningDate.size(); i++) {
		teamListElement = userListBySameJoiningDate.get(i).getTeam();	// 値を一つ一つ取ってきて代入していく
		arrayTeamList[i] = teamListElement;		// 代入された値を配列に入れていく
	}
	String teamList = Arrays.toString(arrayTeamList);	// 配列を文字列に変換して受け渡す
	
	%>

	<script>
	// 変数受け渡し
	const userListBySameBelongSize = <%= userListBySameBelongSize %>;
	const userListBySameJoiningDateSize = <%= userListBySameJoiningDateSize %>;

	// -------------ユーザーID（同じ所属）---------------
	let stringIdListByBelong = "<%= idListByBelong %>";
	stringIdListByBelong = stringIdListByBelong.replace("[", "").replace("]", "");	// 文字列に[]が残っているので消す
	const sameBelong_idList = stringIdListByBelong.split(", ");	// 要素の間にある「, 」で分ける（配列の完成）

	// -------------ユーザーID（同じ入社年月）---------------
	let stringIdListByJoin = "<%= idListByJoin %>";
	stringIdListByJoin = stringIdListByJoin.replace("[", "").replace("]", "");	// 文字列に[]が残っているので消す
	const sameJoinTiming_idList = stringIdListByJoin.split(", ");	// 要素の間にある「, 」で分ける（配列の完成）

	// -------------名前（同じ所属）---------------
	let stringNameListByBelong = "<%= nameListByBelong %>";
	stringNameListByBelong = stringNameListByBelong.replace("[", "").replace("]", "");	// 文字列に[]が残っているので消す
	const sameBelong_nameList = stringNameListByBelong.split(", ");	// 要素の間にある「, 」で分ける（配列の完成）

	// -------------名前（同じ入社年月）---------------
	let stringNameListByJoin = "<%= nameListByJoin %>";
	stringNameListByJoin = stringNameListByJoin.replace("[", "").replace("]", "");	// 文字列に[]が残っているので消す
	const sameJoinTiming_nameList = stringNameListByJoin.split(", ");	// 要素の間にある「, 」で分ける（配列の完成）

	// -------------社員画像（同じ所属）---------------
	let stringImgListByBelong = "<%= imgListByBelong %>";
	stringImgListByBelong = stringImgListByBelong.replace("[", "").replace("]", "");	// 文字列に[]が残っているので消す
	const sameBelong_imgList = stringImgListByBelong.split(", ");	// 要素の間にある「, 」で分ける（配列の完成）

	// -------------社員画像（同じ入社年月）---------------
	let stringImgListByJoin = "<%= imgListByJoin %>";
	stringImgListByJoin = stringImgListByJoin.replace("[", "").replace("]", "");	// 文字列に[]が残っているので消す
	const sameJoinTiming_imgList = stringImgListByJoin.split(", ");	// 要素の間にある「, 」で分ける（配列の完成）

	// -------------入社年月---------------
	let stringJoiningDateList = "<%= joiningDateList %>";
	stringJoiningDateList = stringJoiningDateList.replace("[", "").replace("]", "");	// 文字列に[]が残っているので消す
	const joinTimingList = stringJoiningDateList.split(", ");	// 要素の間にある「, 」で分ける（配列の完成）
	
	// -------------部・グループ（部）---------------
	let stringDepartmentList = "<%= departmentList %>";
	stringDepartmentList = stringDepartmentList.replace("[", "").replace("]", "");	// 文字列に[]が残っているので消す
	const departmentList = stringDepartmentList.split(", ");	// 要素の間にある「, 」で分ける（配列の完成）
	
	// -------------部・グループ（グループ）---------------
	let stringTeamList = "<%= teamList %>";
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
		sameBelong_imgs[0].src = "<%= request.getContextPath() %>/img/" + sameBelong_imgList[indexLeft_0];
		sameBelong_imgs[1].src = "<%= request.getContextPath() %>/img/" + sameBelong_imgList[indexCenter_0];
		sameBelong_imgs[2].src = "<%= request.getContextPath() %>/img/" + sameBelong_imgList[indexRight_0];
		
		sameBelong_names[0].textContent = sameBelong_nameList[indexLeft_0];
		sameBelong_names[1].textContent = sameBelong_nameList[indexCenter_0];
		sameBelong_names[2].textContent = sameBelong_nameList[indexRight_0];
		
		sameBelong_joinTimings[0].textContent = joinTimingList[indexLeft_0] + "入社";
		sameBelong_joinTimings[1].textContent = joinTimingList[indexCenter_0] + "入社";
		sameBelong_joinTimings[2].textContent = joinTimingList[indexRight_0] + "入社";
		
		sameJoinTiming_imgs[0].src = "<%= request.getContextPath() %>/img/" + sameJoinTiming_imgList[indexLeft_1];
		sameJoinTiming_imgs[1].src = "<%= request.getContextPath() %>/img/" + sameJoinTiming_imgList[indexCenter_1];
		sameJoinTiming_imgs[2].src = "<%= request.getContextPath() %>/img/" + sameJoinTiming_imgList[indexRight_1];
		
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
		
		sameBelong_imgs[0].src = "<%= request.getContextPath() %>/img/" + sameBelong_imgList[indexLeft_0];
		sameBelong_imgs[1].src = "<%= request.getContextPath() %>/img/" + sameBelong_imgList[indexCenter_0];
		sameBelong_imgs[2].src = "<%= request.getContextPath() %>/img/" + sameBelong_imgList[indexRight_0];
		
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
		
		sameJoinTiming_imgs[0].src = "<%= request.getContextPath() %>/img/" + sameJoinTiming_imgList[indexLeft_1];
		sameJoinTiming_imgs[1].src = "<%= request.getContextPath() %>/img/" + sameJoinTiming_imgList[indexCenter_1];
		sameJoinTiming_imgs[2].src = "<%= request.getContextPath() %>/img/" + sameJoinTiming_imgList[indexRight_1];
		
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
		
		sameBelong_imgs[0].src = "<%= request.getContextPath() %>/img/" + sameBelong_imgList[indexLeft_0];
		sameBelong_imgs[1].src = "<%= request.getContextPath() %>/img/" + sameBelong_imgList[indexCenter_0];
		sameBelong_imgs[2].src = "<%= request.getContextPath() %>/img/" + sameBelong_imgList[indexRight_0];
		
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
		
		sameJoinTiming_imgs[0].src = "<%= request.getContextPath() %>/img/" + sameJoinTiming_imgList[indexLeft_1];
		sameJoinTiming_imgs[1].src = "<%= request.getContextPath() %>/img/" + sameJoinTiming_imgList[indexCenter_1];
		sameJoinTiming_imgs[2].src = "<%= request.getContextPath() %>/img/" + sameJoinTiming_imgList[indexRight_1];
		
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