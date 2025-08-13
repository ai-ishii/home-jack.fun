<%--
/**
 * ヘッダー画面
 * 
 * 作成者：石田允彦
 * 
 * 作成日：2025/07/03
 * 最終更新日：2025/08/12
 */
--%>

<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="bean.User, dao.UserDAO" %>
<script src="<%=request.getContextPath()%>/js/script.js"></script>

<%

//セッションでユーザーのデータを取得
String user_name = (String)session.getAttribute("user_name");

%>

<body>
	<header class="container">

		<div id="menu" class="container">
			<nav id="navi">
				<ul id="header-menu">
					<li>
					<%=user_name %>
						<a href="<%= request.getContextPath() %>/announce"><p class="cheese">お知らせ</p></a>
					</li>
					<li>
						<a href="<%= request.getContextPath() %>/employee"><p class="tomato">社員紹介</p></a>
					</li>
					<li>
						<a href="<%= request.getContextPath() %>/goalConfirm"><p class="lettuce">個人目標確認</p></a>
					</li>
					<li>
						<a href="<%= request.getContextPath() %>/selectboxtest"><p class="lettuce">個人目標一覧（テスト用）</p></a>
					</li>
					<li>
						<p class="ketchup">申請</p>
						<ul class="ketchup-detail">
							<li>
								<a href="<%= request.getContextPath() %>/jackworksSearch">社員紹介</a>
							</li>
							<li>wii</li>
						</ul>
					</li>
					<li>
						<p class="egg">お役立ち</p>
						<ul class="egg-detail">
							<li>waa</li>
							<li>wii</li>
						</ul>
					</li>
					<li>
						<p class="patty">お問い合わせ</p>
						<ul class="patty-detail">
							<li>waa</li>
							<li>wii</li>
						</ul>
					</li>
					<li>
						<a href="<%= request.getContextPath() %>/home"><p class="pickles">ホームに戻る</p></a>
						<ul class="pickles-detail">
							<li>wuu</li>
							<li>wii</li>
						</ul>
					</li>
					<li>
						<a href="<%= request.getContextPath() %>/logout"><p class="pickles">ログアウト</p></a>
					</li>
				</ul>
				

			</nav>
			<div class="navi-close">
			</div>
			<%
			if (user_name != null){
			%>
			
			
				<div id="hamburger" class="hamburger">
					<span></span><span></span><span></span>
				</div>
			
			<%
			}
			%>
			
			<div id="page-title">
				
				 <div class="header-title">
					 <a id="home-link" href="<%= request.getContextPath() %>/home">
						<h6>
							<small>満足を超える、感動を贈りたい</small>
						</h6>
						<h1>HOME JACK</h1>
					</a>
				</div>
				
			</div>
			


			<div id="top-link" class="container">
				<ul>
					<li><a href="https://www.dream-jack.com/" target="_blank">
						<img src="<%= request.getContextPath() %>/img/Dreamjack_Logo.png" alt="ドリームジャックHP">
					</a></li>
					<li><a href="https://www.facebook.com/enjoydreamjack/" target="_blank">
					<img src="<%= request.getContextPath() %>/img/Facebook_Logo.png" alt="Facebook">
					</a></li>
					<li><a href="https://x.com/dreamjackgames" target="_blank">
						<img src="<%= request.getContextPath() %>/img/X_Logo.png" alt="X">
					</a></li>
					<li><a href="https://www.youtube.com/@ドリームジャックゲームズ" target="_blank">
						<img src="<%= request.getContextPath() %>/img/Youtube_Logo.png" alt="Youtube">
					</a></li>
					<li><a href="https://www.instagram.com/dreamjack_official/" target="_blank">
						<img src="<%= request.getContextPath() %>/img/Instagram_Logo.png" alt="Instagram">
					</a></li>
					<li><a href="https://www.tiktok.com/@dreamjack_officia" target="_blank">
						<img src="<%= request.getContextPath() %>/img/TikTok_Logo.png" alt="TikTok">
					</a></li>
				</ul>
			</div>
			
			<div class="jump">
				<a href="#" onclick="{window.scrollTo({top: 0, left: 0, behavior: 'smooth'})}; return false;" ><p>▲<br>ページトップ</p></a>
			</div>

			
		</div>
	</header>


</body>