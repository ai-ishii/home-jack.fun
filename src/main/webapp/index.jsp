<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- タイトル -->
<title>ログイン</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<script src="<%=request.getContextPath()%>/js/script.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>

<style>
/*
-----------------------------------------------------------------------------------
*/

.login {
	margin: 20px auto;
	padding: 50px 0;
	min-width:600px;
	width: 50%;
	height: 200px;
	border-radius: 20px;
	background-color: #ffffff;
	box-shadow: 0px 8px 10px 1px rgba(0, 0, 0, 0.15);
	box-shadow: 0px 3px 5px 2px rgba(0, 0, 0, 0.1);
	box-shadow: 0px 5px 5px -3px rgba(0, 0, 0, 0.2);
	text-align: center;
}

.center {
	margin: 0 auto;	
	text-align: center;
	width: 200px;
}

/*
-----------------------------------------------------------------------------------
*/
</style>

<body>
	<div id="wrap">
		<!-- ヘッダー部分 -->
		<%@ include file="../common/header.jsp"%>

		<!-- メイン部分 -->
		<div id="main" class="container">
			<div class="login">
				<h2>Googleアカウントでログイン</h2>
				<div class="center">
				<div id="g_id_onload"
					data-client_id="534918220824-ejk2iu9vqoh1oq6lpb5avgprak4hl05f.apps.googleusercontent.com"
					data-callback="handleCredentialResponse"></div>
				<div class="g_id_signin" data-type="standard"></div>
		
				<div id="status"></div>
				</div>
			</div>
			<div class="login">
				<h2>ダミーデータでログイン</h2>
				<form action="<%= request.getContextPath() %>/loginDammy" method="get">
				<input list="email-list" type="email" name="email">
					<datalist id="email-list">
						 <option value="admin@email.com"></option>
						 <option value="tuki@email.com"></option>
						 <option value="aoki@email.com"></option>
						 <option value="urabe@email.com"></option>
						 <option value="ai@email.com"></option>
					</datalist>
				<input type="submit" value="ログイン">
				</form>
			</div>

			<script src="https://accounts.google.com/gsi/client" async defer></script>

			<script>
        // Googleサインインが成功した後に呼び出されるコールバック関数
			function handleCredentialResponse(response) {
				console.log("Encoded JWT ID token: " + response.credential);
				fetch('<%= request.getContextPath() %>/login', {
					method: 'POST',
					headers: {
						'Content-Type': 'application/x-www-form-urlencoded',
					},
					body: 'idtoken=' + response.credential
				})
				.then(response => response.json()) // レスポンスをテキストではなくJSONとして解釈
				.then(data => {
				if (data.success) {
					// 成功した場合、指定されたURLにページを遷移させる
					window.location.href = data.redirectUrl;
				} else {
					// 失敗した場合、エラーメッセージを表示する
					document.getElementById('status').innerText = data.message<br>"接続できませんでした";
				}
				})
				.catch(error => {
				console.error('Error:', error);
				window.location.href = 'view/error.jsp';
				});
			}

</script>

		</div>
	</div>
</body>
</html>
