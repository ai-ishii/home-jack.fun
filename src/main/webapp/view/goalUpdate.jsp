<!-- 
 個人目標確認画面

 作成者：月向亮太
 更新者：占部虎司郎

 作成日：7月8日
 最終更新日：8月27日
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
int goalId = 0;

//goalの値がnullでなければ
if (goal != null) {

	//ゲッターメソッドを使って値を取得する
	goalId = goal.getGoalId();
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
.tab-4 > input[type="radio"],
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

/* 中央揃えのためのダミー */
.jackDummy{
width: 150px;
}

/* 戻るボタンの大枠 */
.jackFlex{
display: flex;
justify-content: space-between;
align-items: center;
height: 30px;
width: 85%;
margin: 30px auto 0;
}

/* 矢印の枠 */
.yoruArrow{
width: 150px;
padding-top: 8px;
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

/* プレースホルダーの色 */
.ratioBox::placeholder{
color: #c2c2c2;
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
width: 44px;
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

/* 更新ボタン */
.btn, a.btn, button.btn {
-webkit-box-sizing: border-box;
box-sizing: border-box;
	font-size: 14px;
	font-weight: 700;
	line-height: 1.5;
	position: relative;
	display: inline-block;
	padding: 5px 20px;
	cursor: pointer;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
	-webkit-transition: all 0.3s;
	transition: all 0.3s;
	text-align: center;
	vertical-align: middle;
	text-decoration: none;
	letter-spacing: 1.4px;
	color: #212529;
	border-radius: 5px;
	border: none;
}

button.btn-border {
-webkit-box-sizing: border-box;
box-sizing: border-box;
	margin-bottom: 12px;
	padding: 0;
	-webkit-transition: all 0.3s;
	transition: all 0.3s;
	border-radius: 0;
}

button.btn-border span.btnUp {
-webkit-box-sizing: border-box;
box-sizing: border-box;
	position: relative;
	display: block;
	padding: 6px 18px;
	color: #000;
	border: 2px solid #000;
	border-radius: 5px;
	background: #fff;
}

button.btn-border:before {
-webkit-box-sizing: border-box;
box-sizing: border-box;
	position: absolute;
	bottom: -8px;
	left: 0;
	display: block;
	width: 100%;
	height: 14px;
	content: "";
	-webkit-transition: all 0.3s;
	transition: all 0.3s;
	border: 2px solid #000;
	border-top: 1px solid #000;
	border-radius: 0 0 5px 5px;
	background-image: -webkit-repeating-linear-gradient(135deg, #000, #000 1px, transparent
		2px, transparent 5px);
	background-image: repeating-linear-gradient(-45deg, #000, #000 1px, transparent 2px,
		transparent 5px);
	background-size: 7px 7px;
	-webkit-backface-visibility: hidden;
	backface-visibility: hidden;
}

button.btn-border:hover {
-webkit-box-sizing: border-box;
box-sizing: border-box;
	-webkit-transform: translate(0, 3px);
	transform: translate(0, 3px);
}

button.btn-border:hover:before {
-webkit-box-sizing: border-box;
box-sizing: border-box;
	bottom: -5px;
}

button.btn-border:active {
-webkit-box-sizing: border-box;
box-sizing: border-box;
	-webkit-transform: translate(0, 7px);
	transform: translate(0, 7px);
}

button.btn-border:active:before {
-webkit-box-sizing: border-box;
box-sizing: border-box;
	bottom: -1px;
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
				<div class="subhead">
				<textarea class="subHeadArea" name="annual_goal" 
					placeholder="AIの作成"><%=annualGoal%></textarea></div>
				
				<!-- 現状と課題のボックス -->
				<div class="yorushikaBox">
				<span class="titleBox">現状と課題</span>
				</div>
				<div class="editSubhead">
				<textarea class="subHeadArea" name="situation_challenge" 
					placeholder="〇〇について知識不足"><%=situationChallenge%></textarea>
				<input type="hidden" name="goal_id" value="<%=goalId%>"
				</div>
				</div>
				
					<div class="seal">
					<!-- 4半期目標のボックス -->
					<div class="yorushikaLine">
					目標を達成するためのステップ
					</div>
					<div class="tab-4" style="min-height: 30px;" >
					<%

						for (int i = 0; i < 4; i++) {
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
								<textarea class="mainArea" name="small_goal<%=i + 1%>" 
									placeholder="〇〇について勉強し、レポートにまとめる"><%if(goalQuarterList.size() != 0){%><%=goalQuarterList.get(i).getSmallGoal()%><%}%></textarea>
									<input type="hidden" name="quarter_goal_id<%=i + 1%>" value="<%=goalQuarterList.get(i).getGoalQuarterId()%>">
									<input type="hidden" name="quarterly_flag<%=i + 1%>" value="<%=goalQuarterList.get(i).getQuarterlyFlag()%>">
								</div>
							
								<!-- 四半期目標本人記入欄 -->
								<div class="yorushikaBox">
									<span class="titleBox">評価基準・材料</span>
								</div>
								<div class="mainText">
								<textarea class="mainArea" name="judge_material<%=i + 1%>" 
									placeholder="レポートの発表"><%if(goalQuarterList.size() != 0){%><%=goalQuarterList.get(i).getJudgeMaterial()%><%}%></textarea>
								</div>
								
								<div class="yorushikaBox">
										<span class="titleBox">報告内容</span>
									</div>
									<div class="mainText mainFlex">
										<div class="ratio">
											<input type="number" name="achieve_rate<%=i + 1%>" class="ratioBox ratioBoxS" placeholder="100" min="0" max="100" 
												value="<%if(goalQuarterList.size() != 0){%><%=goalQuarterList.get(i).getAchieveRate()%><%}%>">%
										</div>
										<div class="leftLine">
										<textarea class="mainArea" name="report<%=i + 1%>" 
											placeholder="〇〇することができました。"><%if(goalQuarterList.size() != 0){%><%=goalQuarterList.get(i).getReport()%><%}%></textarea>
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
											<input type="number" name="achieve_rate_reviewer<%=i + 1%>" readonly class="ratioBox ratioBoxS" placeholder="100" min="0" max="100" 
												value="<%if(goalQuarterList.size() != 0){%><%=goalQuarterList.get(i).getAchieveRateReviewer()%><%}%>">%
										</div>
										<div class="leftLine">
										<textarea class="mainArea" name="evaluation<%=i + 1%>" readonly
											placeholder="上出来です。"><%if(goalQuarterList.size() != 0){%><%=goalQuarterList.get(i).getEvaluation()%><%}%></textarea>
										</div>
									</div>
									
							</div>
	
					<%
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
							<textarea class="mainArea" name="result_comment" 
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
						<input type="number" name="result_reviewer" readonly class="ratioBox ratioBoxS" placeholder="100" min="0" max="100" value="<%=resultReviewer%>">%
						</div>
						<div class="leftLine">
							<textarea class="mainArea" name="result_comment_reviewer" readonly
								placeholder="〇〇を達成できました。"><%=resultCommentReviewer%></textarea>
						</div>
						</div>
					</div>
					<div class="jackFlex">
						<div class="yoruArrow">
						<a href="<%=request.getContextPath()%>/goalConfirm?cmd=confirm" class="jackReset">
						<svg class="arrow" width="50"  height="20">
							<path d="M 0 10 L 50 10" stroke="#000" stroke-width="2" fill="none"/>
							<path d="M 0 10 L 25 0" stroke="#000" stroke-width="2" fill="none"/>
						</svg>
						<span class="beaf">PREV</span>
						</a>
						</div>
						<div>
						<button type="submit" class="btn btn-border">
						<span class="btnUp">更新</span>
						</button>
						</div>
						<div class="jackDummy"></div>
					</div>
				</form>
		</div>
		</div>
	</div>
	<script type="text/javascript">
	//割合ボックス変動用
	document.addEventListener('DOMContentLoaded', function() {
    const numberInputs = document.querySelectorAll('.ratioBox');

    // クラスを更新するロジックを一つの関数にまとめる
    function updateClassByValue(inputElement) {
        const value = inputElement.value;
        const num = parseInt(value, 10);
        
        // 既存のクラスを一度全て削除
        inputElement.classList.remove('ratioBoxS', 'ratioBoxM', 'ratioBoxL');

        // 計算した値に基づいてクラスを切り替える
        if (num === 100) {
            inputElement.classList.add('ratioBoxL');
        } else if (num >= 10 && num <= 99) {
            inputElement.classList.add('ratioBoxM');
        } else if (num >= 0 && num <= 9) {
            inputElement.classList.add('ratioBoxS');
        } else {
            // 範囲外の数値が入力された場合、デフォルトのクラスを適用
            inputElement.classList.add('ratioBoxL');
        }
    }

    //forEachループを一つにまとめる
    numberInputs.forEach(inputElement => {
        // 1. 初期値に基づいてクラスを更新
        updateClassByValue(inputElement);

        // 2. inputイベントリスナーを登録
        inputElement.addEventListener('input', function() {
            updateClassByValue(this);
        });
    });
});
	</script>
</body>
</html>