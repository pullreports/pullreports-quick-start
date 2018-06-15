<#macro head title="defaultTitle">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta charset="utf-8">
    <title>Pull Reports Pet Store Demonstration</title>
    <link rel="shortcut icon" type="image/x-icon" href="/favicon.ico"></link>
    <meta name="description" content="Quick start Pull Reports demonstration.">
    <link href='https://fonts.googleapis.com/css?family=Roboto:400,300,700' rel='stylesheet' type='text/css'>
    <#nested />
    <style>
        .navbar-inverse {
            background-color:#1A237E;
        }
    </style>
</head>
</#macro>
<#macro body activePage="Home">
<body>
    <nav class="navbar navbar-inverse">
      <div class="container">
        <div class="navbar-header">
          <a class="navbar-brand" href="#">Spring Boot Pet Store Reports</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li class="${(activePage == 'Home')?then('active','')}">
                <a href="${springMacroRequestContext.contextPath}/">Home</a></li>
            <li class="${(activePage == 'Creator')?then('active','')}">
                <a href="${springMacroRequestContext.contextPath}/d/adHocCreator">Ad Hoc Reports</a></li>
          </ul>
        </div>
      </div>
    </nav>
    <#nested />
</body>
</#macro>
