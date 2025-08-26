<!-- 
	資格取得者一覧画面
	
	作成者：K.R
	
	更新者：大北直弥
	
	最終更新日：8/25
 -->
<%@page contentType="text/html; charset=UTF-8"%>
<%@ page import="bean.Request, bean.LicenseRequest, java.util.ArrayList"%>

<%
ArrayList<Request> requestList = (ArrayList<Request>) request.getAttribute("requestList");
ArrayList<LicenseRequest> licenseRequestList = (ArrayList<LicenseRequest>) request.getAttribute("licenseRequestList");
%>

<html>
<head>
<!-- タイトル -->
<title>資格取得状況一覧</title>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<script src="<%=request.getContextPath()%>/js/script.js"
	type="text/javascript"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"
	type="text/javascript"></script>
</head>
<body>
	<div id="wrap">
		<!-- ヘッダー部分 -->
		<%@ include file="../common/header.jsp"%>

		<!-- メイン部分(この中に書いていく) -->
		<div id="main" class="container">
			<div class="license">

				<div class="header">
					<!--Content before waves-->
					<div class="inner-header flex">

						<center>
							<!-- タイトル -->
							<h1>&#129784;資格取得者一覧&#129783;</h1>
							<form id="from1"
								action="<%=request.getContextPath()%>/licenseList" method="get">
								<input id="sbox1" name="s" type="text" placeholder="IDを入力してください">

								<input id="sbtn1" type="submit" value="検索" />
							</form>
						</center>
					</div>
					<!--Waves表現部分-->
					<div>
						<svg class="waves" xmlns="http://www.w3.org/2000/svg"
							xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 24 150 28"
							preserveAspectRatio="none" shape-rendering="auto">
<defs>
<path id="gentle-wave"
								d="M-160 44c30 0 58-18 88-18s 58 18 88 18 58-18 88-18 58 18 88 18 v44h-352z" />
</defs>
<g class="parallax">
<use xlink:href="#gentle-wave" x="48" y="0" fill="rgba(255,255,255,0.7" />
<use xlink:href="#gentle-wave" x="48" y="3" fill="rgba(255,255,255,0.5)" />
<use xlink:href="#gentle-wave" x="48" y="5" fill="rgba(255,255,255,0.3)" />
<use xlink:href="#gentle-wave" x="48" y="7" fill="#fff" />
</g>
</svg>
					</div>
					<!--Waves終わり-->

				</div>
				<!--Header ends-->
			</div>
			<table>
				<th>
					<td>名前</td>
					<td>所属</td>
					<td>資格名</td>
					<td>合格日</td>
				</th>
				<%
				for (int i = 0; i < requestList.size() && i < licenseRequestList.size(); i++) {
				%>
				<tr>
					<td><%=requestList.get(i).getApplicant()%></td>
					<td><%=licenseRequestList.get(i).getDepartmentId()%></td>
					<td><%=licenseRequestList.get(i).getLicenseId()%></td>
					<td><%=licenseRequestList.get(i).getExamDate()%></td>
				</tr>
				<%
				}
				%>
			</table>
			
		</div>
	</div>
</body>
</html>