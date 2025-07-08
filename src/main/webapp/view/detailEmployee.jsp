<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>社員詳細</title>
<link rel="stylesheet" href="../css/style.css">
</head>
<body id="detailEmployee">

	<%@include file = "../common/header.jsp" %>

	<div id="detail">

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
	
	<script src="../js/script.js"></script>

</body>
</html>