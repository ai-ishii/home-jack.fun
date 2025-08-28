<%--
個人情報一覧(管理者画面)

作成者:占部虎司郎

作成日:2025/7/4
更新日:2025/8/28
 --%>

<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.ArrayList, util.CommonTable, bean.User, dao.UserDAO"%>


<%
//個人情報を格納したListを受け取る
ArrayList<User> list = (ArrayList<User>) request.getAttribute("userList");

//リクエストスコープからキーワードを受け取る
String keyword = (String)request.getAttribute("keyword");
//リクエストスコープから検索0件の場合のcmdを受け取る
String cmd = (String)request.getAttribute("cmd");

if(keyword == null){
	keyword = "";
}

User user = new User();
UserDAO userDAO = new UserDAO();
CommonTable commonTable = new CommonTable();
%>

<html>
<head>
<!-- タイトル -->
<title>個人情報一覧 | Home-Jack</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
<script src="<%=request.getContextPath()%>/js/script.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<style>

.info {
	margin: auto;
	text-aline: center;
	width: 70%;
	
}

.box-user {
	text-align: center;
	margin-top: 20px;
}

.point-box {
    width: 80%;
    white-space: pre-wrap;
    word-wrap: break-word;
    overflow-wrap: break-word;
    word-break: break-all;
    margin: 0 auto;
}

.point-text {
    margin: 0 auto;
    width: 80%;
}

table {
    border-collapse: collapse;
    margin: 0 auto;
    padding: 0;
    width: 70%;
}

table tr {
    background-color: #fff;
    border-bottom: 2px solid #fff;
    height:70px
}

table tr:nth-child(even) {
    background-color: #eee;
}

table th, table td {
    padding: .20em 1em;
}

.case-link:hover{
cursor : pointer;
background-color:#c0c0c0;
}

table thead th {
    font-size: .85em;
    padding: 1em;
    width: 1em;
}

table thead tr {
    background-color: #f8b862;
    color: #fff;
}

.txt {
    text-align: left;
    font-size: .75em;
}

.num {
    text-align: center;
    white-space:pre-wrap;
}

.num-point {
    text-align: center;
    color: #FF7043;
    font-weight: bold;
}

.text-point {
    text-align: center;
    color: #FF7043;
    font-weight: bold;
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

.content{
font-weight:bold;
display: inline-block;
transition:.3s;
transform: scale(1);
text-decoration: none;
}
.content:hover{
font-weight:bold;
transform: scale(1.05);
color:#f89174;/*文字色*/
}

/* 削除ボタンのCSS */
.btn, a.btn, button.btn {
	font-size: 16px;
	font-weight: 700;
	line-height: 1.5;
	position: relative;
	display: inline-block;
	padding: 5px 20px;
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
	letter-spacing: 1.6px;
	border-radius: 85px;
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

/*　検索を行うフォーム */
.search-form {
	display: flex;
	justify-content: space-between;
	align-items: center;
	width: 250px; 
	overflow: hidden;
	border-radius: 25px;
	background-color: #feffe0;
	margin: 0;
}

.search-form input {
	height: 45px;
	padding: 5px;
	border: none;
	box-sizing: border-box;
	background-color: #feffe0;
	font-size: 1em;
	outline: none;
}

.search-form input::placeholder {
	color: #d9811c;
}

.search-form button {
	display: flex;
	justify-content: center;
	align-items: center;
	width: 50px;
	height: 45px;
	border: none;
	background-color: transparent;
	cursor: pointer;
}

.search-form button::after {
	width: 20px;
	height: 20px;
	background-image:
		url('data:image/svg+xml;charset=utf8,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%2024%2024%22%3E%20%3Cpath%20d%3D%22M23.7%2020.8%2019%2016.1c-.2-.2-.5-.3-.8-.3h-.8c1.3-1.7%202-3.7%202-6C19.5%204.4%2015.1%200%209.7%200S0%204.4%200%209.7s4.4%209.7%209.7%209.7c2.3%200%204.3-.8%206-2v.8c0%20.3.1.6.3.8l4.7%204.7c.4.4%201.2.4%201.6%200l1.3-1.3c.5-.5.5-1.2.1-1.6zm-14-5.1c-3.3%200-6-2.7-6-6s2.7-6%206-6%206%202.7%206%206-2.6%206-6%206z%22%20fill%3D%22%23d9811c%22%3E%3C%2Fpath%3E%20%3C%2Fsvg%3E');
	background-repeat: no-repeat;
	content: '';
}

input:-webkit-autofill,
input:-webkit-autofill:hover,
input:-webkit-autofill:focus,
input:-webkit-autofill:active {
    /* 背景色を元の色に戻す */
	-webkit-box-shadow: 0 0 0px 1000px #feffe0 inset !important;
}

.mar {
	margin: 0 auto
}

/* buttonタグのリセットCSS */
button {
	padding: 0;
	font-family: inherit;
	appearance: none;
	cursor: pointer;
	background-color: transparent;
	border: none;
}

#search-error{
text-align:center;
font-size: 16px;
}

.FFF{
background-color: #fff;
padding-top: 16px;
padding-bottom: 32px;
width: 70%;
margin: 0 auto;
}

/* アイコン */
.memo {
	display: inline-block;
	vertical-align: middle;
	stroke: #fff;
	fill: #fff;
}

/* ボタンの文字 */
.listText {
	vertical-align: middle;
	font-family: "Kosugi Maru", sans-serif;
	font-size: 21px;
	font-weight: 300;
	color: #fff;
}

.listButton {
	display: inline-block;
	padding: 8px 16px;
	background-color: #fdd35c;
	border: 3px solid #fdd35c;
	border-radius: 5px;
	text-decoration: none;
	text-align: center;
	cursor: pointer;
}

.listButton:hover {
	background-color: #fff;
	border: 3px solid #fdd35c;
}

.listButton:hover .memo {
	stroke: #fdd35c;
	fill: #fdd35c;
}

.listButton:hover .listText {
	color: #fdd35c;
}

</style>


</head>

<body>
	<div id="wrap">
		<!-- ヘッダー部分 -->
		<%@ include file="../common/header.jsp"%>

		<!-- メイン部分 -->
		<div id="main" class="container">
		
		<div id = "contents">
	<div id="link-title">
		<h1 id="link-line">個人情報一覧</h1>
	</div>

	<br>
	<table class="info">
	<tbody>
	<tr>
	<td class="search-box">
		<!-- 検索を行うフォーム -->
		<form class="search-form">
		<label><input type="text" id="searchInput" placeholder="キーワードを入力" value=<%=keyword %>></label>
		<button id="searchButton" type="button" aria-label="検索"></button>
		</form>
	</td>
	<% if(cmd.equals("search")) {%>
	<td>
		<div style="text-align: right;">
			<a class="listButton" href="<%=request.getContextPath()%>/userList">
				<svg class="memo" xmlns="http://www.w3.org/2000/svg"
					viewBox="0 0 640 640" style="width: 30px; height: 30px;">
					<!--!Font Awesome Free v7.0.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.-->
					<path
						d="M104 112C90.7 112 80 122.7 80 136L80 184C80 197.3 90.7 208 104 208L152
						 208C165.3 208 176 197.3 176 184L176 136C176 122.7 165.3 112 152 112L104
						  112zM256 128C238.3 128 224 142.3 224 160C224 177.7 238.3 192 256 192L544 
						  192C561.7 192 576 177.7 576 160C576 142.3 561.7 128 544 128L256 128zM256 
						  288C238.3 288 224 302.3 224 320C224 337.7 238.3 352 256 352L544 352C561.7 
						  352 576 337.7 576 320C576 302.3 561.7 288 544 288L256 288zM256 448C238.3 
						  448 224 462.3 224 480C224 497.7 238.3 512 256 512L544 512C561.7 512 576 
						  497.7 576 480C576 462.3 561.7 448 544 448L256 448zM80 296L80 344C80 357.3 
						  90.7 368 104 368L152 368C165.3 368 176 357.3 176 344L176 296C176 282.7 165.3 
						  272 152 272L104 272C90.7 272 80 282.7 80 296zM104 432C90.7 432 80 442.7 80
						   456L80 504C80 517.3 90.7 528 104 528L152 528C165.3 528 176 517.3 176 504L176
						    456C176 442.7 165.3 432 152 432L104 432z" />
				</svg>
				<span class="listText">一覧へ</span>
			</a>
		</div>
	</td>
	<% } %>
	</tr>
	</tbody>
	</table>
	
	<table class="info">
	<thead style="margin:0 auto">
	<tr>
		<th scope="col">【 社員番号 】</th>
		<th scope="col">【 氏名 】</th>
		<th scope="col">【 所属 】</th>
		<th></th>
	</tr>
	</thead>

<%
if (list != null) {
	for (int i = 0; i < list.size(); i++) {
		user = userDAO.selectByUserId(list.get(i).getUserId());

		String department = commonTable.selectDepartment(user.getDepartmentId());
		String group = commonTable.selectGroup(user.getGroupId());
		if(user.getDisplayFlag() != 1){
%>

		<tbody>
		<tr class="user-link case-link" data-href="<%=request.getContextPath()%>/userDetail?userId=<%=user.getUserId() %>">
			<td class="box-user" data-label="社員番号">
			<%=user.getEmployeeNumber() %>
			</td>
			<td class="box-user" data-label="名前">
			<%=user.getName() %>
			</td>
			<td class="box-user" data-label="所属">
			<%=department%>&emsp;<%=group %>
			</td>
			<td>
			<div style="text-align: center">
			<a data-href="<%=request.getContextPath()%>/userDetail?userId=<%=user.getUserId() %>&cmd=delete" 
				class="btn btn--delete">削除</a>
			</div>
			</td>
		</tr>
		</tbody>

<%
				}
			}
		}
%>
	
	</table>
	
	<% if(cmd.equals("no-result")) {%>
		<div id="search-error" class="FFF">
			<p>検索結果は0件です。内容を変更して再度検索をしてください。</p>
			<a class="listButton" href="<%=request.getContextPath()%>/userList">
				<svg class="memo" xmlns="http://www.w3.org/2000/svg"
					viewBox="0 0 640 640" style="width: 30px; height: 30px;">
					<!--!Font Awesome Free v7.0.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.-->
					<path
						d="M104 112C90.7 112 80 122.7 80 136L80 184C80 197.3 90.7 208 104 208L152
						 208C165.3 208 176 197.3 176 184L176 136C176 122.7 165.3 112 152 112L104
						  112zM256 128C238.3 128 224 142.3 224 160C224 177.7 238.3 192 256 192L544 
						  192C561.7 192 576 177.7 576 160C576 142.3 561.7 128 544 128L256 128zM256 
						  288C238.3 288 224 302.3 224 320C224 337.7 238.3 352 256 352L544 352C561.7 
						  352 576 337.7 576 320C576 302.3 561.7 288 544 288L256 288zM256 448C238.3 
						  448 224 462.3 224 480C224 497.7 238.3 512 256 512L544 512C561.7 512 576 
						  497.7 576 480C576 462.3 561.7 448 544 448L256 448zM80 296L80 344C80 357.3 
						  90.7 368 104 368L152 368C165.3 368 176 357.3 176 344L176 296C176 282.7 165.3 
						  272 152 272L104 272C90.7 272 80 282.7 80 296zM104 432C90.7 432 80 442.7 80
						   456L80 504C80 517.3 90.7 528 104 528L152 528C165.3 528 176 517.3 176 504L176
						    456C176 442.7 165.3 432 152 432L104 432z" />
				</svg>
				<span class="listText">一覧へ</span>
			</a>
		</div>
	<% } %>
	
	</div>
	</div>
	</div>
	
	
	
	<script>
	//javascriptで使用するためのコンテキストパスを準備
    const CONTEXT_PATH = "<%= request.getContextPath() %>";
	</script>
	<script src="<%= request.getContextPath() %>/js/userScript.js"></script>
</body>
</html>