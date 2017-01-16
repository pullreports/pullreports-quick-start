<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta charset="utf-8">
    <title>Pull Reports Pet Store Demonstration</title>
    <meta name="description" content="Quick start Pull Reports demonstration.">
    <link href='https://fonts.googleapis.com/css?family=Roboto:400,300,700' rel='stylesheet' type='text/css'>
    <decorator:head/>
    <decorator:usePage id='thePage'/>
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
          <a class="navbar-brand" href="#">Pet Store Reports</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li class='<%= ("Home".equals(thePage.getProperty("meta.activePage")))?"active":"" %>'><a href="/">Home</a></li>
            <li class='<%= ("Creator".equals(thePage.getProperty("meta.activePage")))?"active":"" %>'><a href="/adHocCreator">Ad Hoc Reports</a></li>
          </ul>
        </div>
      </div>
    </nav>
    <decorator:body />
</body>
</html>
