<!-- 
　個人目標確認機能

　作成者：月向亮太

　作成日：7月8日

　最終更新日：7月25日
 -->
<%@page import="bean.QuarterGoal"%>
<%@page import="bean.TeamGoal"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.ArrayList,bean.Goal"%>

<%
//オブジェクト宣言
TeamGoal teamGoal = new TeamGoal();
Goal goal = new Goal();

//getAttributeを使い要素を取得する
teamGoal = (TeamGoal) request.getAttribute("teamGoal");
goal = (Goal) request.getAttribute("goal");
ArrayList<QuarterGoal> quarterGoalList = (ArrayList<QuarterGoal>) request.getAttribute("quarter_goal_list");

//変数宣言
String departmentGoal = "";
String groupGoal = "";
String annualGoal = "";
String situationChallenge = "";
String result = "";
String resultComment = "";
String resultReviewer = "";
String resultCommentReviewer = "";

//teamGoalの値がnullでなければ
if (teamGoal != null) {
	//ゲッターメソッドを使って値を取得する
	departmentGoal = teamGoal.getDepartmentGoal();
	groupGoal = teamGoal.getGroupGoal();
}

//goalの値がnullでなければ
if (goal != null) {

	//ゲッターメソッドを使って値を取得する
	annualGoal = goal.getAnnualGoal();
	situationChallenge = goal.getSituationChallenge();
	result = goal.getResult();
	resultComment = goal.getResultComment();
	resultReviewer = goal.getResultReviewer();
	resultCommentReviewer = goal.getResultCommentReviewer();
}
%>
<!DOCTYPE html>
<html>
<head>
<title>個人目標確認</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
</head>
<style>
/* 個人目標のCSS */
#goalTitle {
	position: relative;
	margin-top: 100px;
	margin-bottom: 10px;
	width: 80%;
	border-radius: 30px;
	background-color: #ffffff;
	box-shadow: 1px 2px 5px #CCCCEE;
	font-size: 20px;
}

#quarterGoal {
	position: relative;
	padding-bottom: 10%;
	margin-top: 100px;
	margin-bottom: 10px;
	width: 80%;
	border-radius: 30px;
	background-color: #ffffff;
	box-shadow: 1px 2px 5px #CCCCEE;
	text-align: center;
	font-size: 20px;
}

#result {
	position: relative;
	margin-top: 100px;
	margin-bottom: 10px;
	width: 80%;
	border-radius: 30px;
	background-color: #ffffff;
	box-shadow: 1px 2px 5px #CCCCEE;
	text-align: center;
	font-size: 20px;
}

.departpadding {
	position: relative;
	margin-left: auto;
	padding: 0 50px 20px;
	text-align: left;
	flex-direction: row;
	flex-wrap: nowrap;
	align-items: center;
	justify-content: center;
}

.edit { /*編集ボタン*/
	position: absolute;
	top: 0;
	right: 45px;
	min-width: 10%;
}

.goalpadding {
	padding: 20px 50px 10px;
	text-align: left;
}

.goalflex {
	display: fiex;
	width: 80%;
}

.selfGoal {
	position: relative;
	right: 500px;
	font-size: 30px;
}

.chatGoal {
	position: relative;
	right: 370px;
	font-size: 30px;
}

#goalTitle textarea {
	padding: 0;
	resize: none;
	width: 100%;
	height: 150px;
	overflow: auto; /* 縦方向にスクロールが行える！*/
	border: none;
	outline: none;
	text-align: left;
	font-size: 24px;
	font-family: kokoro;
}

#quarterTitle textarea {
	padding: 0;
	width: 80%;
	height: 100px;
	resize: none;
	border: none;
	border-right: 2px solid #bee1de; ! important;
	overflow: auto; /* 縦方向にスクロールが行える！*/
	outline: none;
	font-size: 24px;
	font-family: kokoro;
	text-align: left;
}

#goalTitle .quarter .smallGoal {
	width: 100%;
	height: 100px;
	resize: none;
	overflow: auto; /* 縦方向にスクロールが行える！*/
}

#quarterTitle .goalpadding {
	padding-bottom: 30px;
	background-color: #fff7de;
	text-align: center;
}

#goalTitle h3 {
	margin: 0 auto;
	width: 100%;
	border-bottom: 1px solid #000000;
	text-align: left;
	left: 20px;
}

#quarterTitle h3 {
	padding-left: 90px;
	padding-top: 20px;
	margin: 0 auto;
	width: 100%;
	text-align: left;
}

#result h3 {
	margin: 0 auto;
	width: 100%;
	text-align: left;
}

.quarterGoal {
	margin: 0 auto;
	width: 80.5%;
	background-color: #ffd700;
	text-align: left;
	left: 350px;
}

.subTitle {
	background-color: #ffCC00;
	font-size: 18px;
	text-align: left;
	color: #FF0000;
	font-weight: bold;
}

.record {
	background-color: #ffCC00;
	font-size: 18px;
	text-align: left;
	color: #ffffff;
}

.achieve {
	background-color: #ffCC00;
	font-size: 18px;
	text-align: center;
	color: #ffffff;
}

.report {
	background-color: #ffCC00;
	font-size: 18px;
	text-align: left;
	color: #ffffff;
}

.vertical {
	writing-mode: vertical-rl;
	background-color: #ffCC00;
}

.details {
	width: 90%;
	height: 100%;
	transition: all ease-in .3s;
	border-left: 2px solid #00a5a0;
	border-right: 2px solid #00a5a0;
	border-bottom: 1px solid #00a5a0;
	box-sizing: border-box;
	&:
	last-of-type
	{
	border-bottom
	:
	2px
	solid
	#00a5a0;
}

}
.details[open] {
	height: 100%;
	background-color: #bee1de;
}

.details-summary {
	display: block;
	border-top: 1px solid #00a5a0;
	transition: all ease-in-out .3s; &: hover { cursor : pointer;
	background-color: #bee1de;
	font-size: 20px;
	font-weight: bold;
}

}
.details-summary::-webkit-details-marker {
	display: none;
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

@
keyframes fadeIn { 0% {
	opacity: 0;
	transform: translateY(-10px);
}

}
/* 以下の記述は不要です */
body {
	margin: 20px;
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
</style>

<body>
	<div id="wrap">
		<%@ include file="../common/header.jsp"%>
		<div id="main" class="container">
			<form action="<%=request.getContextPath()%>/goalDetail" method="POST">


				<div id="goalTitle" class="container">

					<h1 style="text-align: center">個人目標</h1>

					<div class="departpadding">
						<h3>部目標</h3>
						<div class="edit">
							<input type="submit" value="編集"> <input type="hidden"
								name="cmd" value="update">
						</div>
					</div>
					<div class="goalpadding">
						<input type="hidden" name="team_id"
							value="<%=teamGoal.getTeamId()%>">
						<textarea readonly name="departmentGoal" rows="5" cols="80"><%=departmentGoal%></textarea>
					</div>
					<div class="goalpadding">
						<h3>チーム目標</h3>
						<textarea readonly name="groupGoal" rows="5" cols="80"><%=groupGoal%></textarea>
					</div>
					<div class="goalpadding">
						<h3>年間目標</h3>
						<input type="hidden" name="goal_id" value="<%=goal.getGoalId()%>">
						<textarea readonly name="annualGoal" rows="5" cols="80"><%=annualGoal%></textarea>
					</div>
					<div class="goalpadding">
						<h3>現状と課題</h3>
						<textarea readonly name="situationChallenge" rows="5" cols="80"><%=situationChallenge%></textarea>
					</div>

				</div>

				<div id="quarterGoal" class="container">
					<h1>目標を達成するためのステップ</h1>
					<div id="quarterTitle" class="container">
						<div class="tab-4">
							<!--Java処理-->
							<%
							if (quarterGoalList != null) {
								for (int i = 0; i < quarterGoalList.size(); i++) {
							%>

							<label> <input type="radio" name="tab-4"> 第<%=i + 1%>四半期
							</label>
							<div class="goalpadding">
								<div class="contents">
									<h3>小目標</h3>
									<input type="hidden" name="quarter_goal_id<%=i + 1%>"
										value="<%=quarterGoalList.get(i).getQuarterGoalId()%>">
									<textarea readonly class="details-content"
										name="small_goal<%=i + 1%>" rows="5" cols="30"><%=quarterGoalList.get(i).getSmallGoal()%></textarea>
								</div>
								<div class="contents">
									<h3>評価基準・材料</h3>
									<textarea readonly class="details-content"
										name="judge_material<%=i + 1%>" rows="5" cols="30"><%=quarterGoalList.get(i).getJudgeMaterial()%></textarea>
								</div>

								<div class="flex">
									<h3 style="flex-shrink: 3;">達成率</h3>
									<h3>報告内容</h3>
								</div>
								<div style="width: 80%; margin: 0 auto;">
									<div class="flex">
										<textarea readonly class="details-content"
											name="achieve_rate<%= i + 1 %>" rows="10" style="flex: 1"><%=quarterGoalList.get(i).getAchieveRate()%></textarea>
										<textarea readonly class="details-content"
											name="report<%= i + 1 %>" rows="10" style="flex: 3"><%=quarterGoalList.get(i).getReport()%></textarea>
									</div>
								</div>

								<div class="flex">
									<h3 style="flex-shrink: 3;">達成率</h3>
									<h3>報告を受けての評価</h3>
								</div>
								<div style="width: 80%; margin: 0 auto;">
									<div class="flex">
										<textarea readonly class="details-content"
											name="achieve_rate_reviewer" rows="10" style="flex: 1"><%=quarterGoalList.get(i).getAchieveRateReviewer()%></textarea>
										<textarea readonly class="details-content" name="evaluation"
											rows="10" style="flex: 3"><%=quarterGoalList.get(i).getEvaluation()%></textarea>
									</div>
								</div>
							</div>
							<!--Java処理-->
							<%
							}
							}
							%>
						</div>
					</div>
				</div>

				<div id="goalTitle" class="container">
					<h1 style="text-align: center">年間結果</h1>
					<div class="goalpadding">
						<h3>本人記入</h3>
					</div>
					<div class="goalpadding">
						<h3>達成率 報告を受けての評価</h3>
					</div>
					<div class="goalpadding">
						<div class="flex">
							<div style="width: 20%">
								<textarea readonly name="annualGoal" rows="10" cols="80"><%=result%></textarea>
							</div>
							<div style="width: 80%">
								<textarea readonly name="annualGoal" rows="10" cols="80"><%=resultComment%></textarea>
							</div>
						</div>
					</div>
					<div class="goalpadding">
						<h3>評価者記入</h3>
					</div>
					<div class="goalpadding">
						<h3>達成率 報告内容</h3>
					</div>
					<div class="goalpadding">
						<div class="flex">
							<div style="width: 20%">
								<textarea readonly name="annualGoal" rows="10" cols="80"><%=resultReviewer%></textarea>
							</div>
							<div style="width: 80%">
								<textarea readonly name="annualGoal" rows="10" cols="80"><%=resultCommentReviewer%></textarea>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>