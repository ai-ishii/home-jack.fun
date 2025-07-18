<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="bean.Announce"%>

<%
Announce announce = (Announce) request.getAttribute("announce");
int categoryId = announce.getAnnounceCategoryId();
%>

<html>
<head>
<!-- タイトル -->
<title>お知らせ</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<script src="<%=request.getContextPath()%>/js/script.js"></script>
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

.tiny_form {
	width: 30%;
}

.selector-for-some-widget {
	box-sizing: content-box;
}

.control_label {
	display: inline-block;
	margin-bottom: 0.5rem;
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
}

textarea {
	resize: vertical;
	width: 100%;
	height: 200px;
	border-radius: 5px;
	border: 1px solid #ccc;
}

input[type="submit"], input[type="button"] {
	margin: 10px;
}
</style>

<body>
	<div id="wrap">
		<!-- ヘッダー部分 -->
		<%@ include file="../common/header.jsp"%>

		<!-- メイン部分 -->
		<div id="main" class="container">
			<form action="<%=request.getContextPath()%>/announceUpdate" method="post"
				class="container">
				<div id="content_box">

					<div class="form_box" class="container">
						<label for="title" class="control_label">タイトル</label> <input
							type="text" id="title" name="title"
							value="<%=announce.getTitle()%>">
					</div>

					<div class="form_box tiny_form">
						<label for="updateDate" class="control_label">編集日時</label> <input
							type="datetime-local" id="updateDate" name="updateDate"
							value="<%=announce.getRegistDate()%>"/>
					</div>

					<div class="form_box tiny_form">
						<label for="category" class="control_label">カテゴリ</label> <select
							id="category" name="category">
							<option <%if (categoryId == 1) {%> selected>お知らせ<%
							}
							%>
							</option>
							<option <%if (categoryId == 2) {%> selected>チーム活動<%
							}
							%>
							</option>
							<option <%if (categoryId == 3) {%> selected>ナレッジベース<%
							}
							%>
							</option>
						</select>
					</div>

					<div class="form_box">
						<label for="announce_flag" class="control_label">重要記事</label> <input
							type="checkbox" name="announce_flag" value="2">
					</div>

					<div class="form_box">
						<label for="text" class="control_label">本文</label>
						<textarea id="text" name="text" rows="5" cols="15"><%=announce.getText()%></textarea>

					</div>

					<div class="form_box">
						<label for="tag" class="control_label">タグ</label> <input
							type="text" id="title" name="tag">
					</div>
					
					<input type="hidden" name="announceId" value="<%= announce.getAnnounceId() %>">

					<div class="btm_box">
						<input
							onclick="location.href='<%=request.getContextPath()%>/detailAnnounce?announceId=<%=announce.getAnnounceId()%>&cmd=detail'"
							type="button" value="キャンセル"> <input type="submit"
							value="一時保存"> <input type="submit" value="編集確定">
					</div>
				</div>
			</form>
		</div>
	</div>
</body>