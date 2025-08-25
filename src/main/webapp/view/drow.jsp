<%@page contentType="text/html; charset=UTF-8"%>

<html>
<head>
<!-- タイトル -->
<title>お絵描き</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
<script src="<%=request.getContextPath()%>/js/script.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<style>
@import url('https://fonts.googleapis.com/css2?family=M+PLUS+1p&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Yusei+Magic&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Kosugi+Maru&display=swap');
@import url('https://fonts.googleapis.com/css2?family=BIZ+UDPGothic&display=swap');

/* 以下矢印付きボタンのCSS */
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

/* 以下画像変更ボタンのCSS */
/* 画像変更ボタンの大枠 */
.photoFrame{
display: flex;
justify-content: flex-end;
width:200px;
height: 50px;
margin: auto;
}

/* 画像変更ボタン */
.photoButton{
display: inline-block;
display: flex;         /* 子要素をFlexboxで配置 */
border-radius: 5px;
text-decoration: none;			/* 下線を消す */
cursor: pointer; 				/* マウスカーソルをポインターにする */
border: 8px solid #e19dbe;
height: 100%;
align-items: center;
}

/* 画像アイコンボックス */
.photoBox{
display: flex;             /* Flexboxを有効にする */
justify-content: center;   /* 水平方向の中央揃え */
align-items: center;       /* 垂直方向の中央揃え */
border: 3px solid #fff;
background-color: #e19dbe;
height: 35px;
border-radius: 3px;
padding: 5px 5px;
margin: 0;
}

/* 画像アイコン */
.photoIcon{
display: inline-block;
vertical-align: middle;
stroke: #fff;
fill: #fff;
transition: .5s;
}

/* 画像変更の文字 */
.photoText{
display: flex;             /* Flexboxを有効にする */
justify-content: center;   /* 水平方向の中央揃え */
align-items: center;       /* 垂直方向の中央揃え */
background-color: #e19dbe;
height: 35px;
font-size:25px;
border: 3px solid #fff;
border-radius: 3px;
padding: 5px 5px;
margin: 0;
color: #fff;
transition: .5s;
}

/* 画像変更ボタンホバーアニメ */
.photoFrame:hover .photoIcon{
transform: rotateX(360deg);
}

/* ボタンクリック時のアニメ */
.photoFrame:active .photoButton{
	background-position: center center;
	background-size: 100% 100%;
	-webkit-animation: pulse 2s;
	animation: ripple 0.4s;
	color: #fff;
}

/* 広がる破門アニメ */
@keyframes ripple {
  0% {box-shadow: 0 0 0 0 #e47cae}
  70% {box-shadow: 0 0 0 10px rgb(228 124 174 / 0%);}
  100% {box-shadow: 0 0 0 0 rgb(228 124 174 / 0%);}
}


/* 編集ボタンだよ */
/* 編集ボタンの大枠 */
.editBox{
width:85%;
margin: 10px auto 0;
display: flex;
justify-content: flex-end;
}

/* 編集ボタンデザイン */
.editButton{
display: inline-block;			 /* パディングや幅を設定できるようにする */
padding: 8px 16px;
background-color: #6eddb3;
border: 3px solid #6eddb3;
/* 丸形の場合 */
/*
border-radius: 30px;
padding: 9px 25px;
*/
/* 四角型の場合 */
border-radius: 5px;
text-decoration: none;			/* 下線を消す */
text-align: center; 			/* テキストを中央揃えにする */
cursor: pointer; 				/* マウスカーソルをポインターにする */
align-items: center;
}

/* アイコン */
.memo{
display: inline-block;
vertical-align: middle;
stroke: #fff;
fill: #fff;
}

/* ボタンの文字 */
.editText{
vertical-align: middle;
font-family: "Kosugi Maru", sans-serif;
font-size: 21px;
font-weight: 300;
color: #fff;
}

.editButton:hover{
background-color: #fff;
border: 3px solid #6eddb3;
}

.editButton:hover .memo{
stroke: #6eddb3;
fill: #6eddb3;
}

.editButton:hover .editText{
color: #6eddb3;
}

/* 以下ファイルアップロードのボタンです */
/* ファイル選択ボタンを完全に非表示にする */
input[type="file"] {
  display: none;
}

/* ファイルボタンの大枠 */
.fileFrame{
display: flex;
justify-content: flex-end;
width: 230px;
height: 50px;
margin: auto;
}

/* ファイルボタン */
.fileUp{
display: flex;
justify-content: center;   /* 水平方向の中央揃え */
align-items: center;       /* 垂直方向の中央揃え */
padding: 0;
border: 3px solid #000;
color: #fff;
text-decoration: none;
border-radius: 5px;
transform: skewX(-5deg); /* ボタンを傾ける */
cursor: pointer; 
background-color: #7f8c8d;
transition: .5s;
}

/* ファイルアイコンのボックス */
.fileBox{
display: flex;
justify-content: center;   /* 水平方向の中央揃え */
align-items: center;       /* 垂直方向の中央揃え */
border-right: 8px double #000;
height: 100%;
width: 15%;
padding: 0 5px;
}

/* ファイルアイコン */
.fileIcon{
display: inline-block;
vertical-align: middle;
stroke: #fff;
fill: #fff;
transition: .5s;
}

/* ファイルのテキストボックス */
.imageTextBox{
display: flex;
justify-content: center;   /* 水平方向の中央揃え */
align-items: center;       /* 垂直方向の中央揃え */
height: 100%;
width: 85%;
padding: 0 5px;
}

/* ファイルの文字 */
.imageText{
display: flex;
font-size: 13px;
font-style: italic;
}

.fileUp:hover{
color: #7f8c8d;
background-color: #fff;
}

.fileUp:hover .fileIcon{
stroke: #7f8c8d;
fill: #7f8c8d;
}

.fileUp:active .fileIcon{
transform: rotateY(360deg);
animation: rotate 3s forwards;
}


/* オレンジ小見出し */
.yorushika{
font-size: 22px;
color: #e89b17;
margin-left: 10px;
margin-right: auto;
margin-bottom: 2px;
}

/* 小見出し用の縦線 */
.yorushikaStripe{
display: flex;
justify-content: center;   /* 水平方向の中央揃え */
align-items: center;
border-left: 5px solid #ff8b4d;
}

/* 黒小見出し */
.subBlack{
font-size: 22px;
color: #363636;
margin-left: 10px;
margin-right: auto;
margin-bottom: 2px;
}

/* グレーの縦線 */
.nintendoStripe{
display: flex;
justify-content: center;   /* 水平方向の中央揃え */
align-items: center;
border-left: 5px solid #aaaaaa;
}

</style>

<body>
	<div id="wrap">
		<!-- ヘッダー部分 -->
		<%@ include file="../common/header.jsp"%>

		<!-- メイン部分 -->
		<div id="main" class="container">
		
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


<div class="yorushikaStripe">
	<div class="yorushika">がんばって</div>
</div>

<div class="nintendoStripe">
	<div class="subBlack">げんきだして</div>
</div>



<div class="photoFrame">
<a class="photoButton" href="#">
<div class="photoBox">
<svg xmlns="http://www.w3.org/2000/svg" x="2px" y="2px" viewBox="1 1 45 45" width="35"  height="35" class="photoIcon">
<defs>
<style>.a,.b{fill:none;}.b{stroke-linecap:round;stroke-linejoin:round;stroke-width:2px;}
</style>
</defs>
<title>454_ca_h</title>
<rect class="a" width="48" height="48"/>
<rect class="b" x="3" y="3" width="42" height="42" rx="4" ry="4"/>
<polyline class="b" points="3 36 18.09 20.91 27.57 30.39 33.88 24.08 45 35"/>
<circle class="b" cx="31" cy="14" r="4"/>
</svg>
</div>
<div class="photoText">画像変更</div>
</a>
</div>


<div class="editBox">
<a class="editButton" onclick="location.href='<%=request.getContextPath()%>/goalConfirm?cmd=update'">
<svg class="memo" version="1.1" id="_x31_0" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 512 512" style="width: 25px; height: 25px; opacity: 1;" xml:space="preserve">
	<g>
	<path d="M453.394,226.605v-0.226l-61.477,61.477v160.535c0,0.766-0.847,1.614-1.613,1.614H222.746L62.75,449.852
		l-0.352-0.156c-0.305-0.078-0.614-0.387-0.922-1.305V121.176c0-0.847,0.77-1.613,1.613-1.613h162.684l35.969-35.969l25.508-25.348
		h-0.161l0.161-0.16H63.09C28.282,58.086,0,86.364,0,121.176v327.215c0,15.211,5.535,29.969,15.371,41.11
		c0.77,0.926,1.703,1.691,2.527,2.562c0.461,0.484,0.93,0.957,1.394,1.41c0.809,0.786,1.508,1.68,2.375,2.406
		c11.453,10.066,26.133,15.602,41.422,15.602h327.215c34.809,0,63.09-28.281,63.09-63.09V318.422l0.114-91.93L453.394,226.605z" >
	</path>
	<path d="M505.711,84.672L427.855,6.812c-4.062-4.058-9.402-6.297-15.027-6.293c-5.332-0.004-10.309,2.039-14.011,5.742
		L153.25,251.828l-41.231,132.054c-1.453,4.645-0.152,9.715,3.375,13.246c2.523,2.527,5.942,3.973,9.39,3.973
		c1.305,0,2.602-0.199,3.864-0.59l132.054-41.234L506.27,113.715C514.125,105.86,513.871,92.832,505.711,84.672z M269.23,310.567
		c-1.469-4.18-3.73-8.055-6.66-11.348l168.629-168.625l9.051,9.05L320.871,259.024L269.23,310.567z M246.539,333.356l-0.946,0.946
		l-79.058,24.683l-12.988-12.992l24.683-79.058l0.946-0.942l10.878-0.57c2.883-0.152,5.602,0.886,7.645,2.93
		c2.039,2.039,3.078,4.754,2.926,7.641c-0.5,9.656,3.126,19.11,9.965,25.942c6.836,6.839,16.294,10.469,25.946,9.969
		c2.882-0.157,5.598,0.894,7.649,2.945c2.034,2.031,3.074,4.742,2.926,7.625L246.539,333.356z M201.938,243.227l170.946-170.95
		l9.054,9.055L213.313,249.953c-2.852-2.527-6.176-4.442-9.703-5.898C203.039,243.793,202.523,243.469,201.938,243.227z
		 M235.278,287.828c-2.887,0.148-5.602-0.891-7.645-2.938c-2.039-2.039-3.078-4.754-2.93-7.641
		c0.207-3.977-0.293-7.953-1.457-11.758l171.43-171.426l23.781,23.785l-171.43,171.426
		C243.23,288.113,239.25,287.613,235.278,287.828z M385.625,59.543l27.438-27.441l67.363,67.367l-27.438,27.437L385.625,59.543z" >
		</path>
	</g>
</svg>
<span class="editText">編集</span>
</a>
</div>

<div class="fileFrame">
<label for="file-upload" class="fileUp">
<div class="fileBox">
<svg x="0px" y="0px" viewBox="-4 4 70 40" width="22"  height="22" class="fileIcon">
<path d="M 30 2 L 30 42" stroke-width="3" fill="none" stroke-linecap="round"/>
<path d="M 30 42 L 30 45" stroke-width="3" fill="none"/>
<path d="M 30 2 L 13 18" stroke-width="3" fill="none"/>
<path d="M 30 2 L 47 18" stroke-width="3" fill="none"/>
<path d="M 0 35 L 0 55" stroke-width="3.5" fill="none"/>
<path d="M 0 55 L 60 55" stroke-width="3.5" fill="none"/>
<path d="M 60 55 L 60 35" stroke-width="3.5" fill="none"/>
</svg>
</div>
<div class="imageTextBox">
<span class="imageText">画像アップロード</span>
</div>
</label>
<input id="file-upload" type="file" />
</div>

		
		</div>
	</div>
</body>
</html>