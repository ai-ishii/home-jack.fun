<%--
/**
 * ヘッダー画面
 * 
 * 作成者：石田允彦
 * 
 * 作成日：2025/07/03
 * 最終更新日：2025/08/26
 */
--%>

<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="bean.User, dao.UserDAO"%>
<script src="<%=request.getContextPath()%>/js/script.js"></script>

<%
//セッションでユーザーのデータを取得
String user_name = (String) session.getAttribute("user_name");

String tabCmd = (String) request.getAttribute("cmd");
%>

<style>
/* ヘッダー内のタブ（ul） */
.homeTab {
	display: flex;
	position: relative;		/*これがないとリンクが効かない（z-index関係）*/
	padding: 0;
	margin-top: 20px;
	justify-content: space-around;
}

.tabLink {
	padding-top: 10px;
	padding-bottom: 10px;
	border-top: solid 1px white;
	text-align: center;
	text-decoration: none;
	color: white;
	flex-grow: 1;
}

.tabLink:hover {
	background-color: rgba(0, 0, 0, 0.2);
	cursor: pointer;
}

.homeTab li {
	list-style: none;
}

/* 最後の要素（liの右端）以外のすべてに区切り線 */
.tabLink:not(:last-child) {
	border-right: solid 1px white;
}
</style>

<body>
	<header class="container">

		<div id="menu" class="container">
			<nav id="navi">
				<ul id="header-menu">
					<li><%=user_name%> <a
						href="<%=request.getContextPath()%>/announce"><p
								class="cheese">お知らせ</p></a></li>
					<li><a href="<%=request.getContextPath()%>/employee"><p
								class="tomato">社員紹介</p></a></li>
					<li><a
						href="<%=request.getContextPath()%>/goalConfirm?cmd=confirm"><p
								class="lettuce">個人目標確認</p></a></li>
					<li><a href="<%=request.getContextPath()%>/monthJackworks"><p
								>Jackworks</p></a></li>
					<li><a href="<%=request.getContextPath()%>/view/RequestMenu.jsp"><p
								 class="lettuce" >申請一覧</p></a></li>
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
					<li><a href="<%= request.getContextPath() %>/userDetail"><p
								class="pickles">社員情報詳細</p></a></li>
					<li><a href="<%=request.getContextPath()%>/home"><p
								class="pickles">ホームに戻る</p></a>
						<ul class="pickles-detail">
							<li>wuu</li>
							<li>wii</li>
						</ul></li>
					<li><a href="<%=request.getContextPath()%>/logout"><p
								class="pickles">ログアウト</p></a></li>
				</ul>


			</nav>
			<div class="navi-close"></div>
			<%
			if (user_name != null) {
			%>
			<div id="hamburger" class="hamburger">
				<span></span><span></span><span></span>
			</div>
			<%
			}
			%>

			<div id="page-title">

				<div class="header-title">
					<a id="home-link" href="<%=request.getContextPath()%>/home">
						<h6>
							<small>満足を超える、感動を贈りたい</small>
						</h6>
						<h1>HOME JACK</h1>
					</a>
				</div>

				<div id="top-link" class="container">
					<ul>
						<li><a href="https://www.dream-jack.com/" target="_blank">
								<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="32" height="32" viewBox="-10 -10 70 70">
  <defs>
    <linearGradient id="linear-gradient" x1="1.109" y1="0.737" x2="-2.119" y2="-0.518" gradientUnits="objectBoundingBox">
      <stop offset="0.002" stop-color="#fff"/>
      <stop offset="0.073" stop-color="#fff"/>
      <stop offset="0.154" stop-color="#fff"/>
      <stop offset="0.25" stop-color="#fff"/>
      <stop offset="0.369" stop-color="#fff"/>
      <stop offset="0.536" stop-color="#fff"/>
      <stop offset="1" stop-color="#fff"/>
    </linearGradient>
    <linearGradient id="linear-gradient-2" x1="0.863" y1="0.904" x2="0.017" y2="0.046" xlink:href="#linear-gradient"/>
  </defs>
  <g id="グループ_46436" data-name="グループ 46436" transform="translate(-82 -46)">
    <g id="グループ_46435" data-name="グループ 46435" transform="translate(89.624 55.842)">
      <path id="パス_43358" data-name="パス 43358" d="M370.76,403.743l-10.5-5.036a2.142,2.142,0,0,1-1.357-1.851V386.318c0-1.745,2.595-2.8,4.565-1.853l10.5,5.036a2.439,2.439,0,0,1,1.357,2.389v10C375.323,403.635,372.73,404.688,370.76,403.743Z" transform="translate(-349.028 -359.184)" fill="url(#linear-gradient)"/>
      <path id="パス_43359" data-name="パス 43359" d="M384.5,394.19v17.2a4.593,4.593,0,0,0,.216,1.8,2.029,2.029,0,0,0,3.021.638c.247-.165.493-.331.732-.5.173-.126.38-.279.615-.459.141-.107.279-.215.418-.323.187-.147.386-.307.59-.475a20.71,20.71,0,0,0,3.076-3l0-.006a23.358,23.358,0,0,0,5.788-13.742c.984-14.522-12.449-26.64-28.847-26.64H357.64a4.55,4.55,0,0,0-4.851,4.494V400.72a2.407,2.407,0,0,0,2.407,2.409h0a2.41,2.41,0,0,0,2.409-2.409v-7.451c0-2.013.8-3.643,3.643-3.643h17.63S384.5,389.009,384.5,394.19Z" transform="translate(-352.789 -368.681)" fill="url(#linear-gradient-2)"/>
    </g>
    <rect id="長方形_4184" data-name="長方形 4184" width="32" height="32" transform="translate(82 46)" fill="none"/>
  </g>
</svg>

						</a></li>
						<li><a href="https://www.facebook.com/enjoydreamjack/"
							target="_blank"> 
							<svg xmlns="http://www.w3.org/2000/svg" viewBox="10 -80 680 680" width="32" height="32" fill="#fff" stroke="#fff">
							<!--!Font Awesome Free v7.0.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.-->
							<path d="M576 320C576 178.6 461.4 64 320 64C178.6 64 64 178.6 64 320C64 440 146.7 540.8 258.2 568.5L258.2 398.2L205.4 398.2L205.4 320L258.2 320L258.2 286.3C258.2 199.2 297.6 158.8 383.2 158.8C399.4 158.8 427.4 162 438.9 165.2L438.9 236C432.9 235.4 422.4 235 409.3 235C367.3 235 351.1 250.9 351.1 292.2L351.1 320L434.7 320L420.3 398.2L351 398.2L351 574.1C477.8 558.8 576 450.9 576 320z"/></svg>
						</a></li>
						<li><a href="https://x.com/dreamjackgames" target="_blank">
								<svg width="25" height="25" viewBox="0 0 1200 1227" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M714.163 519.284L1160.89 0H1055.03L667.137 450.887L357.328 0H0L468.492 681.821L0 1226.37H105.866L515.491 750.218L842.672 1226.37H1200L714.137 519.284H714.163ZM569.165 687.828L521.697 619.934L144.011 79.6944H306.615L611.412 515.685L658.88 583.579L1055.08 1150.3H892.476L569.165 687.854V687.828Z" fill="white"/>
</svg>

						</a></li>
						<li><a href="https://www.youtube.com/@ドリームジャックゲームズ"
							target="_blank"> 
  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 -60 600 600" width="32" height="32" fill="#fff" stroke="#fff">
  <!--!Font Awesome Free v7.0.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.-->
  <path d="M581.7 188.1C575.5 164.4 556.9 145.8 533.4 139.5C490.9 128 320.1 128 320.1 128C320.1 128 149.3 128 106.7 139.5C83.2 145.8 64.7 164.4 58.4 188.1C47 231 47 320.4 47 320.4C47 320.4 47 409.8 58.4 452.7C64.7 476.3 83.2 494.2 106.7 500.5C149.3 512 320.1 512 320.1 512C320.1 512 490.9 512 533.5 500.5C557 494.2 575.5 476.3 581.8 452.7C593.2 409.8 593.2 320.4 593.2 320.4C593.2 320.4 593.2 231 581.8 188.1zM264.2 401.6L264.2 239.2L406.9 320.4L264.2 401.6z"/></svg>
						</a></li>
						<li><a href="https://www.instagram.com/dreamjack_official/"
							target="_blank"> 
							<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 -65 640 640" width="32" height="32" fill="#fff" stroke="#fff">
							<!--!Font Awesome Free v7.0.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.-->
							<path d="M320.3 205C256.8 204.8 205.2 256.2 205 319.7C204.8 383.2 256.2 434.8 319.7 435C383.2 435.2 434.8 383.8 435 320.3C435.2 256.8 383.8 205.2 320.3 205zM319.7 245.4C360.9 245.2 394.4 278.5 394.6 319.7C394.8 360.9 361.5 394.4 320.3 394.6C279.1 394.8 245.6 361.5 245.4 320.3C245.2 279.1 278.5 245.6 319.7 245.4zM413.1 200.3C413.1 185.5 425.1 173.5 439.9 173.5C454.7 173.5 466.7 185.5 466.7 200.3C466.7 215.1 454.7 227.1 439.9 227.1C425.1 227.1 413.1 215.1 413.1 200.3zM542.8 227.5C541.1 191.6 532.9 159.8 506.6 133.6C480.4 107.4 448.6 99.2 412.7 97.4C375.7 95.3 264.8 95.3 227.8 97.4C192 99.1 160.2 107.3 133.9 133.5C107.6 159.7 99.5 191.5 97.7 227.4C95.6 264.4 95.6 375.3 97.7 412.3C99.4 448.2 107.6 480 133.9 506.2C160.2 532.4 191.9 540.6 227.8 542.4C264.8 544.5 375.7 544.5 412.7 542.4C448.6 540.7 480.4 532.5 506.6 506.2C532.8 480 541 448.2 542.8 412.3C544.9 375.3 544.9 264.5 542.8 227.5zM495 452C487.2 471.6 472.1 486.7 452.4 494.6C422.9 506.3 352.9 503.6 320.3 503.6C287.7 503.6 217.6 506.2 188.2 494.6C168.6 486.8 153.5 471.7 145.6 452C133.9 422.5 136.6 352.5 136.6 319.9C136.6 287.3 134 217.2 145.6 187.8C153.4 168.2 168.5 153.1 188.2 145.2C217.7 133.5 287.7 136.2 320.3 136.2C352.9 136.2 423 133.6 452.4 145.2C472 153 487.1 168.1 495 187.8C506.7 217.3 504 287.3 504 319.9C504 352.5 506.7 422.6 495 452z"/></svg>
						</a></li>
						<li><a href="https://www.tiktok.com/@dreamjack_officia"
							target="_blank"> 
							<svg xmlns="http://www.w3.org/2000/svg" viewBox="30 -60 640 640" width="32" height="32" fill="#fff" stroke="#fff">
							<!--!Font Awesome Free v7.0.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.-->
							<path d="M544.5 273.9C500.5 274 457.5 260.3 421.7 234.7L421.7 413.4C421.7 446.5 411.6 478.8 392.7 506C373.8 533.2 347.1 554 316.1 565.6C285.1 577.2 251.3 579.1 219.2 570.9C187.1 562.7 158.3 545 136.5 520.1C114.7 495.2 101.2 464.1 97.5 431.2C93.8 398.3 100.4 365.1 116.1 336C131.8 306.9 156.1 283.3 185.7 268.3C215.3 253.3 248.6 247.8 281.4 252.3L281.4 342.2C266.4 337.5 250.3 337.6 235.4 342.6C220.5 347.6 207.5 357.2 198.4 369.9C189.3 382.6 184.4 398 184.5 413.8C184.6 429.6 189.7 444.8 199 457.5C208.3 470.2 221.4 479.6 236.4 484.4C251.4 489.2 267.5 489.2 282.4 484.3C297.3 479.4 310.4 469.9 319.6 457.2C328.8 444.5 333.8 429.1 333.8 413.4L333.8 64L421.8 64C421.7 71.4 422.4 78.9 423.7 86.2C426.8 102.5 433.1 118.1 442.4 131.9C451.7 145.7 463.7 157.5 477.6 166.5C497.5 179.6 520.8 186.6 544.6 186.6L544.6 274z"/></svg>
						</a></li>
					</ul>
				</div>

				<ul class="homeTab">
					<a class="tabLink" href="<%=request.getContextPath()%>/announce"><li>お知らせ</li></a>
					<a class="tabLink" href="<%=request.getContextPath()%>/employee"><li>社員紹介</li></a>
					<a class="tabLink" href="<%=request.getContextPath()%>/goalConfirm?cmd=confirm"><li>個人目標</li></a>
					<a class="tabLink" href="<%=request.getContextPath()%>/monthJackworks"><li>Jackworks</li></a>
					<a class="tabLink" href="<%=request.getContextPath()%>/view/RequestMenu.jsp"><li>各種申請</li></a>
					<a class="tabLink" href="<%=request.getContextPath()%>/view/sharedMaterials.jsp"><li>共有資料</li></a>
				</ul>

			</div>

			<div class="jump">
				<a href="#"
					onclick="{window.scrollTo({top: 0, left: 0, behavior: 'smooth'})}; return false;"><p>
						▲<br>ページトップ
					</p></a>
			</div>


		</div>
	</header>
	
	<script>
	// 変数受け渡し
	const user_name = "<%= user_name %>";
	const cmd = "<%= tabCmd %>";

	// 必要な要素を取得
	const homeTab = document.querySelector(".homeTab");

	// cmdが エラーから来たとき、ログイン画面から来たとき、セッションが切れているとき はタブを非表示
	if (cmd == "logout" || cmd == "login" || cmd == "index" || user_name == null) {
		homeTab.style.display = "none";
	}
	// cmd分けが多すぎるのでif文も分けてます
	if (cmd == "announce" || cmd == "employee" || cmd == "goal" || cmd == "monthJackworks" || 
		cmd == "licenseList" || cmd == "licenseRequest" || cmd == "userList") {
		homeTab.style.display = "none";
	}

	console.log(cmd);
	</script>
</body>