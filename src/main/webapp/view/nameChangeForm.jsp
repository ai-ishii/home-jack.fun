<%--
機能：氏名変更の申請フォーム
 
制作者：桑原岳

最終更新日：2025/08/07
 --%>


<%@page contentType="text/html; charset=UTF-8"%>
<%
String errorMessage = (String) request.getAttribute("errorMessage");
%>

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
	/* ▼この要素がボタン配置の「基準」となります */
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

#helpBtn {
	/* ▼absolute指定で、親の「基準」内で自由に配置されます */
	position: absolute;
	/* ▼基準となる枠の右上からの距離を指定 */
	top: 25px;
	right: 25px;
	z-index: 10;
	width: 36px;
	height: 36px;
	font-size: 20px;
	border-radius: 50%;
	background-color: #007bff;
	color: white;
	font-weight: bold;
	border: none;
	cursor: pointer;
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
					<h1 style="text-align: center">-氏名変更申請フォーム-</h1>

					<form id="sendform"
						action="<%=request.getContextPath()%>/addressChangeConfirm"
						method="post">
						<%
						if (errorMessage != null && !errorMessage.isEmpty()) {
						%>
						<h2 style="color: red; text-align: center;"><%=errorMessage%></h2>
						<%
						}
						%>

						<div class="form-row">
							<div class="form-label">
								<label for="name">旧氏名</label>
							</div>
							<div class="form-input">
								<input type="text" id="name" name="name" />
							</div>
						</div>

						<div class="form-row">
							<div class="form-label">
								<label for="name">旧氏名(かな)</label>
							</div>
							<div class="form-input">
								<input type="text" id="name" name="name" />
							</div>
						</div>

						<div class="form-row">
							<div class="form-label">
								<label for="name">新氏名</label>
							</div>
							<div class="form-input">
								<input type="text" id="name" name="name" />
							</div>
						</div>
						<div class="form-row">
							<div class="form-label">
								<label for="name">新氏名(かな)</label>
							</div>
							<div class="form-input">
								<input type="text" id="name" name="name" />
							</div>
						</div>
				</div>
				</form>

				<button type="button" id="helpBtn">?</button>
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