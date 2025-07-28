<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.ArrayList,java.util.Map,java.util.LinkedHashMap,bean.User"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>



<%
    // サーブレットから渡されたuserListを取得
    ArrayList<User> userList = (ArrayList<User>) request.getAttribute("userList");

    // JSPの上部で、userListから重複しないチームのリスト（Map）を作成
    // Map<キーの型, 値の型>
    Map<Integer, String> teamMap = new LinkedHashMap<>();
    if (userList != null) {
        for (User user : userList) {
            teamMap.put(user.getDepartmentId(), "tst" + user.getDepartmentId());
        }
    }
    pageContext.setAttribute("teamMap", teamMap);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>個人目標一覧</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<script src="${pageContext.request.contextPath}/js/script.js "></script>

<script>
window.onload = function() {
    const selectionGroup = document.getElementById('departmentKing');

    const allCheckboxes = selectionGroup.querySelectorAll('input[type="checkbox"]');

    const allPanels = document.querySelectorAll('.nonee');

    allCheckboxes.forEach(function(checkbox) {
        checkbox.addEventListener('change', function() {
            const checkedValues = Array.from(allCheckboxes)
                                       .filter(i => i.checked) 
                                       .map(i => i.value);     

            allPanels.forEach(function(panel) {
                if (checkedValues.includes(panel.id)) {
                    panel.style.display = 'block';
                } else {
                    panel.style.display = 'none';
                }
            });
        });
    });
};
</script>
<style>

/* 個人目標のCSS */
#goalTitle {
	position: relative;
	margin-top: 100px;
	margin-bottom: 10px;
	width: 80%;
	border-radius: 30px;
	background-color: #ffffff;
	box-shadow: 1px 2px 5px #CCCCEE;
	font-size: 20px;
	text-align: center;
}

.select01 {
	position: relative;
	display: flex;
	justify-content: center;
	flex-direction: column;
	margin: 2em auto;
}

.select01 .sl {
	position: relative;
	width: 5%;
	height: 48px;
	cursor: pointer;
	text-overflow: ellipsis;
	z-index: 1;
	border: none;
	appearance: none;
	outline: none;
	background: transparent; /* 背景に透明にする設定 */
	border-radius: 0;
	border-bottom: 1px solid #666666; /* 下線表示 */
}
/*プルダウンの三角を設定*/
/*.select01::after {
	position: absolute;
	left: 60px;
	content: '';  
	width: 16px;
	height: 8px;
	background: #666666;
	clip-path: polygon(0 0, 100% 0, 50% 100%);  
}
*/
.sl_selectlabel {
	position: absolute;
	left: 0;
	top: 10px;
	color: #666666;
	transition: 0.2s ease all; /* アニメーション設定 */
}
/*選択した際の動き:「Choose」の文字*/
.sl:focus ~ .sl_selectlabel, .sl:valid ~.sl_selectlabel {
	color: #da3c41;
	top: -20px;
	transition: 0.2s ease all;
	font-size: 80%;
}
/*選択した際の動き:セレクト下のライン*/
.sl_selectbar {
	position: relative;
	display: block;
	width: 100%;
}

.sl_selectbar:before, .sl_selectbar:after {
	bottom: 1px;
	content: '';
	width: 0;
	height: 2px;
	position: absolute;
	background: #da3c41;
	transition: 0.2s ease all;
}

.sl_selectbar:before {
	left: 50%;
}

.sl_selectbar:after {
	right: 50%;
}
/*focus時の設定*/
.select01 .sl:focus {
	border-bottom: 1px solid transparent;
}

.sl:focus ~ .sl_selectbar:before, .sl:focus ~.sl_selectbar:after {
	width: 50%;
}

.nonee {
	display: none;
}

.content-panel table {
	border-collapse: collapse;
	width: 100%;
	margin-top: 1em;
}

.content-panel td, .content-panel th {
	border: 1px solid #000;
	padding: 8px;
	text-align: left;
}
</style>

</head>
<body>
	<div id="wrap">
		<%@ include file="../common/header.jsp"%>

		<div class="Goaltitle">
			<h1 style="text-align: center">チーム内個人目標一覧</h1>

			<div class="select01">

				<div id="departmentKing">
					<c:forEach items="${teamMap}" var="teamEntry">
						<label> <input type="checkbox" name="department_choice"
							value="panel_${teamEntry.key}" /> ${teamEntry.value}<br> 
						</label>
					</c:forEach>
				</div>

				<div>
					<c:forEach items="${teamMap}" var="teamEntry">
						<div id="panel_${teamEntry.key}" class="nonee" >
							<%-- idはMapのキー（チームID） --%>
							<h3>${teamEntry.value}チーム一覧</h3>
							<table>
								<c:forEach items="${userList}" var="user">
									<c:if test="${user.departmentId == teamEntry.key}">
										<tr>
											<a href="goalUser?id=${user.userId}">${user.name}</a>
										</tr>
									</c:if>
								</c:forEach>
							</table>
						</div>
					</c:forEach>
				</div>
			</div>

		</div>
	</div>

	




</body>
</html>