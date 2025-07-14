<%--
商品登録画面(ユーザー画面)

作成者:占部虎司郎

作成日: 2025/7/11
 --%>

<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.ArrayList, bean.User, util.MyFormat"%>

<%
//個人情報を格納したuserを受け取る
User user = (User) request.getAttribute("user");
%>

<html>
<head>
<!-- タイトル -->
<title>個人情報詳細 | HomeJack</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<script src="<%=request.getContextPath()%>/js/script.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<style>

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

<body>
	<div id="wrap">
		<!-- ヘッダー部分 -->
		<%@ include file="../common/header.jsp"%>

		<!-- メイン部分 -->
		<div id="main" class="container">
			<div id="contents">
				<div id="link-title">
					<h1 id="link-line">個人情報詳細</h1>
				</div>
				<br>
				
				<% 
				MyFormat myFormat = new MyFormat();
				Date birthday = user.getBirthday();
				String birthday = myFormat.breakDateFormat(birthday);
				%>
				
				<table>
					<tr>
						<td>社員番号</td>
						<td><%=user.getEmployeeNumber() %></td>
					</tr>
					<tr>
						<td>所属</td>
						<td>第<%=user.getDepartment() %>部&emsp;第<%=user.getTeam() %>グループ</td>
					</tr>
					<tr>
						<td>氏名</td>
						<td><%=user.getName() %></td>
					</tr>
					<tr>
						<td>ふりがな</td>
						<td><%=user.getNameKana() %></td>
					</tr>
					<tr>
						<td>生年月日</td>
						<td><%= birthday %></td>
					</tr>
					<tr>
						<td>性別</td>
						<td><%=user.getSex() %></td>
					</tr>
					<tr>
						<td>電話番号</td>
						<td><%=user.getPhone() %></td>
					</tr>
					<tr>
						<td>郵便番号</td>
						<td><%=user.getPost() %></td>
					</tr>
					<tr>
						<td>住所</td>
						<td><%=user.getAddress() %></td>
					</tr>
					<tr>
						<td>子供</td>
						<td><%=user.getChildren() %>人</td>
					</tr>
					<tr>
						<td>勤務年数</td>
						<td><%=user.getWorkHistory() %>年</td>
					</tr>
					<tr>
						<td>最寄り駅</td>
						<td><%=user.getNearestStation() %></td>
					</tr>
					<tr>
						<td>交通手段</td>
						<td><%=user.getTransportation() %></td>
					</tr>
					<tr>
						<td>資格</td>
						<td><%=user.getQualification() %></td>
					</tr>
					<%
					if(user.getUpdateDate() != null){
					%>
					<tr>
						<td>更新日時</td>
						<td><%=user.getUpdateDate() %></td>
					</tr>
					<%
					}else{
					%>
					<tr>
						<td>登録日時</td>
						<td><%=user.getRegistDate() %></td>
					</tr>
					<%
					}
					%>
				</table>
				
			</div>
		</div>
</body>
</html>