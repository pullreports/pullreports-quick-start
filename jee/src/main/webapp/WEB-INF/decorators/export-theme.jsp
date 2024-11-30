<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Demonstration Pull Report</title>
    <sitemesh:write property="head"/>
    <%@include file="breadcrumb-style.html"%>
</head>
<body>
    <ol class='breadcrumb'>
       <li><a href='${pageContext.request.contextPath}/'>Home</a></li>
       <li><a href='${pageContext.request.contextPath}/adHocCreator'>Ad Hoc Creator</a></li>
       <li><sitemesh:write property="title"/></li>
    </ol>
    <sitemesh:write property="body"/>
</body>
</html>
