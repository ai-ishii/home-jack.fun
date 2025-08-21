<!-- 社員紹介 登録機能（作：占部） -->
<!-- 作成日：8/7　最終更新日：8/21 9:15 -->
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.time.LocalDateTime,java.util.Date,java.sql.Timestamp"%>

<html>
<head>
<!-- タイトル -->
<title>個人情報登録 | Home-Jack</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<script src="<%=request.getContextPath()%>/js/script.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<style>
html {
	-webkit-box-sizing: border-box;
	box-sizing: border-box;
	font-size: 62.5%;
}

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

#box-mar {
	margin: 0 auto;
}

/* 米印の色 */
.warning {
	color: red;
}

/* 登録ボタンの配置 */
#JackWorks-submit {
	text-align: center;
}

/* 登録ボタンのデザイン */
*, *:before, *:after {
	-webkit-box-sizing: inherit;
	box-sizing: inherit;
}

.btn, a.btn, button.btn {
	font-size: 20px;
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

.selectbox-3 {
	display: inline-flex;
	align-items: center;
	position: relative;
}

/*電話番号のCSSですぅ*/
.phone-input-group {
	display: flex;
	align-items: center;
}

.phone-input-group input {
	width: 60px;
	text-align: center;
}

.phone-input-group span {
	margin: 0 5px;
}
</style>

<body>
	<div id="wrap">
		<!-- ヘッダー部分 -->

		<form class="h-adr"
			action="<%=request.getContextPath()%>/userRegister" method="post">
			<span class="p-country-name" style="display: none;">Japan</span>
			<%@ include file="../common/header.jsp"%>

			<!-- メイン部分 -->
			<div id="main" class="container">
				<div id="contents">
					<div id="link-title">
						<h1 id="link-line">個人情報登録</h1>
					</div>


					<%
					//現在の日時を取得
					LocalDateTime nowDate = LocalDateTime.now();
					Timestamp date = Timestamp.valueOf(nowDate);
					%>

					<table id="box-mar">
						<input type="hidden" name="date" value=<%=date%>>
						<tr>
							<td style="display: flex">社員番号
								<div class="warning">*</div>
							</td>
						</tr>
						<tr>
							<td><input type="text" name="employeeNumber"
								placeholder="123456" required></td>
						</tr>

						<tr>
							<td style="display: flex">所属 <label class="selectbox-3">
									<select name="department">
										<option value="">--選択してください--</option>
										<option value="1">BS事業部第1部</option>
										<option value="2">BS事業部第2部</option>
										<option value="3">営業部</option>
										<option value="4">NEXTINOVATION部</option>
										<option value="5">経営管理部</option>
								</select>
							</label>
							</td>
						</tr>
						<tr>
						</tr>
						<tr>
							<td style="display: flex">グループ <label class="selectbox-3">
									<select name="group">
										<option value="">--選択してください--</option>
										<option value="1">第1グループ</option>
										<option value="2">第2グループ</option>
										<option value="3">第3グループ</option>
										<option value="4">第4グループ</option>
										<option value="5">第5グループ</option>
								</select>
							</label>
							</td>
						</tr>
						<tr>
						</tr>
						<tr>
							<td style="display: flex">お名前
								<div class="warning">*</div>
							</td>
						</tr>
						<tr>
							<td><input type="text" name="name" placeholder="山田太郎"
								value="<%=user_name%>" required></td>
						</tr>
						<tr>
							<td style="display: flex">ふりがな
								<div class="warning">*</div>
							</td>
						</tr>
						<tr>
							<td><input type="text" name="nameKana" placeholder="やまだたろう"
								required></td>
						</tr>
						<tr>
							<td style="display: flex">生年月日
								<div class="warning">*</div>
							</td>
						</tr>
						<tr>
							<td><input type="date" name="birthday"
								placeholder="2003年01月01日" required></td>
						</tr>
						<tr>
							<td style="display: flex">性別
								<div class="warning">*</div>
							</td>
						</tr>
						<tr>
							<td><label class="selectbox-3"> <select name="sex">
										<option value="男">男</option>
										<option value="女">女</option>
										<option value="その他">その他</option>
								</select>
							</label></td>
						</tr>
						<tr>
							<td style="display: flex">電話番号
								<div class="warning">*</div>
							</td>
						</tr>
						<tr>
							<td>
								<div class="phone-input-group">
									<input type="text" name="phone1" placeholder="000" required>
									- <input type="text" name="phone2" placeholder="1234" required>
									- <input type="text" name="phone3" placeholder="1234" required>
								</div>
							</td>
						</tr>
						<tr>
							<td>郵便番号<span class="warning">*(ハイフン不要)</span></td>
							<td><input type="text" name="post" class="p-postal-code"
								placeholder="例: 1000001" required></td>
						</tr>
						<tr>
							<td>住所<span class="warning">*</span></td>
							<td>
								<div>
									<label for="pref">都道府県:</label> <input type="text" id="pref"
										name="prefecture" class="p-region" readonly>
								</div>
								<div style="margin-top: 10px;">
									<label for="address">市区町村:</label> <input type="text"
										id="address" name="address"
										class="p-locality p-street-address p-extended-address"
										placeholder="例: 大阪府大阪市阿倍野区阿倍野筋" required>
								<div>
									<label for="pref">番地:</label> <input type="text" id="pref"
										name="street-address" placeholder="1-1-43" >
								</div>
								<div>
									<label for="pref">建物名・部屋番号:</label> <input type="text" id="pref"
										name="build" placeholder="あべのハルカス16階" >
								</div>
						<tr>
							<td style="display: flex">婚姻状況
								<div class="warning">*</div>
							</td>
						</tr>
						<tr>
							<td><input type="radio" name="marriage" value="0" checked>未婚
								<input type="radio" name="marriage" value="1">既婚</td>
						</tr>
						<tr>
							<td>子供</td>
						</tr>
						<tr>
							<td><input type="text" name="children" placeholder="2"></td>
						</tr>
						<tr>
							<td style="display: flex">入社年月
								<div class="warning">*</div>
							</td>
						</tr>
						<tr>
							<td><input type="date" name="joiningDate" placeholder="2025"
								required></td>
						</tr>
						<tr>
							<!-- なくてもいいのではないかと考えています -->
							<td style="display: flex">勤務年数
								<div class="warning">*</div>
							</td>
						</tr>
						<tr>
							<td><input type="text" name="workyear" placeholder="3"
								required></td>
						</tr>
						<tr>
							<td style="display: flex">最寄り駅
								<div class="warning">*</div>
							</td>
						</tr>
						<tr>
							<td><input type="text" name="station" placeholder="目梨駅"
								required></td>
						</tr>
						<tr>
							<td style="display: flex">交通手段
								<div class="warning">*</div>
							</td>
						</tr>
						<tr>
							<td><input type="text" name="transportation"
								placeholder="電車" required></td>
						</tr>
						<tr>
							<td>資格</td>
						</tr>
						<tr>
							<td><input type="text" name="qualification"
								placeholder="英検2級 色彩検定"></td>
						</tr>
						<tr>
							<td>
								<!-- 登録ボタン -->
								<div id="JackWorks-submit">
									<button type="submit" class="btn btn-border">
										<span>登録</span>
									</button>
								</div>
							</td>
						</tr>
						</form>
						</form>
					</table>
				</div>
			</div>
	</div>
	<script src="https://yubinbango.github.io/yubinbango/yubinbango.js"
		charset="UTF-8"></script>
</body>
</html>