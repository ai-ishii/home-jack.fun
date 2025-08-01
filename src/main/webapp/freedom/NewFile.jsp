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
</head>
<meta charset="UTF-8">

<script>
    //ページのHTMLがすべて読み込まれてから処理を開始
    document.addEventListener("DOMContentLoaded", function() {
        //全てのタブ（ラジオボタン）を取得
        const tabs = document.querySelectorAll('input[name="tab-4"]');

        //ループ処理
        tabs.forEach(function(tab) {
            //各タブにクリックイベントを追加
            tab.addEventListener('click', function() {
                //クリックされたタブに対応するコンテンツパネルを探す
                //this = クリックされたinput要素
                //this.parentElement = それを囲むlabel要素
                //nextElementSibling = labelのすぐ隣にある要素（コンテンツのdiv）
                const content = this.parentElement.nextElementSibling;
                
                //もしクリックしたタブが既に選択済みで、コンテンツが表示状態であれば
                if (this.checked && content.style.display === 'block') {
                    //選択を解除し、コンテンツを非表示
                    this.checked = false;
                    content.style.display = 'none';
                } else {
                    //そうでなければ、通常通りコンテンツを表示
                    //他のタブのコンテンツは、ラジオボタンの性質上自動で非表示
                    content.style.display = 'block';
                }
            });
        });

        //初期状態で選択されているタブがあれば、そのコンテンツを表示
        const initiallyChecked = document.querySelector('input[name="tab-4"]:checked');
        if (initiallyChecked) {
            initiallyChecked.parentElement.nextElementSibling.style.display = 'block';
        }
    });
</script>

<style>

.container {
	width: 100%;
	margin: 0 auto;
}

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
	background-color: #bee1de;
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
	resize: none;
	width: 100%;
	height: 150px;
	overflow: auto; /* 縦方向にスクロールが行える！*/
	border: none;
	outline: none;
	font-size: 24px;
	font-family: kokoro;
	text-align: left;
	padding: 0;
}

#quarterTitle textarea {
	resize: none;
	width: 80%;
	height: 100px;
	border: none;
	border-right: 2px solid #bee1de; ! important;
	overflow: auto; /* 縦方向にスクロールが行える！*/
	outline: none;
	font-size: 24px;
	font-family: kokoro;
	text-align: left;
	padding: 0;
}

#goalTitle .quarter .smallGoal {
	resize: none;
	width: 100%;
	height: 100px;
	overflow: auto; /* 縦方向にスクロールが行える！*/
}

#quarterTitle .goalpadding {
	text-align: center;
	padding-bottom: 30px;
	background-color: #fff7de;
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

#quarterGoal {
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

.tab-4 {
	display: flex;
	max-width: 900px;
	margin: 0 auto;
	flex-direction: row;
	flex-wrap: wrap;
}

.tab-4>label {
	flex: 1 1;
	order: -1;
	min-width: 70px;
	padding: .7em 1em .5em;
	background-color: #f2f2f2;
	color: #999;
	font-weight: 600;
	font-size: .9em;
	text-align: center;
	cursor: pointer;
}

.tab-4>label:hover {
	opacity: .8;
}

.tab-4 input {
	display: none;
}

.tab-4>div {
	display: none;
	width: 100%;
	padding: 1.5em 1em;
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
<div id="quarterGoal" class="container">
	<h1>目標を達成するためのステップ</h1>
		<div id="quarterTitle" class="container">
	<div class="tab-4">
		<!--Java処理-->
		<%
		if (quarterGoalList != null) {
			for (int i = 0; i < quarterGoalList.size(); i++) {
	%>
	
		<label> <input type="radio" name="tab-4"> 第<%= i+1 %>四半期
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
				<h3 style="">報告内容</h3>
			</div>
			<div style="width: 80%; margin: 0 auto;">
				<div class="flex">
					<textarea readonly class="details-content" name="achieve_rate"
						rows="10" style="flex: 1"><%=quarterGoalList.get(i).getAchieveRate()%></textarea>
					<textarea readonly class="details-content" name="report" rows="10"
						style="flex: 3"><%=quarterGoalList.get(i).getReport()%></textarea>
				</div>
			</div>
			<div class="contents">
				<h3>達成率 報告を受けての評価</h3>
				<div style="width: 80%; margin: 0 auto;">
					<div class="flex">
						<textarea readonly class="details-content"
							name="achieve_rate_reviewer" rows="10" style="flex: 1"><%=quarterGoalList.get(i).getAchieveRateReviewer()%></textarea>
						<textarea readonly class="details-content" name="evaluation"
							rows="10" style="flex: 3"><%=quarterGoalList.get(i).getEvaluation()%></textarea>
					</div>
				</div>
			</div>
		</div>

		<%
			}
		}
	%>
	</div>
	</div>
	</div>
	
</html>