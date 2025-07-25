<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.ArrayList,bean.User"%>


<%
ArrayList<User> userList = (ArrayList<User>) request.getAttribute("userList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>個人目標一覧</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<script src="${pageContext.request.contextPath}/js/script.js "></script>
<style>
/* 個人目標のCSS */
.Goaltitle {
	position: relative;
	margin-top: 100px;
	margin-bottom: 10px;
	text-align: center;
	font-size: 20px;
	z-index: 10;
}

.departpadding {
	padding-left: 20px;
	margin: 0 0 20px 0;
}

.selfGoal {
	position: relative;
	right: 500px;
	font-size: 30px;
}

.chatGoal {
	position: relative;
	right: 370px;
	font-size: 30px;
}

textarea {
	resize: none;
	width: 80%;
	height: 100px;
	overflow: auto; /* 縦方向にスクロールが行える！*/
}

.Goaltitle h3 {
	margin: 0 auto;
	width: 80%;
	text-align: left;
	left: 20px;
}

.cp_ipselect06 {
  position: relative;
  display: flex;
  justify-content: center;
  flex-direction: column;
  margin: 2em auto;
}
.cp_ipselect06 .cp_sl06 {
  position: relative;
  width: 100%;
  height: 48px;
  cursor: pointer;
  text-overflow: ellipsis;/*テキストがオーバーしたら'...'で省略*/
  z-index: 1;
  /* 標準のスタイルを無効にしborder-bottomを設定 */
  border: none;
  appearance: none;
  outline: none;
  background: transparent;
  border-radius: 0;
  border-bottom: 1px solid #666666;
}
/*プルダウンの三角を設定*/
.cp_ipselect06::after {
  position: absolute;
  right: 15px;
  content: '';
  width: 16px;
  height: 8px;
  background: #666666;
  clip-path: polygon(0 0, 100% 0, 50% 100%);
}
.cp_sl06_selectlabel {
  position: absolute;
  left: 0;
  top: 10px;
  color: #666666;
  transition: 0.2s ease all;
}
/*選択した際の動き:「Choose」の文字*/
.cp_sl06:focus ~ .cp_sl06_selectlabel,
.cp_sl06:valid ~ .cp_sl06_selectlabel {
  color: #da3c41;
  top: -20px;
  transition: 0.2s ease all;
  font-size: 80%;
}
/*選択した際の動き:セレクト下のライン*/
.cp_sl06_selectbar {
  position: relative;
  display: block;
  width: 100%;
}
.cp_sl06_selectbar:before,
.cp_sl06_selectbar:after {
  bottom: 1px;
  content: '';
  width: 0;
  height: 2px;
  position: absolute;
  background: #da3c41;
  transition: 0.2s ease all;
}
.cp_sl06_selectbar:before {
  left: 50%;
}
.cp_sl06_selectbar:after {
  right: 50%;
}
/*focus時の設定*/
.cp_ipselect06 .cp_sl06:focus {
  border-bottom: 1px solid transparent;
}
.cp_sl06:focus ~ .cp_sl06_selectbar:before,
.cp_sl06:focus ~ .cp_sl06_selectbar:after {
  width: 50%;
}


</style>

</head>
<body>
	<div id="wrap">
		<%@ include file="../common/header.jsp"%>


		<div class="Goaltitle">
			<h1>チーム内個人目標一覧</h1>

			<div class="cp_ipselect06">
				<select class="cp_sl06" required>
					<option value="" hidden disabled selected></option>
					<option value="1">cat</option>
					<option value="2">dog</option>
					<option value="3">rabbit</option>
					<option value="4">squirrel</option>
				</select> <span class="cp_sl06_selectbar"></span> <label
					class="cp_sl06_selectlabel">Choose</label>
			</div>


		</div>
	</div>




</body>
</html>