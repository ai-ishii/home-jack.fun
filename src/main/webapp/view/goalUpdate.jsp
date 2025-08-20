<!-- 
 個人目標確認画面

 作成者：月向亮太
 更新者：占部虎司郎

 作成日：7月8日
 最終更新日：8月20日
 -->

<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="bean.Goal, bean.GoalQuarter, bean.GoalDepartment, java.util.ArrayList"%>

<%
//オブジェクト宣言
Goal goal = new Goal();
GoalDepartment goalDepartment = new GoalDepartment();

//getAttributeを使い要素を取得する
goal = (Goal) request.getAttribute("goal");
goalDepartment= (GoalDepartment) request.getAttribute("goalDepartment");
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

//GoalDepartmentの値がnullでなければ
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
@import url('https://fonts.googleapis.com/css2?family=BIZ+UDPGothic&display=swap');

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
margin: 30px auto 40px;
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
font-family: "BIZ UDPGothic", sans-serif;
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
display: flex;
padding-left: 40px;
position: relative;
width: 70%;
align-items: center;
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
}}

/* aタグの初期CSSのリセット */
.jackReset{
text-decoration: none;
color: #000;
}

/* 戻るボタンの大枠 */
.jackFlex{
display: flex;
align-items: center;
height: 30px;
width: 85%;
margin: 30px auto 0;
}

/* 矢印 */
.arrow{
display: inline-block;
vertical-align: middle;
transition: transform 0.5s ease;
overflow: visible; 				/* はみ出た内容を表示させる */
}

/* 矢印文字 */
.beaf{
height: 100%;
font-family: "Yomogi", cursive;
font-size: 25px;
}

/* 矢印ホバー時の動き */
.jackReset:hover svg path {
transform: translateX(-10px);
stroke: #f9de95;
fill: #f9de95;
}

/* 割合表示 (可変) */
.ratioBoxS{
-webkit-appearance: none; /* WebKit系のブラウザ（Chrome, Safariなど）に対応 */
-moz-appearance: none;    /* Firefoxに対応 */
appearance: none;         /* 標準的なCSSプロパティ */
border: none;
width: 30px;
padding: 0;
font-size: 25px;
font-family: "Yusei Magic", sans-serif;
color: #545454;
}

.ratioBoxM{
-webkit-appearance: none; /* WebKit系のブラウザ（Chrome, Safariなど）に対応 */
-moz-appearance: none;    /* Firefoxに対応 */
appearance: none;         /* 標準的なCSSプロパティ */
border: none;
width: 43px;
padding: 0;
font-size: 25px;
font-family: "Yusei Magic", sans-serif;
color: #545454;s
}

.ratioBoxL{
-webkit-appearance: none; /* WebKit系のブラウザ（Chrome, Safariなど）に対応 */
-moz-appearance: none;    /* Firefoxに対応 */
appearance: none;         /* 標準的なCSSプロパティ */
border: none;
width: 54px;
padding: 0;
font-size: 25px;
font-family: "Yusei Magic", sans-serif;
color: #545454;
}

.editSubhead{
margin: 20px auto 0;
padding-left: 20px;
width: 75%;
}

.subHeadArea{
-webkit-appearance: none;
-moz-appearance: none;
appearance: none;
border: none;
resize: none;
width: 100%;
height: 70px;
font-size: 20px;
font-family: "BIZ UDPGothic", sans-serif;
}

.mainArea{
-webkit-appearance: none;
-moz-appearance: none;
appearance: none;
border: none;
resize: none;
width: 100%;
height: 60px;
font-size: 15px;
font-family: "BIZ UDPGothic", sans-serif;
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
				<h1 id="link-line">個人目標入力</h1>
			</div>
			
			
			<form action="<%=request.getContextPath()%>/goalUpdate" method="post">
			<div class="seal">
				<!-- 経営テーマの見出し -->
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
				<div class="editSubhead">
				<textarea class="subHeadArea" name="result_comment_reviewer" 
					placeholder="〇〇について知識不足"><%=situationChallenge%></textarea>
				</div>
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
							<div class="yorushikaStripe">
							<div class="yorushika">本人記入</div>
							</div>
								<div class="yorushikaBox">
									<span class="titleBox">小目標</span>
								</div>
								<div class="mainText">
								<textarea class="mainArea" name="result_comment_reviewer" 
									placeholder="〇〇について勉強し、レポートにまとめる"><%=goalQuarterList.get(i).getSmallGoal()%></textarea>
								</div>
							
								<!-- 四半期目標本人記入欄 -->
								<div class="yorushikaBox">
									<span class="titleBox">評価基準・材料</span>
								</div>
								<div class="mainText">
								<textarea class="mainArea" name="result_comment_reviewer" 
									placeholder="レポートの発表"><%=goalQuarterList.get(i).getJudgeMaterial()%></textarea>
								</div>
								
								<div class="yorushikaBox">
										<span class="titleBox">報告内容</span>
									</div>
									<div class="mainText mainFlex">
										<div class="ratio">
											<input type="number" name="result" class="ratioBox ratioBoxS" placeholder="100" min="0" max="100" value="<%=goalQuarterList.get(i).getAchieveRate()%>">%
										</div>
										<div class="leftLine">
										<textarea class="mainArea" name="result_comment_reviewer" 
											placeholder="〇〇することができました。"><%=goalQuarterList.get(i).getReport()%></textarea>
										</div>
									</div>
								
								<!-- 四半期目標評価者記入欄 -->
								<div class="yorushikaStripe">
								<div class="yorushika">評価者記入</div>
								</div>
								
									<div class="yorushikaBox">
										<span class="titleBox">報告内容</span>
									</div>
									<div class="mainText mainFlex">
										<div class="ratio">
											<input type="number" name="result" class="ratioBox ratioBoxS" placeholder="100" min="0" max="100" value="<%=goalQuarterList.get(i).getAchieveRateReviewer()%>">%
										</div>
										<div class="leftLine">
										<textarea class="mainArea" name="result_comment_reviewer" 
											placeholder="上出来です。"><%=goalQuarterList.get(i).getEvaluation()%></textarea>
										</div>
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
						<div class="yorushikaStripe">
						<div class="yorushika">本人記入</div>
						</div>
						<div class="yorushikaBox">
							<span class="titleBox">報告内容</span>
						</div>
						
						<!-- 本人記入欄 -->
						<div class="mainText mainFlex">
						<div class="ratio">
						<input type="number" name="result" class="ratioBox ratioBoxS" placeholder="100" min="0" max="100" value="<%=result%>">%
						</div>
						<div class="leftLine">
							<textarea class="mainArea" name="result_comment_reviewer" 
								placeholder="これからも期待してます。"><%=resultComment%></textarea>
						</div>
						</div>
						
						<!-- 評価者記入欄 -->
						<div class="yorushikaStripe">
						<div class="yorushika">評価者記入</div>
						</div>
						
						<div class="yorushikaBox">
							<span class="titleBox">報告を受けての評価</span>
						</div>
						<div class="mainText mainFlex">
						<div class="ratio">
						<input type="number" name="result" class="ratioBox ratioBoxS" placeholder="100" min="0" max="100" value="<%=resultReviewer%>">%
						</div>
						<div class="leftLine">
							<textarea class="mainArea" name="result_comment_reviewer" 
								placeholder="〇〇を達成できました。"><%=resultCommentReviewer%></textarea>
						</div>
						</div>
					</div>
					<div class="jackFlex">
						<a href="<%=request.getContextPath()%>/goalConfirm?cmd=confirm" class="jackReset">
						<svg class="arrow" width="50"  height="20">
							<path d="M 0 10 L 50 10" stroke="#000" stroke-width="2" fill="none"/>
							<path d="M 0 10 L 25 0" stroke="#000" stroke-width="2" fill="none"/>
						</svg>
						<span class="beaf">PREV</span>
						</a>
					</div>
					<input type="submit" value="更新">
				</form>
		</div>
		</div>
	</div>
	<script type="text/javascript">
	//割合ボックス変動用
	document.addEventListener('DOMContentLoaded', function() {
		// ratioBoxクラスを持つすべてのinput要素を取得
		const numberInputs = document.querySelectorAll('.ratioBox');
		
		// それぞれのinputにイベントリスナーを登録
	    numberInputs.forEach(numberInput => {
			numberInput.addEventListener('input', function() {
				const value = numberInput.value;
				const num = parseInt(value, 10);
				
				// 計算した値に基づいてクラスを切り替える
				if (num === 100) {
					numberInput.classList.add('ratioBoxL');
					numberInput.classList.remove('ratioBoxS');
					numberInput.classList.remove('ratioBoxM');
				} else if (num >= 10 && num <= 99) {
					numberInput.classList.add('ratioBoxM');
					numberInput.classList.remove('ratioBoxS');
					numberInput.classList.remove('ratioBoxL');
				} else if(num < 10) { 
					numberInput.classList.add('ratioBoxS');
					numberInput.classList.remove('ratioBoxM');
					numberInput.classList.remove('ratioBoxL');
				} else {
					numberInput.classList.add('ratioBoxL');
					numberInput.classList.remove('ratioBoxS');
					numberInput.classList.remove('ratioBoxM');
				}
			});
		});
	});
	</script>
</body>
</html>