<%--
JackWorks登録画面
作成者：青木美波
作成日 2025/07/10
 --%>

<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.text.SimpleDateFormat,java.util.Date,java.sql.Timestamp,java.util.ArrayList,bean.Jackworks,bean.Monthjack"%>

<%
//JackWorksの全情報が格納されたjack_listを受け取る
String cmd = (String) request.getAttribute("cmd");

if(cmd == null){
	cmd="";
}
%>

<html>
<head>
<title>JackWorks</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">

<!-- 以下CSS記述 -->
<style type="text/css">

#contents {
	width: 90%;
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
	width: 270px;
	height: 100px;
}

/* 米印の色 */
.warning {
	color: red;
}

/*  並べる方向を指定 */
.dis-flex {
	display: flex;
}

/* 登録ボタンのデザイン */
*, *:before, *:after {
	-webkit-box-sizing: inherit;
	box-sizing: inherit;
}

html {
	-webkit-box-sizing: border-box;
	box-sizing: border-box;
	font-size: 62.5%;
}

.btn, a.btn, button.btn {
	font-size: 1.4rem;
	font-weight: 700;
	line-height: 1.5;
	position: relative;
	display: inline-block;
	padding: 0.5rem 2rem;
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
	letter-spacing: 0.1em;
	color: #212529;
	border-radius: 0.5rem;
	border: none;
}

button.btn-border {
	margin-bottom: 12px;
	padding: 0;
	-webkit-transition: all 0.3s;
	transition: all 0.3s;
	border-radius: 0;
}

button.btn-border span {
	position: relative;
	display: block;
	padding: 0.6rem 1.8rem;
	color: #000;
	border: 2px solid #000;
	border-radius: 0.5rem;
	background: #fff;
}

button.btn-border:before {
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
	-webkit-transform: translate(0, 3px);
	transform: translate(0, 3px);
}

button.btn-border:hover:before {
	bottom: -5px;
}

button.btn-border:active {
	-webkit-transform: translate(0, 7px);
	transform: translate(0, 7px);
}

button.btn-border:active:before {
	bottom: -1px;
}
</style>
</head>

<body>
	<div id="contents">

		<!-- タイトル部分 -->
		<div id="link-title">
			<h1 id="link-line">JackWorks登録</h1>
		</div>

		<!-- 入力された今月のJackWorksのデータを送るフォーム -->
		<form action="<%=request.getContextPath()%>/jackworksRegister">
		
		<% if(cmd.equals("")){ %>

			<!-- 入力フォーム -->
			<table id="box-mar">
				<tr>
					<td style="display: flex">ポイント取得日
						<div class="warning">*</div>
					</td>
				</tr>
					<td><input type="text" name="date" value="" size="35" required></td>
				<tr>
					<td style="display: flex">社員No
						<div class="warning">*</div>
					</td>
				</tr>
					<td><input type="text" name="employeeNumber" value="" size="35" required></td>
				<tr>
					<td style="display: flex">氏名
						<div class="warning">*</div>
					</td>
				</tr>
					<td><input type="text" name="name" value="" size="35" required></td>
				<tr>
					<td style="display: flex">カテゴリ
						<div class="warning">*</div>
					</td>
				</tr>
					<td><input type="text" name="category" value="" size="35" required></td>
				<tr>
					<td style="display: flex">評価項目
						<div class="warning">*</div>
					</td>
				</tr>
					<td><textarea name="assessment" rows="" cols="" required></textarea></td>
				<tr>
					<td style="display: flex">付与ポイント
						<div class="warning">*</div>
					</td>
				</tr>
					<td><input type="text" name="point" value="" size="35" required></td>
				<tr>
					<td style="display: flex">備考</td>
				</tr>
					<td><textarea name="note" rows="" cols=""></textarea></td>
				<tr>
			</table>
			
			<br>
				
				<!-- 登録ボタン -->
				<div id="JackWorks-submit">
					<button type="submit" class="btn btn-border">
					<input type="hidden" name="cmd" value="next">
						<span>次へ</span>
					</button>
				</div>
		</form>
				<% } %>
				
				<!-- 2ページ目 -->
				<% if(cmd.equals("next")){ %>
				
				<!-- 入力された今月のJackWorksのデータを送るフォーム -->
				<form action="<%=request.getContextPath()%>/jackworksRegister">
				
				<!-- 入力フォーム -->
				<table id="box-mar">
					<td>案件名
					<div class="warning">*</div>
					</td>
				</tr>
					<td><input type="text" name="project" value="" size="35"></td>
				<tr>
					<td>作業時期
					<div class="warning">*</div>
					</td>
				</tr>
					<td><input type="text" name="workSeason" value="" size="35"></td>
				<tr>
					<td>単価
					<div class="warning">*</div>
					</td>
				</tr>
					<td><input type="text" name="price" value="" size="35"></td>
				<tr>
					<td>精算
					<div class="warning">*</div>
					</td>
				</tr>
					<td><input type="text" name="pay" value="" size="35"></td>
				<tr>
					<td>作業場所
					<div class="warning">*</div>
					</td>
				</tr>
					<td><input type="text" name="workPlace" value="" size="35"></td>
				<tr>
					<td>作業内容
					<div class="warning">*</div>
					</td>
				</tr>
					<td><textarea name="workContent" rows="" cols=""></textarea></td>
				<tr>
					<td>フェーズ</td>
				</tr>
					<td><textarea name="phase" rows="" cols=""></textarea></td>
				<tr>
					<td>開発言語</td>
				</tr>
					<td><textarea name="language" rows="" cols=""></textarea></td>
				<tr>
					<td>必要スキル</td>
				</tr>
					<td><textarea name="skill" rows="" cols=""></textarea></td>
				<tr>
					<td>必要人数</td>
				</tr>
					<td><input type="text" name="needPeople" value="" size="35"></td>
				<tr>
					<td>営業担当者</td>
				</tr>
					<td><input type="text" name="seller" value="" size="35"></td>
				<tr>
					<td>連絡先</td>
				</tr>
					<td><textarea name="contact" rows="" cols=""></textarea></td>
				<tr>
					<td>その他</td>
				</tr>
					<td><textarea name="other" rows="" cols=""></textarea></td>
			</table>

			<br>

			<!-- 登録ボタン -->
			<div id="JackWorks-submit">
				<button type="submit" class="btn btn-border">
				<input type="hidden" name="cmd" value="register">
					<span>登録</span>
				</button>
			</div>
			</form>
			
			<% } %>
	</div>
</body>
</html>