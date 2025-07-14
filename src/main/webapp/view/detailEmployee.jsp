<%@page contentType="text/html; charset=UTF-8"%>

<%@page import="util.MyFormat, bean.Employee, bean.User"%>

<%
//サーブレットから送られてきた情報を取得
Employee employee = (Employee) request.getAttribute("Employee");
User user = (User) request.getAttribute("User");
//フォーマットを使用するためのオブジェクト生成
MyFormat myFormat = new MyFormat();
//タイムスタンプ型、Date型のデータを全てフォーマット化
String joiningDate = myFormat.YearMonthFormat(user.getJoiningDate());
String birthday = myFormat.birthDateFormat(user.getBirthday());
%>

<html>
<head>
<!-- タイトル -->
<title>社員詳細</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<script src="<%=request.getContextPath()%>/js/script.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<style>
/* ページ全体（div）*/
#detailEmployee {
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
	object-fit: none;
}

/* 社員情報をまとめた領域（div）*/
#employee_info {
	margin-left: 10px; width : 450px;
	text-align: left;
	width: 450px;
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
	height: 80%;
}

a {
	text-decoration: none;
}

/* 画像スライダーの中の社員1人分の画像&情報（div）*/
#employee_card {
	display: inline-block;
	margin-right: 15px;
	margin-left: 15px;
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
	right: 15px;
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
					</a>&nbsp;&nbsp;&nbsp;
					<a href="updateEmployee.jsp"> <input id="update_button"
						type="submit" value="編集"
						style="width: 80px; height: 50px; font-size: large;">
					</a> <a> <input id="delete_button" type="submit" value="削除"
						style="width: 80px; height: 50px; font-size: large;">
					</a>
				</div>

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
								<p>社員番号 <%= user.getEmployeeNumber() %></p>
								<p id="detailEmployee_name"><%= user.getName() %></p>
								<p id="detailEmployee_kana"><%= user.getNameKana() %></p>
								<p id="detailEmployee_belong">第<%= user.getDepartment() %>事業部 第<%= user.getTeam() %>グループ</p>
								<p id="detailEmployee_joinTiming"><%= joiningDate %>入社</p>
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
								<p>生年月日 <%= birthday %></p>
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
					<p><%= employee.getIntro() %></p>
				</div>

				<!-- 社員候補リスト（同じ所属） -->
				<div id="imgSlider_area">
					<div id="belong_title">第<%= user.getDepartment() %>事業部 第<%= user.getTeam() %>グループ</div>
					<div id="img_slider">
						<button id="prev">◀</button>

						<a href="detailEmployee.jsp">
							<div id="employee_card">
								<img id="belong_img"
									src="<%=request.getContextPath()%>/img/photo2.png" alt="社員画像">
								<p id="employee_name" class="sameBelong_employeeName">山田 太郎</p>
								<p id="employee_detail">第1事業部 第1グループ</p>
								<p id="employee_detail" class="employee_joinTiming">2025年4月入社</p>
							</div>
						</a> <a href="detailEmployee.jsp">
							<div id="employee_card">
								<img id="belong_img"
									src="<%=request.getContextPath()%>/img/photo3.png" alt="社員画像">
								<p id="employee_name" class="sameBelong_employeeName">鈴木 花子</p>
								<p id="employee_detail">第1事業部 第1グループ</p>
								<p id="employee_detail" class="employee_joinTiming">2025年4月入社</p>
							</div>
						</a> <a href="detailEmployee.jsp">
							<div id="employee_card">
								<img id="belong_img"
									src="<%=request.getContextPath()%>/img/photo4.png" alt="社員画像">
								<p id="employee_name" class="sameBelong_employeeName">姓 名</p>
								<p id="employee_detail">第1事業部 第1グループ</p>
								<p id="employee_detail" class="employee_joinTiming">2025年4月入社</p>
							</div>
						</a>

						<button id="next">▶</button>
					</div>
				</div>

				<!-- 社員候補リスト（同じ入社年月） -->
				<div id="imgSlider_area">
					<div id="joinTiming_title"><%= joiningDate %>入社</div>
					<div id="img_slider">
						<button id="prev">◀</button>

						<a href="detailEmployee.jsp">
							<div id="employee_card">
								<img id="joinTiming_img"
									src="<%=request.getContextPath()%>/img/photo2.png" alt="社員画像">
								<p id="employee_name" class="sameJoinTiming_employeeName">山田
									太郎</p>
								<p id="employee_detail" class="employee_belong">第1事業部 第2グループ</p>
								<p id="employee_detail">2025年4月入社</p>
							</div>
						</a> <a href="detailEmployee.jsp">
							<div id="employee_card">
								<img id="joinTiming_img"
									src="<%=request.getContextPath()%>/img/photo3.png" alt="社員画像">
								<p id="employee_name" class="sameJoinTiming_employeeName">鈴木
									花子</p>
								<p id="employee_detail" class="employee_belong">第1事業部 第3グループ</p>
								<p id="employee_detail">2025年4月入社</p>
							</div>
						</a> <a href="detailEmployee.jsp">
							<div id="employee_card">
								<img id="joinTiming_img"
									src="<%=request.getContextPath()%>/img/photo4.png" alt="社員画像">
								<p id="employee_name" class="sameJoinTiming_employeeName">姓
									名</p>
								<p id="employee_detail" class="employee_belong">第2事業部 第1グループ</p>
								<p id="employee_detail">2025年4月入社</p>
							</div>
						</a>

						<button id="next">▶</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
	//↓ボタンを押して画像をスライダーさせ複数閲覧できるようにする

	//画像リスト（同じ所属）
	const sameBelong_imgList = [
		"<%=request.getContextPath()%>/img/photo2.png",
		"<%=request.getContextPath()%>/img/photo3.png",
		"<%=request.getContextPath()%>/img/photo4.png",
		"<%=request.getContextPath()%>/img/photo5.png",
		"<%=request.getContextPath()%>/img/photo6.png",
		"<%=request.getContextPath()%>/img/photo7.png"
	]

	//画像リスト（同じ入社年月）
	const sameJoinTiming_imgList = [
		"<%=request.getContextPath()%>/img/photo2.png",
		"<%=request.getContextPath()%>/img/photo3.png",
		"<%=request.getContextPath()%>/img/photo4.png",
		"<%=request.getContextPath()%>/img/photo5.png",
		"<%=request.getContextPath()%>/img/photo6.png",
		"<%=request.getContextPath()%>/img/photo7.png"
	]

	//名前リスト（同じ所属）
	const sameBelong_nameList = [
		"山田 太郎",
		"鈴木 花子",
		"姓 名",
		"姓 名",
		"姓 名",
		"姓 名"
	]

	//名前リスト（同じ入社年月）
	const sameJoinTiming_nameList = [
		"山田 太郎",
		"鈴木 花子",
		"姓 名",
		"姓 名",
		"姓 名",
		"姓 名"
	]

	// 所属リスト
	const belongList = [
		"第1事業部 第2グループ",
		"第1事業部 第3グループ",
		"第1事業部 第4グループ",
		"第2事業部 第1グループ",
		"第2事業部 第2グループ",
		"第2事業部 第3グループ"
	]

	//入社年月リスト
	const joinTimingList = [
		"2015年4月入社",
		"2016年4月入社",
		"2017年4月入社",
		"2018年4月入社",
		"2019年4月入社",
		"2020年4月入社"
	]

	//必要な要素を取得
	const prevButtons = document.querySelectorAll("#prev");
	const nextButtons = document.querySelectorAll("#next");
	const sameBelong_imgs = document.querySelectorAll("#belong_img");
	const sameBelong_names = document.getElementsByClassName("sameBelong_employeeName");
	const sameBelong_joinTimings = document.getElementsByClassName("employee_joinTiming");
	const sameJoinTiming_imgs = document.querySelectorAll("#joinTiming_img");
	const sameJoinTiming_names = document.getElementsByClassName("sameJoinTiming_employeeName");
	const sameJoinTiming_belongs = document.getElementsByClassName("employee_belong");

	//現在のインデックスを保持するための変数
	let indexLeft = 0;
	let indexCenter = 1;
	let indexRight = 2;

	// ページが読み込まれたときに最初の情報を表示
	document.addEventListener('DOMContentLoaded', () => {
		sameBelong_imgs[0].src = sameBelong_imgList[indexLeft];
		sameBelong_imgs[1].src = sameBelong_imgList[indexCenter];
		sameBelong_imgs[2].src = sameBelong_imgList[indexRight];
		
		sameBelong_names[0].textContent = sameBelong_nameList[indexLeft];
		sameBelong_names[1].textContent = sameBelong_nameList[indexCenter];
		sameBelong_names[2].textContent = sameBelong_nameList[indexRight];
		
		sameBelong_joinTimings[0].textContent = joinTimingList[indexLeft];
		sameBelong_joinTimings[1].textContent = joinTimingList[indexCenter];
		sameBelong_joinTimings[2].textContent = joinTimingList[indexRight];
		
		sameJoinTiming_imgs[0].src = sameJoinTiming_imgList[indexLeft];
		sameJoinTiming_imgs[1].src = sameJoinTiming_imgList[indexCenter];
		sameJoinTiming_imgs[2].src = sameJoinTiming_imgList[indexRight];
		
		sameJoinTiming_names[0].textContent = sameJoinTiming_nameList[indexLeft];
		sameJoinTiming_names[1].textContent = sameJoinTiming_nameList[indexCenter];
		sameJoinTiming_names[2].textContent = sameJoinTiming_nameList[indexRight];
		
		sameJoinTiming_belongs[0].textContent = belongList[indexLeft];
		sameJoinTiming_belongs[1].textContent = belongList[indexCenter];
		sameJoinTiming_belongs[2].textContent = belongList[indexRight];
	});

	// ▶ボタン（同じ所属）が押されたら画像を1つ進める
	nextButtons[0].addEventListener('click', () => {
		//	インデックスを1つ進める
		indexLeft += 1;
		indexCenter += 1;
		indexRight += 1;
		
		//	インデックスがリストの範囲を超えた場合の処理
		if (indexRight >= sameBelong_imgList.length) {
			indexLeft = sameBelong_imgList.length - 3;
			indexCenter = sameBelong_imgList.length - 2;
			indexRight = sameBelong_imgList.length - 1;
		}
		
		//	現在のインデックスを指定でリストから取ってくる
		sameBelong_imgs[0].src = sameBelong_imgList[indexLeft];
		sameBelong_imgs[1].src = sameBelong_imgList[indexCenter];
		sameBelong_imgs[2].src = sameBelong_imgList[indexRight];
		
		sameBelong_names[0].textContent = sameBelong_nameList[indexLeft];
		sameBelong_names[1].textContent = sameBelong_nameList[indexCenter];
		sameBelong_names[2].textContent = sameBelong_nameList[indexRight];
		
		sameBelong_joinTimings[0].textContent = joinTimingList[indexLeft];
		sameBelong_joinTimings[1].textContent = joinTimingList[indexCenter];
		sameBelong_joinTimings[2].textContent = joinTimingList[indexRight];
	})

	// ▶ボタン（同じ入社年月）が押されたら画像を1つ進める
	nextButtons[1].addEventListener('click', () => {
		//	インデックスを1つ進める
		indexLeft += 1;
		indexCenter += 1;
		indexRight += 1;
		
		//	インデックスがリストの範囲を超えた場合の処理
		if (indexRight >= sameJoinTiming_imgList.length) {
			indexLeft = sameJoinTiming_imgList.length - 3;
			indexCenter = sameJoinTiming_imgList.length - 2;
			indexRight = sameJoinTiming_imgList.length - 1;
		}
		
		//	現在のインデックスを指定でリストから取ってくる
		sameJoinTiming_imgs[0].src = sameJoinTiming_imgList[indexLeft];
		sameJoinTiming_imgs[1].src = sameJoinTiming_imgList[indexCenter];
		sameJoinTiming_imgs[2].src = sameJoinTiming_imgList[indexRight];
		
		sameJoinTiming_names[0].textContent = sameJoinTiming_nameList[indexLeft];
		sameJoinTiming_names[1].textContent = sameJoinTiming_nameList[indexCenter];
		sameJoinTiming_names[2].textContent = sameJoinTiming_nameList[indexRight];
		
		sameJoinTiming_belongs[0].textContent = belongList[indexLeft];
		sameJoinTiming_belongs[1].textContent = belongList[indexCenter];
		sameJoinTiming_belongs[2].textContent = belongList[indexRight];
	})

	// ◀ボタン（同じ所属）が押されたら画像を1つ戻す
	prevButtons[0].addEventListener('click', () => {
		//	インデックスを1つ戻す
		indexLeft -= 1;
		indexCenter -= 1;
		indexRight -= 1;
		
		//	インデックスがリストの範囲を超えた場合の処理
		if (indexLeft < 0) {
			indexLeft = 0;
			indexCenter = 1;
			indexRight = 2;
		}
		
		//	現在のインデックスを指定でリストから取ってくる
		sameBelong_imgs[0].src = sameBelong_imgList[indexLeft];
		sameBelong_imgs[1].src = sameBelong_imgList[indexCenter];
		sameBelong_imgs[2].src = sameBelong_imgList[indexRight];
		
		sameBelong_names[0].textContent = sameBelong_nameList[indexLeft];
		sameBelong_names[1].textContent = sameBelong_nameList[indexCenter];
		sameBelong_names[2].textContent = sameBelong_nameList[indexRight];
		
		sameBelong_joinTimings[0].textContent = joinTimingList[indexLeft];
		sameBelong_joinTimings[1].textContent = joinTimingList[indexCenter];
		sameBelong_joinTimings[2].textContent = joinTimingList[indexRight];
	})

	// ◀ボタン（同じ入社年月）が押されたら画像を1つ戻す
	prevButtons[1].addEventListener('click', () => {
		//	インデックスを1つ戻す
		indexLeft -= 1;
		indexCenter -= 1;
		indexRight -= 1;
		
		//	インデックスがリストの範囲を超えた場合の処理
		if (indexLeft < 0) {
			indexLeft = 0;
			indexCenter = 1;
			indexRight = 2;
		}
		
		//	現在のインデックスを指定でリストから取ってくる
		sameJoinTiming_imgs[0].src = sameJoinTiming_imgList[indexLeft];
		sameJoinTiming_imgs[1].src = sameJoinTiming_imgList[indexCenter];
		sameJoinTiming_imgs[2].src = sameJoinTiming_imgList[indexRight];
		
		sameJoinTiming_names[0].textContent = sameJoinTiming_nameList[indexLeft];
		sameJoinTiming_names[1].textContent = sameJoinTiming_nameList[indexCenter];
		sameJoinTiming_names[2].textContent = sameJoinTiming_nameList[indexRight];
		
		sameJoinTiming_belongs[0].textContent = belongList[indexLeft];
		sameJoinTiming_belongs[1].textContent = belongList[indexCenter];
		sameJoinTiming_belongs[2].textContent = belongList[indexRight];

	})
	</script>

</body>
</html>