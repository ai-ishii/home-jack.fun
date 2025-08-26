<%--
個人情報詳細画面

作成者:月向亮太

作成日: 2025/8/21
更新日: 2025/8/26
 --%>

<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.ArrayList, bean.User, util.MyFormat"%>
<%@page import="bean.Authority"%>
<%@page import="bean.AuthorityHaving"%>
<%
//個人情報を格納したuserを受け取る
User user = (User) request.getAttribute("user");
//String cmd = (String) request.getAttribute("cmd");
ArrayList<Authority> authorityList = (ArrayList<Authority>) request.getAttribute("authority_list");
ArrayList<AuthorityHaving> authorityHavingList = (ArrayList<AuthorityHaving>) request.getAttribute("authority_having_list");

%>

<html>
<head>
<!-- タイトル -->
<title>個人情報詳細 | HomeJack</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<script src="<%=request.getContextPath()%>/js/script.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
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

/* 追加したよ */
#detail-list{
margin:0 auto;
}

table {
    margin: 0 auto;
    padding: 0;
    width: 60%;
    border-collapse: collapse;
    
}

table tr {
    background-color: #fff;
    border-bottom: 2px solid #fff;
    height:50px
}

table th, table td {
    padding: .20em 1em;
}

.table-double{
	border-right: 3px double #fcc800; /* 二重線を適用 */
 	padding: 8px;
 	width: 90px;
}

.table-single{
	border-bottom: 0.5px solid #f4dda5;
}

#koji-name{
text-align: center;
}
.button-container{
	text-align: center;
	margin-top: 30px;
}

</style>
</head>

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
				
				
				<form action="<%= request.getContextPath() %>/userConfirm" method="post">
				
				<h3 id="koji-name">個人情報：<%=user.getName() %></h3>
				
					<%
						for (int i = 0; i < authorityHavingList.size(); i++){
							AuthorityHaving having = authorityHavingList.get(i);
							if (having.getAuthorityCode().equals("POS_MNGR")){	
					%>
					<a href="<%=request.getContextPath()%>/userList"><p>個人情報一覧はコチラ</p></a>
					
					<%
							}
						}
					%>
				
				<table id="detail-list">
					<tr class="table-single">
						<td class="table-double">社員番号</td>
						<td><%=user.getEmployeeNumber() %></td>
					</tr>
					<tr class="table-single">
						<td class="table-double">所属</td>
						<td>第<%=user.getDepartmentId() %>部&nbsp;第<%=user.getGroupId() %>グループ</td>
					</tr>
					<tr class="table-single">
						<td class="table-double">氏名</td>
						<td><%=user.getName() %></td>
					</tr>
					<tr class="table-single">
						<td class="table-double">ふりがな</td>
						<td><%=user.getNameKana() %></td>
					</tr>
					<tr class="table-single">
						<td class="table-double">生年月日</td>
						<td><%=user.getBirthday() %></td>
					</tr>
					<tr class="table-single">
						<td class="table-double">性別</td>
						<td><%=user.getSex() %></td>
					</tr>
					<tr class="table-single">
						<td class="table-double">電話番号</td>
						<td><%=user.getPhone() %></td>
					</tr>
					<tr class="table-single">
						<td class="table-double">郵便番号</td>
						<td><%=user.getPost() %></td>
					</tr>
					<tr class="table-single">
						<td class="table-double">住所</td>
						<td><%=user.getAddress() %></td>
					</tr>
					<tr class="table-single">
						<td class="table-double">子供</td>
						<td>
						<%if(user.getChildren() != 0){ %>
						<%=user.getChildren() %>人
						<%} %>
						</td>
					</tr>
					<tr class="table-single">
						<td class="table-double">勤務年数</td>
						<td><%=user.getWorkHistory() %>年</td>
					</tr>
					<tr class="table-single">
						<td class="table-double">最寄り駅</td>
						<td><%=user.getNearestStation() %></td>
					</tr>
					<tr class="table-single">
						<td class="table-double">交通手段</td>
						<td><%=user.getTransportation() %></td>
					</tr>
					<tr class="table-single">
						<td class="table-double">資格</td>
						<td><%=user.getQualification() %></td>
					
					
					</tr>
					<tr class="table-single">
						<td class="table-double">権限</td>
						
					<td>
					<%
						for (AuthorityHaving having : authorityHavingList){
							for (Authority authority : authorityList) {
				                if (having.getAuthorityCode().equals(authority.getAuthorityCode())) {
					%>
					
                <%= authority.getAuthorityName() %>
						<br>
					<%
								}
							}
						}
					%>
					</td>
					</tr>
					
					
					
				</table>
				
				<div class="button-container">	
					<button type="submit" name="registerConfirm" value="変更する" class="btn btn-border">
					変更する
					</button>
				
					</form>
				
				</div>
			</div>
		</div>
</body>
</html>