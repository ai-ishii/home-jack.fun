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
.announce {
	display: block;
}

.announce ul {
	display:inline-block;
	width: 300px;
}

.announce li {
	list-style: none;
}

/*-----------------------------------------------------------------------------------*/
	</style>
	
	<body>
		<div id="wrap">
			<%@ include file="../common/header.jsp" %>

			<div id="main" class="container">
				<div class="announce">
					<h2>最新のお知らせ</h2>
					<ul>
						<li class="title">今日のわんこ</li>
						<li class="article">きょうのわんこ、しゃけ。1歳。ガルク。カムラの里で、だれかさんと暮らしています。</li>
						<li class="date">2025/06/28</li>
					</ul>
					<ul>
						<li class="title">今日のわんこ</li>
						<li class="article">きょうのわんこ、ぼたもち。2歳。ガルク。カムラの里で、どちらさんと暮らしています。</li>
						<li class="date">2025/06/29</li>
					</ul>
					<ul>
						<li class="title">今日のわんこ</li>
						<li class="article">きょうのわんこ、エクレア。3歳。ガルク。カムラの里で、そなたさんと暮らしています。</li>
						<li class="date">2025/06/30</li>
					</ul>
				</div>
			</div>
		</div>
	</body>
</html>