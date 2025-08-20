<!-- 
 個人目標確認画面

 作成者：月向亮太
 更新者：占部虎司郎

 作成日：7月8日
 最終更新日：8月19日
 -->

<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="bean.Goal, bean.GoalQuarter, bean.GoalDepartment, java.util.ArrayList"%>

<%
//オブジェクト宣言
Goal goal = new Goal();
GoalDepartment goalDepartment = new GoalDepartment();

//リクエストスコープから要素を取得する
goal = (Goal) request.getAttribute("goal");
goalDepartment = (GoalDepartment) request.getAttribute("goalDepartment");
ArrayList<GoalQuarter> goalQuarterList = (ArrayList<GoalQuarter>) request.getAttribute("goalQuarterList");

//変数宣言
String managementTheme = "";
String groupCode = "";
String departmentGoal = "";
String groupGoal = "";
String annualGoal = "";
String situationChallenge = "";
int result = 0;
String resultComment = "";
int resultReviewer = 0;
String resultCommentReviewer = "";

//goalの値がnullでなければ
if (goal != null) {

	//ゲッターメソッドを使って値を取得する
	groupCode = goal.getGroupCode();
	annualGoal = goal.getAnnualGoal();
	situationChallenge = goal.getSituationChallenge();
	result = goal.getResult();
	resultComment = goal.getResultComment();
	resultReviewer = goal.getResultReviewer();
	resultCommentReviewer = goal.getResultCommentReviewer();
}

//goalDepartmentの値がnullでなければ
if (goalDepartment != null) {
	//ゲッターメソッドを使って値を取得する
	managementTheme = goalDepartment.getManagementTheme();
	departmentGoal = goalDepartment.getDepartmentGoal();
	groupGoal = goalDepartment.getGroupGoal();
}
%>

<html>
<head>
<!-- タイトル -->
<title>個人目標詳細 | Home-Jack</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
<script src="<%=request.getContextPath()%>/js/script.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<style>
@import url('https://fonts.googleapis.com/css2?family=M+PLUS+1p&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Yusei+Magic&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Kosugi+Maru&display=swap');

/*ページタイトル*/
#contents {
width: 90%;
margin-right: auto;
margin-left: auto;
}

#link-line {
padding: 1rem 0;
margin-bottom: 0.2rem;
background-image: linear-gradient(90deg, #b2d5de 0 25%, #ddcfb3 25% 50%,
					#b3ddb4 50% 75%, #ddbab3 75%);
background-repeat: no-repeat;
background-size: 100% 0.3rem;
background-position: bottom;
color: #353535;
font-weight: bold;
font-size: 26px;
text-align: center;
}

#link-title {
text-align: center;
}

/* 本文の大きな枠 */
.seal{
/*width:860px;*/
width:90%;
margin: 10px auto 40px;
padding:10px 0 50px;
background-color: #fff;
border-radius: 40px; 
}

/* アンダーライン付き小見出し */
.yorushikaLine{
border-bottom: 4px solid #ff8b4d;
width: 80%;
font-size: 35px;
font-family: "M PLUS 1p", sans-serif;
font-weight: bold;
text-align: center;
color: #ff8b4d;
margin: 40px auto;
padding-bottom: 5px;
}

/* 経営テーマ用の小見出し */
.adminTitle{
width: 80%;
font-size: 35px;
font-family: "M PLUS 1p", sans-serif;
font-weight: bold;
text-align: center;
color: #ff8b4d;
margin: 40px auto 0;
}

/* 経営テーマ本文 */
.adminLine{
width: 80%;
font-size: 25px;
font-family: "M PLUS 1p", sans-serif;
font-weight: bold;
text-align: center;
color: #ff8b4d;
border-bottom: 4px solid #ff8b4d;
margin: 0 auto 40px;
padding-bottom: 5px;
}

/* ただの色付き小見出し */
.yorushika{
font-size: 22px;
color: #e89b17;
margin-left: 10px;
margin-right: auto;
}

/* ボックス型小見出し */
.yorushikaBox{
display: flex;				/* 子要素を横並びに配置 */
align-items: center; 		/* 垂直方向の中央揃え */
justify-content: center; 	/* 水平方向の中央揃え */
position: relative; 		/* 疑似要素の位置の基準点に */
width: 75%;
margin: 10px auto 0;
}

/* ボックス型小見出しの文字の色とか */
.titleBox{
background-color: #ffc766;
padding: 10px 20px;			/* 10px 20px*/
position: relative; 		/* z-indexを有効にするため */
z-index: 1; 				/* 線の上に表示させる */
color: white;
font-weight: bold;
margin-right:auto;
}

/* ボックスの右の線 */
.yorushikaBox::after {
content: ''; 					/* 擬似要素には必須 */
position: absolute;
top: 50%; 						/* 親要素の高さの中央 */
right: 0; 						/* 親要素の右側から線の長さ分伸ばす */
width: 100%;
height: 2px;					/* 線の太さ */
background-color: #ffc766;
transform: translateY(-50%); 	/* 垂直方向の中心に調整 */
z-index: 0; 					/* 四角い箱の下に配置 */
}

/* 大きめの本文 */
.subhead{
font-size: 20px;
margin: 20px auto;
padding-left: 20px;
width: 75%;
white-space: pre-wrap; 		/* 必要に応じて自動改行かつ要素がはみ出さない */
overflow-wrap: break-word;	/* 要素からはみ出さないように強制的に改行する */
word-break: break-all;		/* 単語の途中でも強制的に改行する。 */
}

/* 小さめの本文 */
.mainText{
font-size: 15px;
margin: 20px auto;
width: 75%;
padding-left: 20px;

}

/* 小見出し用の縦線 */
.yorushikaStripe{
border-left: 5px solid #ff8b4d;
margin: 10px auto 20px;
width: 74.6%;					/* 数値を合わせるとなぜかずれるので微妙に値を変えてます */
}

/* フレックス */
.mainFlex{
display: flex;
}

.mainText > div{
margin: auto 20px;
}

/* 割合表示 */
.ratio{
font-size: 25px;
font-family: "Yusei Magic", sans-serif;
color: #545454;
}

/* 左線ありの本文 */
.leftLine{
padding-left: 40px;
position: relative;
}

/* 疑似要素で左線をつけている */
.leftLine::before{
content: '';
position: absolute;
height: 65%;
min-height: 20px;
width: 3px;
top: 50%;
left: 0;
background-color: #e3e3e3;
transform: translateY(-50%);
}

/* タブ設定 */
.tab-4 {
display: flex;
margin: 0 auto;
flex-direction: row;
flex-wrap: wrap;

}

/* ラジオボタンのボタンを非表示 (タブ) */
input[type="radio"]{
-webkit-appearance: none; /* WebKit系のブラウザ（Chrome, Safariなど）に対応 */
-moz-appearance: none;    /* Firefoxに対応 */
appearance: none;         /* 標準的なCSSプロパティ */
display: none;
}

/* なくても動作はするががあった方が良い */
.tab-4 > input,
.tab-4 > label,
.tab-4 > .tab-content {
order: 2; /* すべての子要素はデフォルトで2に設定 */
}

/* タブ選択のデザイン */
.tab-4>label {
flex-grow: 1;
flex-shrink: 1;
padding: .7em 1em .5em;
min-width: 70px;
background-color: #fff;
color: #999;
font-weight: 600;
font-size: 20px;
text-align: center;
cursor: pointer;
order: 1;
margin-bottom: 20px;
}

.tab-4>label:hover {
	opacity: .8;
}

/* タブの中身 */
.tab-4 .tab-content {
display: none;
animation: fadeIn .7s ease;
width: 100%;
background-color: #fff;

}

.tab-4 input[type="radio"]:checked + label {
    border-bottom: 4px solid #ffdd00;
    color: #ffdd00;
}

/* タブを選んだ時にtab-contentを表示するようにする */
.tab-4 input[type="radio"]:checked + label + .tab-content {
    display: block;
}

/* なくてもいいアニメーション */
@keyframes fadeIn { 0% {
opacity: 0;
transform: translateY(-10px);
}
}

/* 編集ボタンだよ */
/* 編集ボタンの大枠 */
.editBox{
width:85%;
margin: 10px auto 0;
display: flex;
justify-content: flex-end;
}

/* 編集ボタンデザイン */
.editButton{
display: inline-block;			 /* パディングや幅を設定できるようにする */
padding: 8px 16px;
background-color: #6eddb3;
border: 3px solid #6eddb3;
/* 丸形の場合 */
/*
border-radius: 30px;
padding: 9px 25px;
*/
/* 四角型の場合 */
border-radius: 5px;
text-decoration: none;			/* 下線を消す */
text-align: center; 			/* テキストを中央揃えにする */
cursor: pointer; 				/* マウスカーソルをポインターにする */
align-items: center;
}

/* アイコン */
.memo{
display: inline-block;
vertical-align: middle;
stroke: #fff;
fill: #fff;
}

/* ボタンの文字 */
.editText{
vertical-align: middle;
font-family: "Kosugi Maru", sans-serif;
font-size: 21px;
font-weight: 300;
color: #fff;
}

.editButton:hover{
background-color: #fff;
border: 3px solid #6eddb3;
}

.editButton:hover .memo{
stroke: #6eddb3;
fill: #6eddb3;
}

.editButton:hover .editText{
color: #6eddb3;
}


</style>

<body>
	<div id="wrap">
		<!-- ヘッダー部分 -->
		<%@ include file="../common/header.jsp"%>

		<!-- メイン部分 -->
		<div id="main" class="container">
		<div id = "contents">
			<div id="link-title">
			<h1 id="link-line">個人目標詳細</h1>
			
			
			
<%-- 			<button type="button" onclick="location.href='<%=request.getContextPath()%>/goalConfirm?cmd=update'"> --%>
<!-- 				編集 -->
<!-- 			</button> -->
			
			</div>
			
			<div class="editBox">
			<a class="editButton" onclick="location.href='<%=request.getContextPath()%>/goalConfirm?cmd=update'">
			<svg class="memo" version="1.1" id="_x31_0" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 512 512" style="width: 25px; height: 25px; opacity: 1;" xml:space="preserve">
				<g>
				<path d="M453.394,226.605v-0.226l-61.477,61.477v160.535c0,0.766-0.847,1.614-1.613,1.614H222.746L62.75,449.852
					l-0.352-0.156c-0.305-0.078-0.614-0.387-0.922-1.305V121.176c0-0.847,0.77-1.613,1.613-1.613h162.684l35.969-35.969l25.508-25.348
					h-0.161l0.161-0.16H63.09C28.282,58.086,0,86.364,0,121.176v327.215c0,15.211,5.535,29.969,15.371,41.11
					c0.77,0.926,1.703,1.691,2.527,2.562c0.461,0.484,0.93,0.957,1.394,1.41c0.809,0.786,1.508,1.68,2.375,2.406
					c11.453,10.066,26.133,15.602,41.422,15.602h327.215c34.809,0,63.09-28.281,63.09-63.09V318.422l0.114-91.93L453.394,226.605z" >
				</path>
				<path d="M505.711,84.672L427.855,6.812c-4.062-4.058-9.402-6.297-15.027-6.293c-5.332-0.004-10.309,2.039-14.011,5.742
					L153.25,251.828l-41.231,132.054c-1.453,4.645-0.152,9.715,3.375,13.246c2.523,2.527,5.942,3.973,9.39,3.973
					c1.305,0,2.602-0.199,3.864-0.59l132.054-41.234L506.27,113.715C514.125,105.86,513.871,92.832,505.711,84.672z M269.23,310.567
					c-1.469-4.18-3.73-8.055-6.66-11.348l168.629-168.625l9.051,9.05L320.871,259.024L269.23,310.567z M246.539,333.356l-0.946,0.946
					l-79.058,24.683l-12.988-12.992l24.683-79.058l0.946-0.942l10.878-0.57c2.883-0.152,5.602,0.886,7.645,2.93
					c2.039,2.039,3.078,4.754,2.926,7.641c-0.5,9.656,3.126,19.11,9.965,25.942c6.836,6.839,16.294,10.469,25.946,9.969
					c2.882-0.157,5.598,0.894,7.649,2.945c2.034,2.031,3.074,4.742,2.926,7.625L246.539,333.356z M201.938,243.227l170.946-170.95
					l9.054,9.055L213.313,249.953c-2.852-2.527-6.176-4.442-9.703-5.898C203.039,243.793,202.523,243.469,201.938,243.227z
					 M235.278,287.828c-2.887,0.148-5.602-0.891-7.645-2.938c-2.039-2.039-3.078-4.754-2.93-7.641
					c0.207-3.977-0.293-7.953-1.457-11.758l171.43-171.426l23.781,23.785l-171.43,171.426
					C243.23,288.113,239.25,287.613,235.278,287.828z M385.625,59.543l27.438-27.441l67.363,67.367l-27.438,27.437L385.625,59.543z" >
					</path>
				</g>
			</svg>
			<span class="editText">編集</span>
			</a>
			</div>
			
			<div class="seal">
				<!-- 経営テーマのボックス -->
				<div class="adminTitle">
				経営テーマ
				</div>
				<div class="adminLine"><%=managementTheme%></div>
				
				<!-- 部目標ボックス -->
				<div class="yorushikaBox">
				<span class="titleBox">部目標</span>
				</div>
				<div class="subhead"><%=departmentGoal%></div>
				
				<!-- チーム目標ボックス -->
				<div class="yorushikaBox">
				<span class="titleBox">チーム目標</span>
				</div>
				<div class="subhead"><%=groupGoal%></div>
				
				<!-- 年間目標ボックス -->
				<div class="yorushikaBox">
				<span class="titleBox">年間目標</span>
				</div>
				<div class="subhead"><%=groupGoal%></div>
				
				<!-- 現状と課題のボックス -->
				<div class="yorushikaBox">
				<span class="titleBox">現状と課題</span>
				</div>
				<div class="subhead"><%=situationChallenge%></div>
				</div>
				
				<div class="seal">
				<!-- 4半期目標のボックス -->
				<div class="yorushikaLine">
				目標を達成するためのステップ
				</div>
				<div class="tab-4" style="min-height: 30px;" >
				<%
				if (goalQuarterList != null) {
					for (int i = 0; i < goalQuarterList.size(); i++) {
				%>
						<!-- 四半期目標のタブ -->
						<input type="radio" id="tab-<%=i%>" name="tab-group" <% if(i == 0){ %>checked<%} %>>
						<label for="tab-<%=i%>" class="tab-label">第<%=i + 1%>四半期</label>
				
						<!-- 四半期目標の本文 -->
						<div id="tab-<%=i%>-content" class="tab-content">
							<div class="yorushikaBox">
								<span class="titleBox">小目標</span>
							</div>
							<div class="mainText"><%=goalQuarterList.get(i).getSmallGoal()%></div>
						
							<!-- 四半期目標本人記入欄 -->
							<div class="yorushikaBox">
								<span class="titleBox">評価基準・材料</span>
							</div>
							<div class="mainText"><%=goalQuarterList.get(i).getJudgeMaterial()%></div>
							
							<div class="yorushikaBox">
									<span class="titleBox">報告内容</span>
								</div>
								<div class="mainText mainFlex">
									<div class="ratio"><%=goalQuarterList.get(i).getAchieveRate()%>%</div>
									<div class="leftLine"><%=goalQuarterList.get(i).getReport()%></div>
								</div>
							
							<!-- 四半期目標評価者記入欄 -->
							<div class="yorushikaStripe">
							<div class="yorushika">評価者</div>
							</div>
							
								<div class="yorushikaBox">
									<span class="titleBox">報告内容</span>
								</div>
								<div class="mainText mainFlex">
									<div class="ratio"><%=goalQuarterList.get(i).getAchieveRateReviewer()%>%</div>
									<div class="leftLine"><%=goalQuarterList.get(i).getEvaluation()%></div>
								</div>
								
						</div>

				<%
					}
				}
				%>
				</div>
				</div>

				<!-- 年間結果のボックス -->
				<div class="seal">
				<div class="yorushikaLine">年間結果</div>
				<div class="yorushikaBox">
					<span class="titleBox">報告内容</span>
				</div>
				
				<!-- 本人記入欄 -->
				<div class="mainText mainFlex">
				<div class="ratio"><%=result%>%</div>
				<div class="leftLine"><%=resultComment%></div>
				</div>
				
				<!-- 評価者記入欄 -->
				<div class="yorushikaStripe">
				<div class="yorushika">評価者</div>
				</div>
				
				<div class="yorushikaBox">
					<span class="titleBox">報告を受けての評価</span>
				</div>
				<div class="mainText mainFlex">
				<div class="ratio"><%=resultReviewer%>%</div>
				<div class="leftLine"><%=resultCommentReviewer%></div>
				</div>

				</div>
		</div>
		</div>
	</div>
</body>
</html>