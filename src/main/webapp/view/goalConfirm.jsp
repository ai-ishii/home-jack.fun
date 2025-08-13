<!-- 
 個人目標確認機能

 作成者：月向亮太
 更新者：占部虎司郎

 作成日：7月8日

 最終更新日：8月12日
 -->
 
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="bean.Goal, bean.GoalQuarter, bean.GoalDepartment, java.util.ArrayList"%>

<%
//オブジェクト宣言
Goal goal = new Goal();
GoalDepartment goalDepartment = new GoalDepartment();

//リクエストスコープから要素を取得する
goal = (Goal) request.getAttribute("goal");
goalDepartment = (GoalDepartment) request.getAttribute("goal_department");
ArrayList<GoalQuarter> goalQuarterList = (ArrayList<GoalQuarter>) request.getAttribute("goal_quarter_list");

//変数宣言
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

/*この中にCSSを書く*/
/*
お世話になっております。
いつも教えてくれてありがとうね。
これからも助けてくださいね。
一緒に頑張ろうね！！
*/

/*ページタイトル*/
#contents {
width: 90%;
margin-right: auto;
margin-left: auto;
}

#link-line {
padding: 1rem 0;
margin-bottom: 0.2rem;
background-image: linear-gradient(90deg, #b2d5de 0 25%, #ddcfb3 25% 50%, #b3ddb4 50% 75%,
	#ddbab3 75%);
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

#seal{
/*width:860px;*/
width:75%;
margin: auto;
padding-top:10px;
background-color: #fff;
}

.yorushikaLine{
border-bottom: 2px solid #ffc766;
width: 80%;
font-size: 25px;
text-align: center;
color: #e89b17;
margin: auto;
}

/*タイトル見出し*/
.yorushikaBox{
display: flex;				/* 子要素を横並びに配置 */
align-items: center; 		/* 垂直方向の中央揃え */
justify-content: center; 	/* 水平方向の中央揃え */
position: relative; 		/* 疑似要素の位置の基準点に */
width: 75%;
margin: 20px auto 0;
/*
margin-left: 50px;
margin-top:20px;
*/
}

.titleBox{
background-color: #ffc766;
padding: 10px 20px;
position: relative; 		/* z-indexを有効にするため */
z-index: 1; 				/* 線の上に表示させる */
color: white;
font-weight: bold;
margin-right:auto;
}

/* 右側に線を引く用のCSS*/
.yorushikaBox::after {
content: ''; 					/* 擬似要素には必須 */
position: absolute;
top: 50%; 					/* 親要素の高さの中央 */
right: 0; 				/* 親要素の右側から線の長さ分伸ばす */
width: 100%;
height: 2px;					/* 線の太さ */
background-color: #ffc766;
transform: translateY(-50%); 	/* 垂直方向の中心に調整 */
z-index: 0; 					/* 四角い箱の下に配置 */
}

.subhead{
font-size: 20px;
margin: 20px auto 0;

/*
margin-left: 50px;
margin-top: 20px;
*/
width: 75%;
white-space: pre-wrap;  /* 必要に応じて自動改行かつ要素がはみ出さない */
overflow-wrap: break-word; /* 要素からはみ出さないように強制的に改行する */
word-break: break-all; /* 単語の途中でも強制的に改行する。 */
}

.mainText{
font-size: 15px;
margin: 20px auto 0;
}

.tab-4 {
	display: flex;
	margin: 0 auto;
	max-width: 900px;
	flex-direction: row;
	flex-wrap: wrap;
}

.tab-4>label {
	flex-grow: 1;
	flex-shrink: 1;
	padding: .7em 1em .5em;
	order: -2;
	min-width: 70px;
	background-color: #f2f2f2;
	color: #999;
	font-weight: 600;
	font-size: .9em;
	text-align: center;
	cursor: pointer;
	padding: .7em 1em .5em;
}

.tab-4>label:hover {
	opacity: .8;
}

.tab-4 input {
	display: none;
}

.tab-4>div {
	display: none;
	padding: 1.5em 1em;
	width: 100%;
	background-color: #fff;
}

.tab-4 label:has(:checked) {
	border-bottom: 4px solid #ffdd00;
	color: #ffdd00;
}

.tab-4 label:has(:checked)+div {
	display: block;
}

.details-content {
	padding: 20px;
	height: 70px;
	overflow: hidden;
	overflow-y: auto;
	background-color: #fff;
}

.details[open] .details-content {
	animation: fadeIn .3s ease;
}

@keyframes fadeIn { 0% {
	opacity: 0;
	transform: translateY(-10px);
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
			</div>
			
			<div id="seal">
				<!-- 経営テーマのボックス -->
				<div class="yorushikaLine">
				経営テーマ
				<!-- 以下のdivタグにはリクエストスコープから取得した経営テーマが入る -->
				<br>PLAYFULL LEARNING</div>
				
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
				
				<!-- 経営テーマのボックス -->
				<div class="yorushikaLine">
				目標を達成するためのステップ
				</div>
				<div class="tab-4" >
				<%
				if (goalQuarterList != null) {
					for (int i = 0; i < goalQuarterList.size(); i++) {
				%>
						<label>
						<input type="radio" name="tab-4"  <% if(i == 0){ %>checked<%} %>> 第<%=i + 1%>四半期
						</label>
						
						<div class="yorushikaBox">
							<span class="titleBox">小目標</span>
						</div>
						<div class="mainText  details-content"><%=goalQuarterList.get(i).getSmallGoal()%></div>
						
						
						
				<%
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