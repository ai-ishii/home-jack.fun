<%@page
	import="bean.AuthorityHaving, 
				bean.Authority, 
				java.util.ArrayList"%>
<%@page contentType="text/html; charset=UTF-8"%>

<%
ArrayList<Authority> authorityList = (ArrayList<Authority>)request.getAttribute(authority_list);
ArrayList<AuthorityHaving> authorityHavingList = (ArrayList<AuthorityHaving>)request.getAttribute(authority_having_list);
int userId = (Integer)request.getAttribute(user_id);
String userName = (String)request.getAttribute(name);
%>
<html>
<head>
<!-- タイトル -->
<title>権限振り分け</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<script src="<%=request.getContextPath()%>/js/script.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<style>
/*
-----------------------------------------------------------------------------------

<!--この中にCSSを書く-->

-----------------------------------------------------------------------------------
*/
</style>

<body>
	<div id="wrap">
		<!-- ヘッダー部分 -->
		<%@ include file="../common/header.jsp"%>

		<!-- メイン部分 -->
		<div id="main" class="container">
			<div class="authority">

				<h1>権限振り分け</h1>

				<form action="<%= request.getContextPath() %>/authUpdate" method="post">
					<h3><%= userName %></h3>
					<%
					for (Authority authority : authorityList) {
						String code = authority.getAuthorityCode();
					%>
					<div class="checkbox-group">
						<input type="checkbox" name="auth_list" value="<%= code %>" id="<%= code %>" class="checkbox" 
						<%
						for (AuthorityHaving authorityHaving : authorityHavingList) {
							if ((code).equals(authorityHaving.getAuthorityCode())) {
						%>
						checked
						<%
							}
						}
						%>
						>
						<label for="<%= code %>"><%= authority.getAuthorityName() %></label>
					</div>
					<%} %>
					<input type="submit" value="更新">
				</form>
			
			</div>
		</div>
	</div>
</body>
</html>