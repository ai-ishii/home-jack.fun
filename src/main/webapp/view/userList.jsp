<%--　
個人情報一覧(管理者画面)

作成者:占部虎司郎

作成日:2025/7/4
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList, bean.User"%>

<%
//個人情報を格納したListを受け取る
ArrayList<User> list = (ArrayList<User>) request.getAttribute("user_list");


%>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>個人情報一覧_Home-Jack</title>
<meta name="viewport" content="width=device-width,initial-scale=1">
<style type="text/css">

</style>
</head>


<body>
	<%@include file="../common/header.jsp"%>
	
	<table>
	
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
	<td><%=user.getEnployee_number() %></td>
	<td><%=user.getName() %></td>
	<td>第<%=user.getDepartment %>部&emsp;第<%=user.getTeam %>グループ</td>
	</tr>
	
<%
	}
}
%>
</table>

</body>
</html>
