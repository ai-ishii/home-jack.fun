<%--
個人情報一覧(管理者画面)

作成者:占部虎司郎

作成日:2025/7/4
 --%>

<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.ArrayList, bean.User"%>

<%
//個人情報を格納したListを受け取る
ArrayList<User> list = (ArrayList<User>) request.getAttribute("user_List");
%>

<html>
<head>
<!-- タイトル -->
<title>個人情報一覧 | Home-Jack</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
<script src="<%=request.getContextPath()%>/js/script.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<style>

#info {
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

.btn,
a.btn,
button.btn {
  font-size: 0.9rem;
  font-weight: 700;
  line-height: 1.5;
  position: relative;
  display: inline-block;
  padding: 0.3rem 1.1rem;
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
  border-radius: 0.5rem;
}

a.btn--yellow {
  color: #000;
  background-color: #bbc8e6;
  border-bottom: 5px solid #8491c3;
}

a.btn--yellow:hover {
  margin-top: 3px;
  color: #000;
  background: #706caa;
  border-bottom: 2px solid #4a488e;
}

</style>

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
	<table id="info">
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
		User user = (User) list.get(i);
%>

		<tr>
			<td class="box-user" data-label="社員番号">
			<a class= "content" href="<%=request.getContextPath()%>/detailUser?userId=<%=user.getUserId() %>"><%=user.getEmployeeNumber() %></a>
			</td>
			<td class="box-user" data-label="名前">
			<%=user.getName() %>
			</td>
			<td class="box-user" data-label="所属">
			第<%=user.getDepartment() %>部&nbsp;第<%=user.getTeam() %>グループ
			</td>
			<td>
			<div style="text-align: center">
				<a href="<%=request.getContextPath() %>/deleteUser?userId=<%=user.getUserId() %>" class="btn btn--yellow btn--cubic">削除</a>
			</div>
			</td>
		</tr>

		<%
	}
}
%>
	</table>
</div>
		
		</div>
	</div>
</body>
</html>