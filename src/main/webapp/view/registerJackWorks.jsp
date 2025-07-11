<<<<<<< HEAD
<%--
JackWorks登録画面
作成者：青木美波
作成日 2025/06/20
 --%>

<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.text.SimpleDateFormat,java.util.Date,java.sql.Timestamp,java.util.ArrayList,bean.Jackworks,bean.Monthjack"%>

<%

%>

<html>
	<head>
		<title>JackWorks</title>
		<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
		
		
<style type="text/css">
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

#contents {
	width: 90%;
	margin-right: auto;
	margin-left: auto;
}

#kojiro{
margin:0 auto;
}

#JackWorks-submit{
text-align:center;
}

textarea {
  resize: none;
  width:270px;
  height:100px;
}
.warning{
color:red;
}
.dis-flex{
display:flex;
}


</style>
		
	</head>
	<body>

	<div id="contents">

	<!-- タイトル部分 -->
	<div id="link-title">
	<h1 id="link-line">JackWorks登録</h1>
	</div>
	
	<form action="<%=request.getContextPath()%>/registerJackWorks" >
	
	<table id="kojiro">
	<tr>
	<td style="display:flex">社員No<div class="warning">*</div></td>
	</tr>
	<td><input type="text" name="employeeNumber" value="" size="35"></td>
	
	<tr>
	<td style="display:flex">氏名<div class="warning">*</div></td>
	</tr>
	<td><input type="text" name="name" value="" size="35"></td>
	
	<tr>
	<td style="display:flex">カテゴリ<div class="warning">*</div></td>
	</tr>
	<td><input type="text" name="category" value="" size="35"></td>
	
	<tr>
	<td style="display:flex">評価項目<div class="warning">*</div></td>
	</tr>
	<td><textarea name="assessment" rows="" cols=""></textarea></td>
	
	<tr>
	<td style="display:flex">付与ポイント<div class="warning">*</div></td>
	</tr>
	<td><input type="text" name="point" value="" size="35"></td>
	
	<tr>
	<td style="display:flex">備考<div class="warning">*</div></td>
	</tr>
	<td><textarea name="note" rows="" cols=""></textarea></td>
	
	<tr>
	<td>案件名</td>
	</tr>
	<td><input type="text" name="project" value="" size="35"></td>
	
	<tr>
	<td>作業時期</td>
	</tr>
	<td><input type="text" name="workSeason" value="" size="35"></td>
	
	<tr>
	<td>単価</td>
	</tr>
	<td><input type="text" name="price" value="" size="35"></td>
	
	<tr>
	<td>精算</td>
	</tr>
	<td><input type="text" name="pay" value="" size="35"></td>
	
	<tr>
	<td>作業場所</td>
	</tr>
	<td><input type="text" name="workPlace" value="" size="35"></td>
	
	<tr>
	<td>作業内容</td>
	</tr>
	<td><textarea name="workContent" rows="" cols=""></textarea></td>
	
	<tr>
	<td>フェーズ</td>
	</tr>
	<td><textarea name="phase" rows="" cols=""></textarea></td>
	
	<tr>
	<td>開発言語</td>
	</tr>
	<td><textarea name="language" rows="" cols=""></textarea></td>
	
	<tr>
	<td>必要スキル</td>
	</tr>
	<td><textarea name="skill" rows="" cols=""></textarea></td>
	
	<tr>
	<td>必要人数</td>
	</tr>
	<td><input type="text" name="needPeople" value="" size="35"></td>
	
	<tr>
	<td>営業担当者</td>
	</tr>
	<td><input type="text" name="seller" value="" size="35"></td>
	
	<tr>
	<td>連絡先</td>
	</tr>
	<td><textarea name="contact" rows="" cols=""></textarea></td>
	
	<tr>
	<td>その他</td>
	</tr>
	<td><textarea name="other" rows="" cols=""></textarea></td>
	
	</table>
	
	<div id="JackWorks-submit">
	<input type="submit" value="登録">
	</div>
	</form>
	
	</body>
=======
<%--
JackWorks登録画面
作成者：青木美波
作成日 2025/06/20
 --%>

<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.text.SimpleDateFormat,java.util.Date,java.sql.Timestamp,java.util.ArrayList,bean.Jackworks,bean.Monthjack"%>

<%

%>

<html>
	<head>
		<title>JackWorks</title>
		<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
		
		
<style type="text/css">
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

#contents {
	width: 90%;
	margin-right: auto;
	margin-left: auto;
}

#kojiro{
margin:0 auto;
}

#JackWorks-submit{
text-align:center;
}

textarea {
  resize: none;
  width:270px;
  height:100px;
}
.warning{
color:red;
}
.dis-flex{
display:flex;
}


</style>
		
	</head>
	<body>

	<div id="contents">

	<!-- タイトル部分 -->
	<div id="link-title">
	<h1 id="link-line">JackWorks登録</h1>
	</div>
	
	<form action="<%=request.getContextPath()%>/registerJackWorks" >
	
	<table id="kojiro">
	<tr>
	<td style="display:flex">社員No<div class="warning">*</div></td>
	</tr>
	<td><input type="text" name="employeeNumber" value="" size="35"></td>
	
	<tr>
	<td style="display:flex">氏名<div class="warning">*</div></td>
	</tr>
	<td><input type="text" name="name" value="" size="35"></td>
	
	<tr>
	<td style="display:flex">カテゴリ<div class="warning">*</div></td>
	</tr>
	<td><input type="text" name="category" value="" size="35"></td>
	
	<tr>
	<td style="display:flex">評価項目<div class="warning">*</div></td>
	</tr>
	<td><textarea name="assessment" rows="" cols=""></textarea></td>
	
	<tr>
	<td style="display:flex">付与ポイント<div class="warning">*</div></td>
	</tr>
	<td><input type="text" name="point" value="" size="35"></td>
	
	<tr>
	<td style="display:flex">備考<div class="warning">*</div></td>
	</tr>
	<td><textarea name="note" rows="" cols=""></textarea></td>
	
	<tr>
	<td>案件名</td>
	</tr>
	<td><input type="text" name="project" value="" size="35"></td>
	
	<tr>
	<td>作業時期</td>
	</tr>
	<td><input type="text" name="workSeason" value="" size="35"></td>
	
	<tr>
	<td>単価</td>
	</tr>
	<td><input type="text" name="price" value="" size="35"></td>
	
	<tr>
	<td>精算</td>
	</tr>
	<td><input type="text" name="pay" value="" size="35"></td>
	
	<tr>
	<td>作業場所</td>
	</tr>
	<td><input type="text" name="workPlace" value="" size="35"></td>
	
	<tr>
	<td>作業内容</td>
	</tr>
	<td><textarea name="workContent" rows="" cols=""></textarea></td>
	
	<tr>
	<td>フェーズ</td>
	</tr>
	<td><textarea name="phase" rows="" cols=""></textarea></td>
	
	<tr>
	<td>開発言語</td>
	</tr>
	<td><textarea name="language" rows="" cols=""></textarea></td>
	
	<tr>
	<td>必要スキル</td>
	</tr>
	<td><textarea name="skill" rows="" cols=""></textarea></td>
	
	<tr>
	<td>必要人数</td>
	</tr>
	<td><input type="text" name="needPeople" value="" size="35"></td>
	
	<tr>
	<td>営業担当者</td>
	</tr>
	<td><input type="text" name="seller" value="" size="35"></td>
	
	<tr>
	<td>連絡先</td>
	</tr>
	<td><textarea name="contact" rows="" cols=""></textarea></td>
	
	<tr>
	<td>その他</td>
	</tr>
	<td><textarea name="other" rows="" cols=""></textarea></td>
	
	</table>
	
	<div id="JackWorks-submit">
	<input type="submit" value="登録">
	</div>
	</form>
	
	</body>
>>>>>>> branch 'aoki' of https://github.com/ai-ishii/home-jack.fun.git
</html>