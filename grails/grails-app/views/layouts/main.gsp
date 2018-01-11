<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>
        <g:layoutTitle default="Pull Reports Pet Store Demonstration"/>
    </title>
    <meta name="description" content="Quick start Pull Reports demonstration.">
    <link href='https://fonts.googleapis.com/css?family=Roboto:400,300,700' rel='stylesheet' type='text/css'>
    <asset:link rel="icon" href="favicon.ico" type="image/x-ico" />

    <%--asset:stylesheet src="application.css"/--%>

    <g:layoutHead/>
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
          <a class="navbar-brand" href="#">Grails Pet Store Reports</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li class='${("Home".equals(pageProperty(name:"meta.activePage")))?"active":""}'>
                <a href="${request.contextPath}/">Home</a></li>
            <li class='${("Creator".equals(pageProperty(name:"meta.activePage")))?"active":""}'>
                <a href="${request.contextPath}/adHocCreator">Ad Hoc Reports</a></li>
          </ul>
        </div>
      </div>
    </nav>

    <g:layoutBody/>

    <asset:javascript src="application.js"/>

</body>
</html>
