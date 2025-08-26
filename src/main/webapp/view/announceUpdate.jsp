<!-- 
お知らせを編集するjsp

作成者 : 大北直弥

作成日 : 2025/07/14
更新日 : 2025/08/25
 -->
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="bean.Announce"%>

<%
Announce announce = (Announce) request.getAttribute("announce");
int categoryId = announce.getAnnounceCategoryId();
%>

<html>
<head>
<!-- タイトル -->
<title>お知らせ編集 | Home-Jack</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<script src="<%=request.getContextPath()%>/js/script.js"></script>
<script src="<%=request.getContextPath()%>/js/error.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<style>
#content_box {
	display: flex;
	flex-direction: column;
	justify-content: center;
	width: 80%;
	min-height: 300px;
	margin: 50px auto;
	justify-content: center;
}

.form_box {
	display: flex;
	flex-direction: column;
	align-items: flex-start;
	margin-bottom: 1rem;
}

/* フォームの中の重要記事チェックにだけ適用（div） */
.form_box.check {
	display: flex;
	flex-direction: row;
	align-items: baseline;
}

.tiny_form {
	width: 30%;
}

.selector-for-some-widget {
	box-sizing: content-box;
}

.control_label {
	display: inline-block;
	margin-right: 10px;
	margin-bottom: 0.5rem;
	font-size: 18px;
}

.btm_box {
	display: flex;
	justify-content: center;
}

input[type="text"], select {
	width: 100%;
	height: calc(1.5em + 0.75rem + 2px);
	border-radius: 5px;
	border: 1px solid #ccc;
}

input[type="checkbox"] {
	transform: scale(1.5);
	vertical-align: bottom;
	accent-color: chocolate;
}

textarea {
	width: 100%;
	height: 200px;
	overflow-y: scroll;
	resize: none;
	line-height: 1.5;
}

input[type="submit"], input[type="button"] {
	margin: 10px;
}

.error, .warning {
	color: red;
}

/* 削除ボタン */
.buttonArea {
	width: 90%;
	height: 20px;
	padding-top: 10px;
	text-align: right;
}

a.btn--delete {
	color: #000;
	background-color: #bbc8e6;
	border-bottom: 5px solid #8491c3;
}

a.btn--delete:hover {
	margin-top: 3px;
	color: #000;
	background: #706caa;
	border-bottom: 2px solid #4a488e;
}

/* aタグの初期CSSのリセット(左) */
.jackResetL {
	text-decoration: none;
	color: #000;
}

/* 矢印の枠 */
/* marginとかは自分で削ったり足したりしてくださいな */
.yoruArrow {
	align-items: center;
	height: 30px;
	width: 85%;
	margin: 30px auto 0;
}

/* 矢印 */
.arrow {
	display: inline-block;
	vertical-align: middle;
	transition: transform 0.5s ease;
	overflow: visible; /* はみ出た内容を表示させる */
}

/* 矢印文字 */
.beaf {
	height: 100%;
	font-family: "Yomogi", cursive;
	font-size: 25px;
}

/* 矢印ホバー時の動き(左) */
.jackResetL:hover svg path {
	transform: translateX(-10px);
	stroke: #f9de95;
	fill: #f9de95;
}

/* 登録ボタンの配置 */
#submitBtn {
	text-align: center;
	margin: 5px;
}

.btn, a.btn, button.btn {
	-webkit-box-sizing: border-box;
	box-sizing: border-box;
	font-size: 1.0rem;
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
	border-radius: 8.5rem;
	border: none;
}

button.btn-border {
	-webkit-box-sizing: border-box;
	box-sizing: border-box;
	padding: 0;
	-webkit-transition: all 0.3s;
	transition: all 0.3s;
	border-radius: 0;
	margin-bottom: 12px;
}

button.btn-border span {
	position: relative;
	display: block;
	padding: 0.6rem 1.8rem;
	color: #000;
	border: 2px solid #5f5f5f;
	border-radius: 0.5rem;
	background: #ffe0c1;
}

button.btn-border.save span {
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
	border: 2px solid #5f5f5f;
	border-top: 1px solid #5f5f5f;
	border-radius: 0 0 0.5rem 0.5rem;
	background-image: -webkit-repeating-linear-gradient(135deg, #000, #000 1px, transparent
		2px, transparent 5px);
	background-image: repeating-linear-gradient(-45deg, #5f5f5f, #5f5f5f 1px, transparent 2px,
		transparent 5px);
	background-size: 7px 7px;
	-webkit-backface-visibility: hidden;
	backface-visibility: hidden;
	background-color: #ffefe0;
}

button.btn-border.save:before {
	background-color: whitesmoke;
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

.links {
	width: 100%;
}

.cancel {
	width: 40%;
}

.submit {
	display: flex;
	justify-content: flex-end;
	padding-top: 20px;
	padding-right: 10px;
}
</style>

<body>
	<div id="wrap">
		<!-- ヘッダー部分 -->
		<%@ include file="../common/header.jsp"%>

		<!-- メイン部分 -->
		<div id="main" class="container">
			<!-- 削除ボタン -->
			<div class="buttonArea">
				<a class="btn btn--delete"
					href="<%=request.getContextPath()%>/announceDelete?announceId=<%=announce.getAnnounceId()%>"
					onclick="return confirm('本当に削除しますか？')">削除</a>
			</div>
			<form action="<%=request.getContextPath()%>/announceUpdate"
				method="post" class="container error-form">
				<div id="content_box">

					<div class="form_box" class="container">
						<label for="title" class="control_label">タイトル<span
							class="warning">*</span></label> <input type="text" id="title"
							name="title" data-maxlength="50" value="<%=announce.getTitle()%>" class='error-check-default error-check-digit'>
					</div>

					<!-- <div class="form_box tiny_form">
						<label for="update_date" class="control_label">編集日時<span
							class="warning">*</span></label> <input type="datetime-local"
							id="update_date" name="update_date" max="9999-12-31 23:59"
							value="%=announce.getRegistDate()%" class="error-check-date">
					</div> -->

					<div class="form_box tiny_form">
						<label for="category" class="control_label">カテゴリ<span
							class="warning">*</span></label> <select id="category" name="category_id">

							<option value="1" <%if (categoryId == 1) {%> selected <%}%>>
								お知らせ</option>

							<option value="2" <%if (categoryId == 2) {%> selected <%}%>>
								チーム活動</option>

							<option value="3" <%if (categoryId == 3) {%> selected <%}%>>
								ナレッジベース</option>

							<option value="9" <%if (categoryId == 9) {%> selected <%}%>>
								その他</option>

						</select>
					</div>

					<div class="form_box check">
						<label for="announce_flag" class="control_label">重要記事</label>
						<input type="checkbox"
							name="announce_flag" value="1"> <input type="hidden"
							name="announce_flag" value="0">
					</div>

					<div class="form_box">
						<label for="text" class="control_label">本文<span
							class="warning">*</span></label>
						<textarea id="text" name="text" rows="5" cols="15"
							class='error-check-default'><%=announce.getText()%></textarea>
					</div>

					<div class="form_box">
						<label for="tag" class="control_label">タグ</label> <input
							type="text" id="title" name="tag" class="convert-full-to-half">
					</div>

					<input type="hidden" name="announce_id"
						value="<%=announce.getAnnounceId()%>">
						
					<input type="hidden" name="update_date"
						value="<%=announce.getUpdateDate()%>">

					<!-- 
					<div class="btm_box">
						<input onclick="location.href='<%=request.getContextPath()%>/announceDetail?announceId=<%=announce.getAnnounceId()%>&cmd=detail'"
							type="button" value="キャンセル"> 
						<input type="submit" value="一時保存"> 
						<input type="submit" value="編集確定">
					</div>
					<div>
					<a href="<%=request.getContextPath()%>/announceDelete?announceId=<%=announce.getAnnounceId()%>"
					onclick="return confirm('本当に削除しますか？')">削除</a>
					</div>
					 -->

					<table class="links">
						<tr>
							<td class="cancel">
								<div class="yoruArrow">
									<a href="<%=request.getContextPath()%>/announce"
										class="jackResetL"> <svg class="arrow" width="50"
											height="20">
			<path d="M 0 10 L 50 10" stroke="#000" stroke-width="2" fill="none" />
			<path d="M 0 10 L 25 0" stroke="#000" stroke-width="2" fill="none" />
		</svg> <span class="beaf">CANCEL</span>
									</a>
								</div>
							</td>
							<td class="submit">
								<!-- 登録ボタン -->
								<div id="submitBtn">
									<button type="submit" class="btn btn-border save">
										<span>一時保存</span>
									</button>
								</div>
								<div id="submitBtn">
									<button type="submit" class="btn btn-border">
										<span>完了</span>
									</button>
								</div>
								</form>
							</td>
						</tr>
					</table>
				</div>
			</form>
		</div>
	</div>
</body>