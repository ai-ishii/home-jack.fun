<%@page contentType="text/html; charset=UTF-8"%>

<html>
<head>
<!-- タイトル -->
<title>お知らせ</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
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
			<form action="<%=request.getContextPath()%>/announceRegister"
				method="post" class="container">
				<div id="content_box">

					<div class="form_box">
						<label for="title" class="control_label">タイトル</label> <input
							type="text" id="title" name="title">
					</div>

					<div class="form_box tiny_form">
						<label for="registDate" class="control_label">投稿日時</label>
						<input id="registDate" type="datetime-local" name="registDate" />
					</div>

					<div class="form_box tiny_form">
						<label for="category" class="control_label">カテゴリ</label> <select
							id="category" name="categoryId">
							<option value="1">お知らせ</option>
							<option value="2">チーム活動</option>
							<option value="3">ナレッジベース</option>
							<option value="9">その他</option>
						</select>
					</div>

					<div class="form_box">
						<label for="announce_flag" class="control_label">重要記事</label> <input
							type="checkbox" id="announce_flag" value="2">
					</div>

					<div class="form_box">
						<label for="text" class="control_label">本文</label>
						<textarea id="text" name="text"></textarea>
					</div>

					<div class="form_box">
						<label for="tag" class="control_label">タグ</label> <input
							type="text" id="tag" name="tag">
					</div>

					<div class="btm_box">
						<input
							onclick="location.href='<%=request.getContextPath()%>/announce'"
							type="button" value="キャンセル"> <input type="submit"
							value="一時保存"> <input type="submit" value="登録確定">
					</div>
				</div>
			</form>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js"></script>

</body>
</html>