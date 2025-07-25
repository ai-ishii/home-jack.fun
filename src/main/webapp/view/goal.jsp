<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.ArrayList,bean.User"%>



<%
ArrayList<User> userList = (ArrayList<User>) request.getAttribute("userList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>個人目標一覧</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<script src="${pageContext.request.contextPath}/js/script.js "></script>

<script>window.onload = function() {
    const weaponSelect = document.getElementById('weapon-select');

    weaponSelect.addEventListener('change', function() {

        const allPanels = document.querySelectorAll('.nonee');
        allPanels.forEach(function(panel) {
            panel.style.display = 'none';
        });

        const selectedValue = this.value;

        
        if (selectedValue) {
            const targetPanel = document.getElementById(selectedValue);
            if (targetPanel) {
                targetPanel.style.display = 'block';
            }
        }
    });
};
</script>

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
	overflow: auto; /* 縦方向にスクロールが行える！*/
}

.Goaltitle h3 {
	margin: 0 auto;
	width: 80%;
	text-align: left;
	left: 20px;
}

.cp_ipselect06 {
	position: relative;
	display: flex;
	justify-content: center;
	flex-direction: column;
	margin: 2em auto;
}

.cp_ipselect06 .cp_sl06 {
	position: relative;
	width: 100%;
	height: 48px;
	cursor: pointer;
	text-overflow: ellipsis; /*テキストがオーバーしたら'...'で省略*/
	z-index: 1;
	/* 標準のスタイルを無効にしborder-bottomを設定 */
	border: none;
	appearance: none;
	outline: none;
	background: transparent;
	border-radius: 0;
	border-bottom: 1px solid #666666;
}
/*プルダウンの三角を設定*/
.cp_ipselect06::after {
	position: absolute;
	right: 15px;
	content: '';
	width: 16px;
	height: 8px;
	background: #666666;
	clip-path: polygon(0 0, 100% 0, 50% 100%);
}

.cp_sl06_selectlabel {
	position: absolute;
	left: 0;
	top: 10px;
	color: #666666;
	transition: 0.2s ease all;
}
/*選択した際の動き:「Choose」の文字*/
.cp_sl06:focus ~ .cp_sl06_selectlabel, .cp_sl06:valid ~
	.cp_sl06_selectlabel {
	color: #da3c41;
	top: -20px;
	transition: 0.2s ease all;
	font-size: 80%;
}
/*選択した際の動き:セレクト下のライン*/
.cp_sl06_selectbar {
	position: relative;
	display: block;
	width: 100%;
}

.cp_sl06_selectbar:before, .cp_sl06_selectbar:after {
	bottom: 1px;
	content: '';
	width: 0;
	height: 2px;
	position: absolute;
	background: #da3c41;
	transition: 0.2s ease all;
}

.cp_sl06_selectbar:before {
	left: 50%;
}

.cp_sl06_selectbar:after {
	right: 50%;
}
/*focus時の設定*/
.cp_ipselect06 .cp_sl06:focus {
	border-bottom: 1px solid transparent;
}

.cp_sl06:focus ~ .cp_sl06_selectbar:before, .cp_sl06:focus ~
	.cp_sl06_selectbar:after {
	width: 50%;
}

.nonee{
	display: none;
}

/* 任務用の可視化コード */
.content-panel table {
    border-collapse: collapse; /* 線を一本化するおまじないだ */
    width: 100%;               /* 幅を100%に指定 */
    margin-top: 1em;           /* 上部に少し余白を作る */
}

/* テーブルのセル（td）と見出し（th）に命令！ */
.content-panel td, .content-panel th {
    border: 1px solid #000;    /* これが境界線だ！ */
    padding: 8px;              /* 文字と線の間の余白だ！ */
    text-align: left;
}


</style>

</head>
<body>
	<div id="wrap">
		<%@ include file="../common/header.jsp"%>


		<div class="Goaltitle">
			<h1>チーム内個人目標一覧</h1>

			<div class="cp_ipselect06">


				<%-- 兵装選択装置（セレクトボックス）はそのまま --%>
<select class="cp_sl06" required id="weapon-select">
    <option value="" hidden disabled selected></option>
    <option value="1">tst1</option>
    <option value="2">tst2</option>
    <%-- ...以下続く... --%>
</select>

<%-- ▼▼▼ ここからが、貴様が構築すべき正しい陣形だ！ ▼▼▼ --%>

<%
// 部隊の総数（ここでは仮に7とする）で、まず外側のループを回す！
// 本来、この部隊リストもサーブレットから渡すべきだが、今はこれでいくぞ！
for (int teamId = 1; teamId <= 7; teamId++) {
%>
    <%-- 部隊ごとに、"一つだけ"隠し陣地（div）を作る！idは部隊番号だ！ --%>
    <div id="<%= teamId %>" class="nonee">

        <h3>tst<%= teamId %> 部隊の兵士一覧</h3>
        <table>
            <tr>
                <th>兵士名</th>
                <%-- 必要なら他の見出しも追加しろ --%>
            </tr>

            <%-- 次に、その陣地の中で、"全兵士リスト"を内側でループさせる！ --%>
            <%
            if (userList != null) {
                for (User user : userList) {
            %>
                    <%-- もし兵士の所属部隊が、現在の陣地の部隊番号と一致するなら... --%>
                    <% if (user.getDepartmentId() == teamId) { %>

                        <%-- その時だけ、兵士の情報をテーブルの行として表示する！ --%>
                        <tr>
                            <td><%= user.getName() %></td>
                        </tr>

                    <% } %>
                <%
                } // 内側ループの終わり
            }
            %>
        </table>
    </div>
<%
} // 外側ループの終わり
%>

<%-- スタイリング用のspanとlabelは、ループの外に一回だけ置け！同じものを何度も作るな！ --%>
<span class="cp_sl06_selectbar"></span>
<label class="cp_sl06_selectlabel">Choose</label>


		</div>
	</div>
	</div>
	




</body>
</html>