<%@page contentType="text/html; charset=UTF-8"%>
<%
WorkRequest workRequest = (WorkRequest) request.getAttribute("workRequest");
%>

<html>
<head>
<!-- タイトル -->
<title></title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
<script src="<%=request.getContextPath()%>/js/script.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<style>
/-----------------------------------------------------------------------------------/
<!--この中にCSSを書く-->

/-----------------------------------------------------------------------------------/
</style>

<body>
    <div id="wrap">
        <!-- ヘッダー部分 -->
        <%@ include file="../common/header.jsp"%>

        <!-- メイン部分 -->
        <div id="main" class="container">
        
            <!--ここに貼り付ける-->
            
        </div>
    </div>
</body>
</html>