<!-- 
	資格取得者一覧画面
	
	作成者：K.R
	
	更新者：大北直弥
	
	最終更新日：8/26
 -->
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="bean.Request, 
				bean.LicenseRequest, 
				bean.CategoryMap, 
				util.MyFormat, 
				java.util.ArrayList"%>

<%
// オブジェクト生成
MyFormat myFormat = new MyFormat();

// リクエストスコープからパラメータを受け取る
ArrayList<Request> requestList = (ArrayList<Request>) request.getAttribute("request_list");
ArrayList<LicenseRequest> licenseRequestList = (ArrayList<LicenseRequest>) request.getAttribute("licenseRequest_list");
ArrayList<CategoryMap> departmentList = (ArrayList<CategoryMap>) request.getAttribute("department_list");
ArrayList<CategoryMap> groupList = (ArrayList<CategoryMap>) request.getAttribute("group_list");
ArrayList<CategoryMap> licenseList = (ArrayList<CategoryMap>) request.getAttribute("license_list");
%>

<html>
<head>
<!-- タイトル -->
<title>資格取得状況一覧 | Home-Jack</title>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<script src="<%=request.getContextPath()%>/js/script.js" 
	type="text/javascript"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js" 
	type="text/javascript"></script>
	
<style>

#contents {
	width: 90%;
	margin-right: auto;
	margin-left: auto;
}

/* タイトル部分 */
#link-title {
	text-align: center;
}

#link-collect {
	margin-top: 5%;
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

/* 余白 */
#mag {
	margin-top: 24px;
}

.licenseFrame{
width: 90%;
margin: 0 auto;
}

table {
	border-collapse: collapse;
	margin: 0 auto;
	padding: 0;
	width: 100%;
}

table tbody tr {
	background-color: #fff;
	border-bottom: 2px solid #fff;
	height: 70px;
}

table tbody tr:nth-child(even) {
	background-color: #eee;
}

table th, table td {
	padding: .20em .5em;
}

table thead{
background-color: #ffffff;
}

table thead th.jack-table{
	font-size: .85em;
	padding: 1em;
	width: 100px;
}

table thead tr.jack-table{
	background-color: #f8b862;
	color: #fff;
}

.subTitle{
font-size: 18px;
}

.text{
text-align: center;
}

.text-point {
	text-align: center;
	color: #FF7043;
	font-weight: bold;
}

a {
	text-decoration: none;
}

.btnFrame{
display: flex;
justify-content: center;
margin: 8px 0;
padding-left: 24px;
}

.registerFrame{
margin-left: auto;
width: 150px;
height: 55px;
padding-top: 32px;
}

.register_box a {
	padding: 10px 20px;
	width: 100px;
	height: 20px;
	border-radius: 20px;
	border: solid 2px orange;
	background-color: #fff;
	text-align: center;
	color: orange;
	letter-spacing: 0.1em;
}

.register_box a:hover {
	background-color: orange;
	color: #fff;
	border: solid 2px #fff;
}

/*　検索を行うフォーム */
.search-form {
	display: flex;
	justify-content: space-between;
	align-items: center;
	width: 270px; 
	height: 60px;
	overflow: hidden;
	border-radius: 25px;
	background-color: #feffe0;
	margin: 8px 0 0;
	padding: 0;
	border: solid 2px #d9811c;
}

.search-form input {
	height: 45px;
	padding: 5px 15px;
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
	margin-right: 16px;
}

.search-form button::after {
	width: 20px;
	height: 20px;
	background-image:
		url('data:image/svg+xml;charset=utf8,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%2024%2024%22%3E%20%3Cpath%20d%3D%22M23.7%2020.8%2019%2016.1c-.2-.2-.5-.3-.8-.3h-.8c1.3-1.7%202-3.7%202-6C19.5%204.4%2015.1%200%209.7%200S0%204.4%200%209.7s4.4%209.7%209.7%209.7c2.3%200%204.3-.8%206-2v.8c0%20.3.1.6.3.8l4.7%204.7c.4.4%201.2.4%201.6%200l1.3-1.3c.5-.5.5-1.2.1-1.6zm-14-5.1c-3.3%200-6-2.7-6-6s2.7-6%206-6%206%202.7%206%206-2.6%206-6%206z%22%20fill%3D%22%23d9811c%22%3E%3C%2Fpath%3E%20%3C%2Fsvg%3E');
	background-repeat: no-repeat;
	content: '';
}

/* 検索窓のデザイン維持 */
input:-webkit-autofill,
input:-webkit-autofill:hover,
input:-webkit-autofill:focus,
input:-webkit-autofill:active {
    /* 背景色を元の色に戻す */
    -webkit-box-shadow: 0 0 0px 1000px #feffe0 inset !important;
}

</style>
</head>
<body>
	<div id="wrap">
		<!-- ヘッダー部分 -->
		<%@ include file="../common/header.jsp"%>

		<!-- メイン部分(この中に書いていく) -->
		<div id="main" class="container">
		<div id="contents">

				<!-- タイトル部分 -->
				<div id="link-title">
					<h1 id="link-line">資格取得者一覧</h1>
				</div>
				
				<div id="mag"></div>
				<!--Header ends-->
			<div class="licenseFrame">
			<div class="btnFrame">
				<form action="<%=request.getContextPath()%>/licenseList" class="search-form">
					<label>
						<input type="text" name="keyword" placeholder="キーワードを入力" value="">
					</label>
					<button type="submit" aria-label="検索"></button>
				</form>
				<div class="registerFrame">
					<div class="register_box">
						<a href="<%=request.getContextPath()%>/licenseFormPrepare" class="box-link">資格申請</a>
					</div>
				</div>
			</div>
			<table>
				<thead style="margin: 0 auto" class="subTitle">
					<tr class="jack-table">
						<th scope="col" class="jack-table">氏名</th>
						<th scope="col" class="jack-table">所属</th>
						<th scope="col" class="jack-table">資格名</th>
						<th scope="col" class="jack-table">合格日</th>
					</tr>
				</thead>
				<tbody>
				<%
				for (int i = 0; i < requestList.size() && i < licenseRequestList.size(); i++) {
				%>
				<tr>
					<!-- 名前 -->
					<td class="text"><%=requestList.get(i).getApplicant()%></td>
					<!-- 所属 -->
					<td class="text">
					<%
					for (int j = 0; j < departmentList.size(); j++) {
						if (licenseRequestList.get(i).getDepartmentId() == departmentList.get(j).getId()) {
					%>
						<!-- 部情報 -->
						<%=departmentList.get(j).getName()%>
					<%
						}
					}
					%>
					<%
					for (int j = 0; j < groupList.size(); j++) {
						if (licenseRequestList.get(i).getGroupId() == groupList.get(j).getId()) {
					%>
						<!-- グループ情報 -->
						<%=groupList.get(j).getName()%>
					<%
						}
					}
					%>
					</td>
					<!-- 取得資格名 -->
					<td class="text-point">
					<%
					for (int j = 0; j < licenseList.size(); j++) {
						if (licenseRequestList.get(i).getLicenseId() == licenseList.get(j).getId()) {
					%>
						<%=licenseList.get(j).getName()%>
					<%
						}
					}
					%>
					</td>
					<!-- 受験日 -->
					<td class="text"><%=myFormat.LocalDateFormat(licenseRequestList.get(i).getExamDate())%></td>
				</tr>
				<%
				}
				%>
				</tbody>
			</table>
			</div>
		</div>
		</div>
	</div>
</body>
</html>