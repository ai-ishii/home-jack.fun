<%--
機能：住所変更の申請フォーム
 
制作者：桑原岳

最終更新日：2025/08/12
 --%>


<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="formValues"
	value="${not empty userInput ? userInput : param}" />

<html>
<head><input type="hidden" name="employeenumber" value="${employeeNumber}">
<input type="hidden" name="name" value="${name}">
<input type="hidden" name="addressChangedDate" value="${addressChangedDate}">
<input type="hidden" name="oldpost" value="${oldPost}">
<input type="hidden" name="oldaddress" value="${oldAddress}">
<input type="hidden" name="newpost" value="${newPost}">
<input type="hidden" name="newaddress" value="${newAddress}">
<input type="hidden" name="neareststation" value="${nearestStation}">
<title>住所変更申請フォーム</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<script src="<%=request.getContextPath()%>/js/script.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
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

.form-link {
	width: 80%;
	margin: 20px auto 0;
	text-align: right;
}

.required {
	color: #dc3545;
	font-weight: bold;
}

.error-field {
	border: 2px solid red !important;
}

.instruction-box h3 {
	margin-bottom: 15px;
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
	cursor: pointer; /* エリア全体をクリックできるように見せる */
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
					<h1 style="text-align: center">-住所変更申請フォーム-</h1>

					<form id="sendform"
						action="<%=request.getContextPath()%>/addressChangeConfirm"
						method="post">

						<c:if test="${not empty errorMessage}">
							<h2 style="color: red; text-align: center;">${errorMessage}</h2>
						</c:if>

						<div class="form-row">
							<div class="form-label">
								<label for="employeenumber">社員番号</label>
							</div>
							<div class="form-input">
								<input type="text" id="employeenumber" name="employeenumber"
									class="${errors.employeeNumber_error ? 'error-field' : ''}"
									value="${formValues.employeenumber}" placeholder="例：000001" />
							</div>
						</div>

						<div class="form-row">
							<div class="form-label">
								<label for="name">氏名</label>
							</div>
							<div class="form-input">
								<input type="text" id="name" name="name"
									class="${errors.name_error ? 'error-field' : ''}"
									value="${formValues.name}" />
							</div>
						</div>

						<div class="form-row">
							<div class="form-label">
								<label for="changedate">住所変更日時<span class="required">【必須】</span></label>
							</div>
							<div class="form-input-date">
								<input type="date" id="addressChangedDate"
									name="addressChangedDate"
									class="${errors.addressChangedDate_error ? 'error-field' : ''}"
									value="${formValues.addressChangedDate}"
									placeholder="例：2025/01/01" />
							</div>
						</div>

						<div class="h-adr">
							<span class="p-country-name" style="display: none;">Japan</span>
							<div class="form-row">
								<div class="form-label">
									<label for="oldpost">旧郵便番号</label>
								</div>
								<div class="form-input">
									<input type="text" id="oldpost" name="oldpost"
										class="p-postal-code ${errors.oldPost_error ? 'error-field' : ''}"
										value="${formValues.oldpost}" />
								</div>
							</div>
							<div class="form-row">
								<div class="form-label">
									<label for="oldaddress">旧住所</label>
								</div>
								<div class="form-input-address">
									<textarea name="oldaddress" cols="30" rows="5"
										class="p-region p-locality p-street-address p-extended-address ${errors.oldAddress_error ? 'error-field' : ''}">${formValues.oldaddress}</textarea>
								</div>
							</div>
						</div>

						<div class="h-adr">
							<span class="p-country-name" style="display: none;">Japan</span>
							<div class="form-row">
								<div class="form-label">
									<label for="newpost">新郵便番号<span class="required">【必須】</span></label>
								</div>
								<div class="form-input">
									<input type="text" id="newpost" name="newpost"
										placeholder="例：1000001"
										class="p-postal-code ${errors.newPost_error ? 'error-field' : ''}"
										value="${formValues.newpost}" /> ※ -は記入しない
								</div>
							</div>
							<div class="form-row">
								<div class="form-label">
									<label for="newaddress">新住所<span class="required">【必須】</span></label>
								</div>
								<div class="form-input-address">
									<textarea id="newaddress" name="newaddress" cols="30" rows="5"
										placeholder="例： 大阪府大阪市淀川区西中島５丁目１１−３ 新大阪サンアールビル西館"
										class="p-region p-locality p-street-address p-extended-address ${errors.newAddress_error ? 'error-field' : ''}">${formValues.newaddress}</textarea>
								</div>
							</div>
							<div class="form-row">
								<div class="form-label">
									<label for="neareststation">新住所最寄り駅<span
										class="required">【必須】</span></label>
								</div>
								<div class="form-input">
									<input type="text" id="neareststation" name="neareststation"
										class="${errors.nearestStation_error ? 'error-field' : ''}"
										value="${formValues.neareststation}" placeholder="例：JR大阪駅" />
								</div>
							</div>
							<div class="form-link">
								<a href="#" onclick="submitForm()">住所変更届はこちら⇀</a>
							</div>
							<div class="form-link">
								<a
									href="<%=request.getContextPath()%>/view/addressChangeForm.jsp">画像アップロードはこちら⇀</a>
							</div>
						</div>
					</form>
					<div class="help-container">
						<span>手順がわからない方へ</span>
						<button type="button" id="helpBtn">?</button>
					</div>
				</div>

				<div class="instruction-box">
					<h2>住所変更申請フォーム手順</h2>
					<h3>1. 入力欄をすべて記入します（空欄があると再入力になります）。</h3>
					<h3>2. 入力後、「住所変更届はこちら」を押して送信します。</h3>
					<h3>3. ダウンロードされたExcelに内容が反映されているか確認します。</h3>
					<h3>4. 確認後、印刷して押印してください。</h3>
					<h3>5. 押印済の変更届と証明書類を「画像アップロードはこちら」から提出してください。</h3>
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
