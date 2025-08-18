<%--
機能：氏名変更の申請フォーム
 
制作者：桑原岳

最終更新日：2025/08/14
 --%>


<%@page contentType="text/html; charset=UTF-8"%>
<%
String errorMessage = (String) request.getAttribute("errorMessage");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>資格申請フォーム</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<script src="<%=request.getContextPath()%>/js/script.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<c:set var="formValues"
	value="${not empty userInput ? userInput : param}" />
<style>
.form-wrapper-container {
	display: flex;
	justify-content: center;
	align-items: flex-start;
	padding: 30px;
	gap: 40px;
}

.form-wrapper {
	flex: 1;
	max-width: 800px;
	padding: 30px;
	border: 1px solid #ccc;
	border-radius: 10px;
	background-color: #f9f9f9;
	position: relative;
}

.instruction-box {
	display: none;
	flex: 1;
	max-width: 500px;
	padding: 30px;
	background-color: #fff3e0;
	border-left: 4px solid #ffb74d;
	border-radius: 10px;
}

.form-row {
	width: 80%;
	margin: 0 auto 15px;
	display: flex;
	align-items: flex-start;
}

.form-label {
	width: 180px;
	padding-right: 20px;
	text-align: center;
	font-weight: bold;
	flex-shrink: 0;
}

.form-input input[type="text"], .form-input-date input[type="date"] {
	width: 250px;
	font-size: 18px;
	padding: 5px;
}

.form-input-address textarea {
	width: 300px;
	height: 100px;
	resize: none;
}

select {
	height: 30px;
}

.form-link {
	width: 80%;
	margin: 20px auto 0;
	text-align: right;
}

.instruction-box h3 {
	margin-bottom: 15px;
}

.required {
	color: #dc3545;
	font-weight: bold;
}

.error-field {
	border: 2px solid red !important;
}

.form-cautionary-note {
	/* 他の行と全体の幅・中央揃え・下の余白を合わせる */
	width: 80%;
	margin: 0 auto 15px;
	padding-left: 200px;
	box-sizing: border-box;
}

.form-cautionary-note h4 {
	margin: 0;
	padding-top: 5px; /* 他の入力欄の文字の高さと合わせる */
	font-size: 14px;
	font-weight: normal;
	color: #555;
	line-height: 1.5;
}

/* フォームを横に並べるためのスタイル */
.button-area form {
	display: inline-block;
	margin: 0 10px;
}
/*申請ボタンのデザインをお願いします*/
.application-button {
	text-align: center;
	padding: 30px;
}

.help-container {
	/* 位置指定をこちらに移動 */
	position: absolute;
	top: 25px;
	right: 25px;
	z-index: 10;
	/* 中の文字とボタンを横並びにする */
	display: flex;
	align-items: center;
	gap: 5px; /* 文字とボタンの間隔 */
}

#helpBtn {
	width: 36px;
	height: 36px;
	font-size: 20px;
	border-radius: 50%;
	background-color: #007bff;
	color: white;
	font-weight: bold;
	border: none;
	padding: 0;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
	transition: all 0.3s ease;
	display: inline-flex;
	justify-content: center;
	align-items: center;
}

#helpBtn:hover {
	background-color: #0056b3;
	transform: scale(1.1);
}

#helpBtn.close {
	background-color: #dc3545;
}

#helpBtn.close:hover {
	background-color: #c82333;
}
</style>
</head>

<body>
	<div id="wrap">
		<%@ include file="../common/header.jsp"%>
		<div id="main" class="container">
			<div class="form-wrapper-container">
				<div class="form-wrapper">
					<div class="help-container">
						<span>手順がわからない方へ</span>
						<button type="button" id="helpBtn">?</button>
					</div>
					<h1 style="text-align: center">-資格変更申請フォーム-</h1>
					<form id="sendform"
						action="<%=request.getContextPath()%>/licenseConfirm"
						method="post" enctype="multipart/form-data">

						<c:if test="${not empty errorMessage}">
							<h2 style="color: red; text-align: center;">${errorMessage}</h2>
						</c:if>

						<div class="form-row">
							<div class="form-label">
								<label for="name">氏名<span class="required">【必須】</span></label>
							</div>
							<div class="form-input">
								<input type="text" id="name" name="name"
									class="${errors['name_error'] ? 'error-field' : ''}"
									value="${formValues['name']}" />
							</div>
						</div>

						<div class="form-row">
							<div class="form-label">
								<label for="department">部署名<span class="required">【必須】</span></label>
							</div>
							<div class="form-select">
								<select name="department" size="1"class="${errors.department_error ? 'error-field' : ''}">
									<option value="">--部を選択してください--</option>
									<option value="BS0001">BS事業部第1部</option>
									<option value="BS0002">BS事業部第2部</option>
									<option value="SA0099">営業部</option>
									<option value="NX0100">NEXTINOVATION</option>
									<option value="MG0101">経営管理部</option>
								</select>
							</div>
						</div>
						<div class="form-row">
							<div class="form-label">
								<label for="group">グループ名<span class="required">【必須】</span></label>
							</div>
							<div class="form-select">
								<select name="group" size="1"class="${errors.group_error ? 'error-field' : ''}">
									<option value="">--グループを選択してください--</option>
									<option value="GR0000"></option>
									<option value="GR0001">第1グループ</option>
									<option value="GR0002">第2グループ</option>
									<option value="GR0003">第3グループ</option>
									<option value="GR0004">第4グループ</option>
								</select>
							</div>
						</div>
						<div class="form-row">
							<div class="form-label">
								<label for="license">資格名<span class="required">【必須】</span></label>
							</div>
							<div class="form-select">
								<select name="license" size="1"class="${errors.license_error ? 'error-field' : ''}">
									<option value="">--資格を選択してください--</option>
									<option value="AIL001">G検定</option>
									<option value="JAV001">Oracle認定Javaプログラマ(Silver)</option>
									<option value="JAV002">Oracle認定Javaプログラマ (Gold)</option>
									<option value="PYN001">Python3 エンジニア認定基礎試験</option>
									<option value="PYN002">Python3 エンジニア認定実践試験</option>
									<option value="PYN003">Python3 エンジニア認定データ分析試験</option>
									<option value="AWS001">AWS 認定クラウドプラクティショナー</option>
									<option value="AWS002">AWS 認定デベロッパー アソシエイト</option>
									<option value="IPA001">基本情報技術者試験</option>
									<option value="IPA002">応用情報技術者試験</option>
									<option value="IPA003">スペシャリスト試験データベース</option>
									<option value="IPA004">スペシャリスト試験_ネットワーク</option>
									<option value="IPA005">スペシャリスト試験_エンベデッドシステム</option>
									<option value="IPA006">プロジェクトマネージャ</option>
									<option value="IPA007">システムアーキテクト</option>
									<option value="IPA008">ITストラテジスト</option>
									<option value="IPA009">ITサービスマネージャ</option>
									<option value="IPA010">システム監査技術者</option>
									<option value="IPA011">ITパスポート</option>
								</select>
							</div>
						</div>
						<div class="form-row">
							<div class="form-label">
								<label for="exam-date">受験日<span class="required">【必須】</span></label>
							</div>
							<div class="form-input">
								<input type="date" id="exam-date" name="exam-date"
									class="${errors['exam-date_error'] ? 'error-field' : ''}"
									value="${formValues['exam-date']}" />
							</div>
						</div>
						<div class="form-row">
							<div class="form-label">
								<label for="exam-time">受験回数<span class="required">【必須】</span></label>
							</div>
							<div class="form-input">
								<input type="text" id="exam-time" name="exam-time"
									class="${errors['exam-time_error'] ? 'error-field' : ''}"
									value="${formValues['exam-time']}" />
							</div>
						</div>

						<div class="form-row">
							<div class="form-label">
								<label for="receipt">受験料領収書<span class="required">【必須】</span></label>
							</div>
							<div class="form-input">
								<input type="file" name="receipt" required>
							</div>
						</div>
						<div class="form-cautionary-note">
							<h4>※受験料の支給については上長への経費申請も必要となります。</h4>
						</div>
						<div class="form-row">
							<div class="form-label">
								<label for="passing">合格証<span class="required">【必須】</span></label>
							</div>
							<div class="form-input">
								<input type="file" name="passing" required>
							</div>
						</div>

						<div class="application-button">
							<button type="submit">申請</button>
						</div>
				</div>
				</form>

				<div class="instruction-box">
					<h2>氏名変更申請フォーム手順</h2>
					<h3>1. 入力欄をすべて記入します（空欄があると再入力になります）。</h3>
					<h3>2. 入力後、「申請」ボタンを押して内容確認をします。</h3>
					<h3>3. 確認してよければ「この内容で確定する」ボタンを押します。</h3>

				</div>
			</div>


		</div>
	</div>
	</div>

	<script src="https://yubinbango.github.io/yubinbango/yubinbango.js"
		charset="UTF-8"></script>
	<script>
		function submitForm() {
			document.getElementById("sendform").submit();
		}
	</script>
	<script>
		document.getElementById("helpBtn").addEventListener(
				"click",
				function() {
					const instructionBox = document
							.querySelector(".instruction-box");
					if (instructionBox.style.display === "none"
							|| instructionBox.style.display === "") {
						instructionBox.style.display = "block";
						this.textContent = "×";
						this.classList.add("close");
					} else {
						instructionBox.style.display = "none";
						this.textContent = "?";
						this.classList.remove("close");
					}
				});
	</script>
</body>
</html>