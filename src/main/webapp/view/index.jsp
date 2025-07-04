<%@page contentType="text/html; charset=UTF-8"%>

<html>
	<head>
		<title></title>
		<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
		<script src="${pageContext.request.contextPath}/js/script.js"></script>
	</head>
	<style>
/*-----------------------------------------------------------------------------------*/
/*テーブル表示*/
.list-table {
	
}


/*-----------------------------------------------------------------------------------*/
	</style>
	
	<body>
		<div id="wrap">
			<%@ include file="../common/header.jsp" %>

			<div id="main" class="container">
  				<table class="list-table">
  					<thead>
  						<tr>最新のお知らせ</tr>
  					</thead>
  					<tbody class="article">
  						<tr>
  						<th>今日のわんこ</th>
  						</tr>
  						<tr>
  						<td>きょうのわんこ、しゃけ。1歳。ガルク。カムラの里で、だれかさんと暮らしています。</td>
  						</tr>
  						<tr>
  						<td>2025/06/28</td>
  						</tr>
  					</tbody class="article">
  					<tbody>
  						<tr>
  						<th>今日のわんこ</th>
  						</tr>
  						<tr>
  						<td>きょうのわんこ、しゃけ。1歳。ガルク。カムラの里で、だれかさんと暮らしています。</td>
  						</tr>
  						<tr>
  						<td>2025/06/28</td>
  						</tr>
  					</tbody>
  				</table>
			</div>
		</div>
	</body>
</html>