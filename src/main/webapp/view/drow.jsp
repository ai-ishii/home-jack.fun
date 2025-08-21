<!-- 
 自分が落書きするための画面です

 作成者：占部虎司郎
 更新者：

 作成日：8月21日
 最終更新日：0月0日
 -->

<html>
<style>
@import url('https://fonts.googleapis.com/css2?family=M+PLUS+1p&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Yusei+Magic&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Kosugi+Maru&display=swap');
@import url('https://fonts.googleapis.com/css2?family=BIZ+UDPGothic&display=swap');

/* aタグの初期CSSのリセット(左) */
.jackResetL{
text-decoration: none;
color: #000;
}

/* aタグの初期CSSのリセット(右) */
.jackResetR{
text-decoration: none;
color: #000;
}

/* 矢印の枠 */
/* marginとかは自分で削ったり足したりしてくださいな */
.yoruArrow{
display: flex;
align-items: center;
height: 30px;
width: 85%;
margin: 30px auto 0;
}

/* 矢印 */
.arrow{
display: inline-block;
vertical-align: middle;
transition: transform 0.5s ease;
overflow: visible; 				/* はみ出た内容を表示させる */
}

/* 矢印文字 */
.beaf{
height: 100%;
font-family: "Yomogi", cursive;
font-size: 25px;
}

/* 矢印ホバー時の動き(左) */
.jackResetL:hover svg path {
transform: translateX(-10px);
stroke: #f9de95;
fill: #f9de95;
}

/* 矢印ホバー時の動き(右) */
.jackResetR:hover svg path {
transform: translateX(10px);
stroke: #f9de95;
fill: #f9de95;
}

</style>
<body>
<div class="yoruArrow">
	<a href="#" class="jackResetR">
		<span class="beaf">LIST</span>
		<svg class="arrow" viewBox="0 0 50 20" x="0px" y="0px" width="50"  height="20">
			<path d="M 0 10 L 50 10" stroke="#000" stroke-width="2" fill="none"/>
			<path d="M 50 10 L 25 0" stroke="#000" stroke-width="2" fill="none"/>
		</svg>
	</a>
</div>

<div class="yoruArrow">
	<a href="#" class="jackResetR">
		<span class="beaf">NEXT</span>
		<svg class="arrow" viewBox="0 0 50 20" x="0px" y="0px" width="50"  height="20">
			<path d="M 0 10 L 50 10" stroke="#000" stroke-width="2" fill="none"/>
			<path d="M 50 10 L 25 0" stroke="#000" stroke-width="2" fill="none"/>
		</svg>
	</a>
</div>

<div class="yoruArrow">
	<a href="<%=request.getContextPath()%>/goalConfirm?cmd=confirm" class="jackResetL">
		<svg class="arrow" width="50"  height="20">
			<path d="M 0 10 L 50 10" stroke="#000" stroke-width="2" fill="none"/>
			<path d="M 0 10 L 25 0" stroke="#000" stroke-width="2" fill="none"/>
		</svg>
		<span class="beaf">PREV</span>
	</a>
</div>
</body>
</html>