<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.ArrayList,bean.User"%>


<%
ArrayList<User> list = 
(ArrayList<User>)request.getAttribute("list");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>個人目標一覧</title>
<link rel="stylesheet" href="<%= request.getContextPath()%>/css/style.css">
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
	overflow: auto;  /* 縦方向にスクロールが行える！*/
	
}

.Goaltitle h3 {
	margin: 0 auto;
	width: 80%;
	text-align: left;
	left: 20px;
}	

</style>

</head>
<body>
	<div id="wrap">
	<%@ include file="../common/header.jsp"%>


	<div class="Goaltitle">
		<h1>チーム内個人目標一覧</h1>

			
		
			<div class="departpadding">
				<h3>BS<%= list.get(0).getDepartment() %>-GP<%= list.get(1).getTeam() %></h3>
			</div>
			
			<%
				for(int i=0; i < list.size();i++){
					if("2".equals(list.get(i).getTeam())){
			%>
			<div class="departpadding">
				<h3><%= list.get(i).getName() %></h3>
			</div>
			<%
					}
				}
			%>
		</div>
		</div>
		</div>
		
		
	

</body>
</html>