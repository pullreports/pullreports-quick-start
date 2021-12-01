<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Demonstration Pull Report</title>
    <decorator:head />
    <%@include file="breadcrumb-style.html"%>
</head>
<body>
    <ol class='breadcrumb'>
       <li><a href='${pageContext.request.contextPath}/'>Home</a></li>
       <li><a href='${pageContext.request.contextPath}/adHocCreator'>Ad Hoc Creator</a></li>
       <li><decorator:title/></li>
    </ol>
    <decorator:body/>
</body>
</html>
