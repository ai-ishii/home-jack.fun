<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>社員詳細</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>

	<%@include file = "../common/header.jsp" %>

	<div id="detailEmployee">

		<!-- 社員画像 -->
		<img id="employee_img"
			src="<%= request.getContextPath() %>/img/photo1.png" alt="社員画像"
			style="width: 350px;">

		<!-- 社員情報 -->
		<div id="employee_info">
			<p>社員番号 00000000000</p>
			<p id="detailEmployee_name">姓 名</p>
			<p id="detailEmployee_kana">カバネ アザナ</p>
			<p id="detailEmployee_belong">第1事業部 第1グループ　</p>
			<p id="detailEmployee_joinTiming">2025年4月入社</p>
			<p>習得言語　HTML, CSS, JavaScript, Java</p>
			<p>習得技術　Apache, MySQL</p>
			<p>開発年数　40年</p>
			<p>生年月日　2002年8月11日</p>
			<p>趣味　　　ゲーム</p>
			<p>特技　　　ドラム</p>
			<p>役職　　　社長</p>
		</div>

		<!-- 戻るボタン -->
		<a href="employee.jsp">
			<input id="back_employeeList" type="submit" value="一覧へ">
		</a>

		<!-- 社員候補リスト（同じ所属） -->
		<div id="imgSlider_area">
			<div id="belong_title">第1事業部 第1グループ</div>
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
				</a>
				
				<a href="detailEmployee.jsp">
					<div id="employee_card">
						<img id="belong_img"
							src="<%=request.getContextPath()%>/img/photo3.png" alt="社員画像">
						<p id="employee_name" class="sameBelong_employeeName">鈴木 花子</p>
						<p id="employee_detail">第1事業部 第1グループ</p>
						<p id="employee_detail" class="employee_joinTiming">2025年4月入社</p>
					</div>
				</a>
			
				<a href="detailEmployee.jsp">
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
			<div id="joinTiming_title">2025年4月入社</div>
			<div id="img_slider">
				<button id="prev">◀</button>
				
				<a href="detailEmployee.jsp">
					<div id="employee_card">
						<img id="joinTiming_img"
							src="<%=request.getContextPath()%>/img/photo2.png" alt="社員画像">
						<p id="employee_name" class="sameJoinTiming_employeeName">山田 太郎</p>
						<p id="employee_detail" class="employee_belong">第1事業部 第2グループ</p>
						<p id="employee_detail">2025年4月入社</p>
					</div>
				</a>
				
				<a href="detailEmployee.jsp">
					<div id="employee_card">
						<img id="joinTiming_img"
							src="<%=request.getContextPath()%>/img/photo3.png" alt="社員画像">
						<p id="employee_name" class="sameJoinTiming_employeeName">鈴木 花子</p>
						<p id="employee_detail" class="employee_belong">第1事業部 第3グループ</p>
						<p id="employee_detail">2025年4月入社</p>
					</div>
				</a>
			
				<a href="detailEmployee.jsp">
					<div id="employee_card">
						<img id="joinTiming_img"
							src="<%=request.getContextPath()%>/img/photo4.png" alt="社員画像">
						<p id="employee_name" class="sameJoinTiming_employeeName">姓 名</p>
						<p id="employee_detail" class="employee_belong">第2事業部 第1グループ</p>
						<p id="employee_detail">2025年4月入社</p>
					</div>
				</a>
				
				<button id="next">▶</button>
			</div>
		</div>

	</div>
	
	<script>
	//↓ボタンを押して画像をスライダーさせ複数閲覧できるようにする

	//画像リスト（同じ所属）
	const sameBelong_imgList = [
		"../img/photo2.png",
		"../img/photo3.png",
		"../img/photo4.png",
		"../img/photo5.png",
		"../img/photo6.png",
		"../img/photo7.png"
	]

	//画像リスト（同じ入社年月）
	const sameJoinTiming_imgList = [
		"../img/photo2.png",
		"../img/photo3.png",
		"../img/photo4.png",
		"../img/photo5.png",
		"../img/photo6.png",
		"../img/photo7.png"
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