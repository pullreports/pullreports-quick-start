<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta charset="utf-8">
    <title>Pull Reports Pet Store Demonstration</title>
    <meta name="description" content="Quick start Pull Reports demonstration.">
    <link href='https://fonts.googleapis.com/css?family=Roboto:400,300,700' rel='stylesheet' type='text/css'>
    <sitemesh:write property="head"/>
    <style>
        .navbar-inverse {
            background-color:#1A237E;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-inverse">
      <div class="container">
        <div class="navbar-header">
          <a class="navbar-brand" href="#">JEE Pet Store Reports</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li class='<%= ("Home".equals(request.getAttribute("activePage")))?"active":"" %>'>
                <a href="${pageContext.request.contextPath}/">Home</a></li>
            <li class='<%= ("Creator".equals(request.getAttribute("activePage")))?"active":"" %>'>
                <a href="${pageContext.request.contextPath}/adHocCreator">Ad Hoc Reports</a></li>
          </ul>
        </div>
      </div>
    </nav>
    <sitemesh:write property="body"/>
</body>
</html>
