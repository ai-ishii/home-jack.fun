<%--　
エラー表示画面(共通画面)

作成者:青木美波

作成日:2025/7/14

更新日:2025//
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
// エラー文を受け取る
String error = (String) request.getAttribute("error");
//cmd(エラー種類)を受け取る
String cmd = (String) request.getAttribute("cmd");
%>

<html>
<head>
<meta charset="UTF-8">
<title>error</title>
</head>

<body>
	<p style="text-align: center">●●エラー●●</p>
	<br>
	<p style="text-align: center"><%=error%></p>


</body>
</html>