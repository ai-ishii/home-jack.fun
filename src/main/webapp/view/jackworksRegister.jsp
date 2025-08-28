<%--
JackWorks登録画面

作成者：青木美波
更新者：占部虎司郎

作成日 2025/07/10
更新日：今日
 --%>
 
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.text.SimpleDateFormat,java.util.Date,java.sql.Timestamp,java.util.ArrayList,bean.Jackworks,bean.Monthjack"%>
<%@page import="jakarta.servlet.http.HttpSession" %>

<%
//ページ分けを行うためのcmdを受け取る
String cmd = (String) request.getAttribute("cmd");

if(cmd == null){
	cmd="";
}

//PREVボタンで戻る際の値保持のためセッションから受け取る。
HttpSession sessionJack = request.getSession();
Jackworks jack = new Jackworks();
jack = (Jackworks)session.getAttribute("jack");
%>

<html>
<head>
<!-- タイトル -->
<title>JackWorks申請 | Home-Jack</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
<script src="<%=request.getContextPath()%>/js/script.js"></script>
<script src="<%=request.getContextPath()%>/js/error.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>

<!--　以下CSS　-->
<style>

#contents {
	width: 80%;
	margin-right: auto;
	margin-left: auto;
}

/* タイトル部分 */
#link-title {
	text-align: center;
}

#link-collect {
	margin-top: 5%;
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

#box-mar {
	margin: 0 auto;
}

/* 登録ボタンの配置 */
#JackWorks-submit {
	text-align: center;
}

textarea {
	resize: none;
	width: 100%;
	height: 100px;
	font-size: 16px;
}

/* 米印の色 */
.warning {
	color: red;
}

/*  並べる方向を指定 */
.dis-flex {
	display: flex;
}

.topSpace{
margin-top: 24px;
}

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
	border-radius: 0 0 0.5rem 0.5rem;
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

/* 黒小見出し */
.subBlack{
font-size: 18px;
color: #363636;
margin-left: 10px;
margin-right: auto;
margin-bottom: 2px;
}

/* グレーの縦線 */
.nintendoStripe{
display: flex;
justify-content: center;   /* 水平方向の中央揃え */
align-items: center;
border-left: 5px solid #aaaaaa;
}

/* テーブル間隔開ける */
.textPadd{
padding-bottom: 16px;
}

/* 日付ボックス */
.dateBox{
height: 30px;
font-size: 16px;
}

/* テキストボックス */
.monthBox{
width: 100%;
height: 30px;
font-size: 16px;
}

/* 少しの空間 */
.tdMag{
padding-bottom: 4px;
}

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
margin-top: 24px;
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

</style>

<body>
	<div id="wrap">
		<!-- ヘッダー部分 -->
		<%@ include file="../common/header.jsp"%>

		<!-- メイン部分 -->
		<div id="main" class="container">
		
		<div id="contents">

		<!-- タイトル部分 -->
		<div id="link-title">
			<h1 id="link-line">JackWorks申請</h1>
		</div>

		<!-- 入力された今月のJackWorksのデータを送るフォーム -->
		<form action="<%=request.getContextPath()%>/jackworksRegister"  class="error-form">
		
		<div class="topSpace"></div>
		
		<% if(cmd.equals("")){ %>

			<!-- 入力フォーム -->
			<table id="box-mar">
				<tr>
					<td style="display: flex" class="tdMag">
						<div class="nintendoStripe">
							<div class="subBlack">ポイント取得日</div>
						</div>
						<div class="warning">*</div>
					</td>
				</tr>
					<td class="textPadd">
					<label for="start_date"></label>
					<input type="date" class="error-check-default dateBox" name="date" max="9999-12-31" 
						value="<%if(jack != null){%><%=jack.getPointsGetDate()%><%}%>">
					</td>
				<tr>
					<td style="display: flex" class="tdMag">
						<div class="nintendoStripe">
							<div class="subBlack">社員No</div>
						</div>
						<div class="warning">*</div>
					</td>
				</tr>
					<td class="textPadd">
						<input type="text" name="employeeNumber" size="45" placeholder="001234" 
							class="convert-full-to-half error-check-number error-check-digit monthBox" data-exactlength="6" value="<%if(jack != null){%><%=jack.getEmployeeNumber()%><%} %>">
					</td>
				<tr>
					<td style="display: flex" class="tdMag">
						<div class="nintendoStripe">
							<div class="subBlack">氏名</div>
						</div>
						<div class="warning">*</div>
					</td>
				</tr>
					<td class="textPadd">
						<input type="text" name="name" value="<%if(jack != null){%><%=jack.getName()%><%}%>" size="45" placeholder="山田太郎" class="convert-full-to-half error-check-default monthBox">
					</td>
				<tr>
					<td style="display: flex" class="tdMag">
						<div class="nintendoStripe">
							<div class="subBlack">カテゴリ</div>
						</div>
						<div class="warning">*</div>
					</td>
				</tr>
					<td class="textPadd">
						<input type="text" name="category" value="<%if(jack != null){%><%=jack.getCategory()%><%} %>" 
							size="45" placeholder="チーム取組み" class="convert-full-to-half error-check-default monthBox">
					</td>
				<tr>
					<td style="display: flex" class="tdMag">
						<div class="nintendoStripe">
							<div class="subBlack">項目</div>
						</div>
						<div class="warning">*</div>
					</td>
				</tr>
					<td class="textPadd">
						<input type="text" name="assessment" placeholder="チーム活動報告の投稿" 
							class="convert-full-to-half error-check-default monthBox" value="<%if(jack != null){%><%=jack.getAssessment()%><%} %>">
					</td>
				<tr>
					<td style="display: flex" class="tdMag">
						<div class="nintendoStripe">
							<div class="subBlack">付与ポイント</div>
						</div>
						<div class="warning">*</div>
					</td>
				</tr>
					<td class="textPadd">
						<input type="text" name="point" value="<%if(jack != null){%><%=jack.getPoint()%><%} %>" 
							size="45" placeholder="10" class="convert-full-to-half error-check-number monthBox">
					</td>
				<tr>
					<td style="display: flex" class="tdMag">
						<div class="nintendoStripe">
							<div class="subBlack">備考</div>
						</div>
					</td>
				</tr>
					<td class="textPadd"><textarea name="note" rows="" cols=""><%if(jack != null){%><%=jack.getNote()%><%} %></textarea></td>
				<tr>
			</table>
				
				<!-- 登録ボタン -->
				<div class="box-mar">
				<div class="jackFlex">
					<div class="yoruArrow">
					<a href="<%=request.getContextPath()%>/monthJackworks" class="jackReset">
					<svg class="arrow" width="50"  height="20">
						<path d="M 0 10 L 50 10" stroke="#000" stroke-width="2" fill="none"/>
						<path d="M 0 10 L 25 0" stroke="#000" stroke-width="2" fill="none"/>
					</svg>
					<span class="beaf">PREV</span>
					</a>
					</div>
					<div>
					<input type="hidden" name="cmd" value="next">
					<button type="submit" class="btn btn-border">
					<span class="btnUp">申請</span>
					</button>
					</div>
					<div class="jackDummy"></div>
				</div>
				</div>
		</form>
				<% } %>
				
				<!-- 2ページ目 -->
				<% if(cmd.equals("next")){ %>
				
				<!-- 入力された今月のJackWorksのデータを送るフォーム -->
				<form action="<%=request.getContextPath()%>/jackworksRegister" class="error-form">
				
				<!-- 入力フォーム -->
				<table id="box-mar">
				<tr>
					<td style="display: flex" class="tdMag">
						<div class="nintendoStripe">
							<div class="subBlack">案件名</div>
						</div>
						<div class="warning">*</div>
					</td>
				</tr>
					<td class="textPadd">
						<input type="text" name="project" value="" size="45" class="convert-full-to-half error-check-default monthBox">
					</td>
				<tr>
					<td style="display: flex" class="tdMag">
						<div class="nintendoStripe">
							<div class="subBlack">作業時期</div>
						</div>
						<div class="warning">*</div>
					</td>
				</tr>
					<td class="textPadd">
						<input type="text" name="workSeason" value="" size="45"  class="convert-full-to-half error-check-default monthBox">
					</td>
				<tr>
					<td style="display: flex" class="tdMag">
						<div class="nintendoStripe">
							<div class="subBlack">単価</div>
						</div>
						<div class="warning">*</div>
					</td>
				</tr>
					<td class="textPadd">
						<input type="text" name="price" value="" size="45" placeholder="数字のみ入力" class="convert-full-to-half error-check-number monthBox">
					</td>
				<tr>
					<td style="display: flex" class="tdMag">
						<div class="nintendoStripe">
							<div class="subBlack">精算</div>
						</div>
						<div class="warning">*</div>
					</td>
				</tr>
					<td class="textPadd">
						<input type="text" name="pay" value="" size="45" placeholder="数字のみ入力" class="convert-full-to-half error-check-number monthBox">
					</td>
				<tr>
					<td style="display: flex" class="tdMag">
						<div class="nintendoStripe">
							<div class="subBlack">作業場所</div>
						</div>
						<div class="warning">*</div>
					</td>
				</tr>
					<td class="textPadd">
						<input type="text" name="workPlace" value="" size="45" class="convert-full-to-half error-check-default monthBox">
					</td>
				<tr>
					<td style="display: flex" class="tdMag">
						<div class="nintendoStripe">
							<div class="subBlack">作業内容</div>
						</div>
						<div class="warning">*</div>
					</td>
				</tr>
					<td class="textPadd">
						<textarea name="workContent" rows="" cols="" class="convert-full-to-half error-check-default"></textarea>
					</td>
				<tr>
					<td class="tdMag">
						<div class="nintendoStripe">
							<div class="subBlack">フェーズ</div>
						</div>
						</td>
				</tr>
					<td class="textPadd">
						<textarea name="phase" rows="" cols=""></textarea>
					</td>
				<tr>
					<td class="tdMag">
						<div class="nintendoStripe">
							<div class="subBlack">開発言語</div>
						</div>
					</td>
				</tr>
					<td class="textPadd">
						<textarea name="language" rows="" cols=""></textarea>
					</td>
				<tr>
					<td class="tdMag">
						<div class="nintendoStripe">
							<div class="subBlack">必要スキル</div>
						</div>
					</td>
				</tr>
					<td class="textPadd"><textarea name="skill" rows="" cols=""></textarea></td>
				<tr>
					<td class="tdMag">
						<div class="nintendoStripe">
							<div class="subBlack">必要人数</div>
						</div>
					</td>
				</tr>
					<td class="textPadd">
						<input type="text" name="needPeople" value="" size="45" class="monthBox">
					</td>
				<tr>
					<td style="display: flex" class="tdMag">
						<div class="nintendoStripe">
							<div class="subBlack">営業担当者</div>
						</div>
						<div class="warning">*</div>
					</td>
				</tr>
					<td class="textPadd">
						<input type="text" name="seller" value="" size="45" class="convert-full-to-half error-check-default monthBox">
					</td>
				<tr>
					<td style="display: flex" class="tdMag">
						<div class="nintendoStripe">
							<div class="subBlack">連絡先</div>
						</div>
						<div class="warning">*</div>
					</td>
				</tr>
					<td class="textPadd">
						<textarea name="contact" rows="" cols="" class="convert-full-to-half error-check-default"></textarea>
					</td>
				<tr>
					<td class="tdMag">
						<div class="nintendoStripe">
							<div class="subBlack">その他</div>
						</div></td>
				</tr>
					<td class="textPadd">
						<textarea name="other" rows="" cols=""></textarea>
					</td>
			</table>

			<!-- 登録ボタン -->
			<div class="jackFlex">
					<div class="yoruArrow">
					<a href="<%=request.getContextPath()%>/view/jackworksRegister.jsp" class="jackReset">
					<svg class="arrow" width="50"  height="20">
						<path d="M 0 10 L 50 10" stroke="#000" stroke-width="2" fill="none"/>
						<path d="M 0 10 L 25 0" stroke="#000" stroke-width="2" fill="none"/>
					</svg>
					<span class="beaf">PREV</span>
					</a>
					</div>
					<div>
					<input type="hidden" name="cmd" value="register">
					<button type="submit" class="btn btn-border">
					<span class="btnUp">申請</span>
					</button>
					</div>
					<div class="jackDummy"/>
				</div>
			</form>
			
			<% } %>
			
		</div>
		</div>
	</div>
</body>
</html>