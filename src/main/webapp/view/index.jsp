<%@page contentType="text/html; charset=UTF-8"%>

<%
ArrayList<>
%>

<html>
<head>
<title></title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<script src="<%=request.getContextPath()%>/js/script.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<style>
/*-----------------------------------------------------------------------------------*/
/*サイドバー表示*/
.flex {
	display: flex;
	width: 100%;
}

#sidebar {
	width: 30%;
}

#announce {
	width: 70%;
}


/*テーブル表示*/
.announce-list {
	position: relative;
	list-style: none outside;
	margin: 0;
	padding: 0;
	width: 100%;
	z-index: 10;
}

.announce-list li {
	list-style: none;
}

.announce-list .item {
	width: 100%;
}

.announce-list .item a {
	display: flex;
	flex-wrap: wrap;
	flex-wrap: nowrap;
	text-decoration: none;
	color: #333333;
	border-bottom: 1px solid #cccccc;
	padding: 20px 0;
	width: 100%;

}

.announce-list .item:first-child a {
	border-top: 1px solid #cccccc;
	text-decoration: none;
}

.announce-list .item .date {
	margin: 0;
	min-width: 120px;
	color: #999999;
}

.announce-list .item .tag {
	margin: 0;
	min-width: 120px;
}

.announce-list .item .tag span {
	background: #999999;
	color: #ffffff;
	text-align: center;
	display: inline-block;
	padding: 5px 20px;
	font-size: 12px;
	line-height: 1;
}

.announce-list .item .article {
	width: 650px;
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}

.announce-list .item .title {
	margin: 0;
	padding: 0 auto;
	width: 100%;
}

.announce-list .item .name {
	position: relative;
	margin: -5px 0 0 0;
	min-width: 140px;
	padding: 0 20px 0 0;
	color: #999999;
}

.announce-list .item a:hover .title {
	color: #0000ff;
}

@media screen and (max-width: 767px) {
	.announce-list .item a {
		flex-wrap: wrap;
	}
	.announce-list .item .date {
		min-width: 100px;
	}
	.announce-list .item .title {
		margin-top: 10px;
	}
}


/*-----------------------------------------------------------------------------------*/
</style>

<body>
	<div id="wrap">
		<%@ include file="../common/header.jsp"%>

		<div id="main" class="container">
			<div class="flex">
				<div id="sidebar" class="container">
					<div class="calendar">
						<p>カレンダー</p>
						<iframe
							src="https://calendar.google.com/calendar/embed?height=180&wkst=1&ctz=Asia%2FTokyo&showPrint=0&showTitle=0&showNav=0&showDate=0&showTabs=0&showCalendars=0&showTz=0&src=Y18wYWJkY2ViYzY4NGFjNzg2NDE3YmU3MmZkMjY5ZjVlNzI0MjFmODRjZjQ5ZDgzNWM4ZDIyMDk4M2RiYzA0MjVjQGdyb3VwLmNhbGVuZGFyLmdvb2dsZS5jb20&color=%23616161"
							style="border-width: 0" width="300" height="180" frameborder="0"
							scrolling="no"></iframe>
					</div>
				</div>

				<div id="announce" class="container">
					<h2>重要なお知らせ</h2>
					<div class="announce-list">
						<ul>
						
						
							<li class="item"><a href="#">
									<p class="date">2025/06/30</p>
									<p class="tag">
										<span>お知らせ</span>
									</p>
									<div class="title">
										<p class="article">今日のわんこ
											しゃけ。1歳。ガルク。カムラの里で、だれかさんと暮らしています。ああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああ</p>
										<p class="name">青木</p>
									</div>
							</a></li>
							<li class="item"><a href="#">
									<p class="date">2025/06/29</p>
									<p class="tag">
										<span>お知らせ</span>
									</p>
									<div class="title">
										<p class="article">今日のわんこ
											ぼたもち。2歳。ガルク。カムラの里で、どちらさんと暮らしています。</p>
										<p class="name">占部</p>
									</div>
							</a></li>
							<li class="item"><a href="#">
									<p class="date">2025/06/28</p>
									<p class="tag">
										<span>お知らせ</span>
									</p>
									<div class="title">
										<p class="article">今日のわんこ
											えくれあ。3歳。ガルク。カムラの里で、そなたさんと暮らしています。</p>
										<p class="name">月向</p>
									</div>
							</a></li>
						</ul>
					</div>
					
					<h2>最新のお知らせ</h2>
					<div class="announce-list">
						<ul>
							<li class="item"><a href="#">
									<p class="date">2025/06/30</p>
									<p class="tag">
										<span>お知らせ</span>
									</p>
									<div class="title">
										<p class="article">今日のわんこ
											しゃけ。1歳。ガルク。カムラの里で、だれかさんと暮らしています。ああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああ</p>
										<p class="name">青木</p>
									</div>
							</a></li>
							<li class="item"><a href="#">
									<p class="date">2025/06/29</p>
									<p class="tag">
										<span>お知らせ</span>
									</p>
									<div class="title">
										<p class="article">今日のわんこ
											ぼたもち。2歳。ガルク。カムラの里で、どちらさんと暮らしています。</p>
										<p class="name">占部</p>
									</div>
							</a></li>
							<li class="item"><a href="#">
									<p class="date">2025/06/28</p>
									<p class="tag">
										<span>お知らせ</span>
									</p>
									<div class="title">
										<p class="article">今日のわんこ
											えくれあ。3歳。ガルク。カムラの里で、そなたさんと暮らしています。</p>
										<p class="name">月向</p>
									</div>
							</a></li>
						</ul>
					</div>
					<h2>最新のチーム活動</h2>
					<div class="announce-list">
						<ul>
							<li class="item"><a href="#">
									<p class="date">2025/06/30</p>
									<p class="tag">
										<span>チーム活動</span>
									</p>
									<div class="title">
										<p class="article">今日のわんこ
											しゃけ。1歳。ガルク。カムラの里で、だれかさんと暮らしています。ああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああ</p>
										<p class="name">青木</p>
									</div>
							</a></li>
							<li class="item"><a href="#">
									<p class="date">2025/06/29</p>
									<p class="tag">
										<span>チーム活動</span>
									</p>
									<div class="title">
										<p class="article">今日のわんこ
											ぼたもち。2歳。ガルク。カムラの里で、どちらさんと暮らしています。</p>
										<p class="name">占部</p>
									</div>
							</a></li>
							<li class="item"><a href="#">
									<p class="date">2025/06/28</p>
									<p class="tag">
										<span>チーム活動</span>
									</p>
									<div class="title">
										<p class="article">今日のわんこ
											エクレア。3歳。ガルク。カムラの里で、そなたさんと暮らしています。</p>
										<p class="name">月向</p>
									</div>
							</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>