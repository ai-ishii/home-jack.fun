<%--　
個人情報一覧(管理者画面)

作成者:占部虎司郎

作成日:2025/7/4
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList, bean.User"%>

<%
//個人情報を格納したListを受け取る
ArrayList<User> list = (ArrayList<User>) request.getAttribute("user_List");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>個人情報一覧 | Home-Jack</title>
<meta name="viewport" content="width=device-width,initial-scale=1">
<style type="text/css">
#info {
	margin: auto;
	text-aline: center;
	width: 35%;
}

.box-user {
	text-align: center;
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
</style>
<link rel="stylesheet"
	href="<%= request.getContextPath()%>/css/style.css">
</head>

<body>
<%@include file="../common/header.jsp"%>
	
<div id="contents, link-title">
	<h1 id="link-line">個人情報一覧</h1>
</div>

	<table id="info">

		<tr>
			<th>【 社員番号 】</th>
			<th>【 氏名 】</th>
			<th>【 所属 】</th>
		</tr>

		<%
if (list != null) {
	for (int i = 0; i < list.size(); i++) {
		User user = (User) list.get(i);
%>

		<tr>
			<td class="box-user"><a href="<%=request.getContextPath()%>/detailUser"><%=user.getEmployeeNumber() %></a></td>
			<td class="box-user"><%=user.getName() %></td>
			<td class="box-user">第<%=user.getDepartment() %>部&emsp;第<%=user.getTeam() %>グループ
			</td>
		</tr>

		<%
	}
}
%>
	</table>

</body>
</html>
