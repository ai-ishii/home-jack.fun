<%--
機能：氏名変更の申請フォーム
 
制作者：桑原岳

最終更新日：2025/08/26
 --%>


<%@page contentType="text/html; charset=UTF-8"%>
<%@ page import="bean.User"%>
<%
String errorMessage = (String) request.getAttribute("errorMessage");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="formValues"
	value="${not empty formValues ? formValues : param}" />
<html>
<head>
<title>氏名変更申請フォーム</title>
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
					<h1 style="text-align: center">-氏名変更申請フォーム-</h1>
					<form id="sendform"
						action="<%=request.getContextPath()%>/nameChangeConfirm"
						method="post">
						<c:if test="${not empty errorMessage}">
							<h2 style="color: red; text-align: center;">${errorMessage}</h2>
						</c:if>

						<c:set var="user" value="${sessionScope.userName}" />

						<div class="form-row">
							<div class="form-label">
								<label for="oldname">旧氏名</label>
							</div>
							<div class="form-input">
								<input type="text" id="oldname" name="oldname"
									class="${errors['oldname_error'] ? 'error-field' : ''}"
									value="${user.name}" readonly />
							</div>
						</div>

						<div class="form-row">
							<div class="form-label">
								<label for="oldnamekana">旧氏名(かな)</label>
							</div>
							<div class="form-input">
								<input type="text" id="oldnamekana" name="oldnamekana"
									class="${errors['oldnamekana_error'] ? 'error-field' : ''}"
									value="${user.nameKana}" readonly />
							</div>
						</div>

						<div class="form-row">
							<div class="form-label">
								<label for="newname">新氏名<span class="required">【必須】</span></label>
							</div>
							<div class="form-input">
								<input type="text" id="newname" name="newname"
									class="${errors['newname_error'] ? 'error-field' : ''}"
									value="${formValues['newname']}" />
							</div>
						</div>

						<div class="form-row">
							<div class="form-label">
								<label for="newnamekana">新氏名(かな)<span class="required">【必須】</span></label>
							</div>
							<div class="form-input">
								<input type="text" id="newnamekana" name="newnamekana"
									class="${errors['newnamekana_error'] ? 'error-field' : ''}"
									value="${formValues['newnamekana']}" />
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