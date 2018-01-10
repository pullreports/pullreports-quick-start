<#import "/layout.ftl" as layout />
<!DOCTYPE html>
<html>
    <@layout.head title="My title">
        <title>Pull Reports: Ad hoc report creator demonstration</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" crossorigin="anonymous">
    </@layout.head>
    <@layout.body>
    <div class='container'>
	    <div class='page-header'><h1>Pet Store Demonstration</h1></div> 
        <p>Congratulations! If you can see this page, it means that you have
        successfully installed the <a href='https://www.pullreports.com'>Pull Reports</a>
        quick start application.
        </p>
        <p>Navigate to the <a href='${springMacroRequestContext.contextPath}/adHocCreator'>Ad Hoc Creator</a> page to see an example installation
        of the <a href='https://www.pullreports.com/docs/latest/creator.html'>Pull Reports ad hoc report creator</a>.
        </p>
        <h2>Credit</h2>
        <p>Thank you to <a href='https://github.com/agoncal/agoncal-application-petstore-ee6'>agoncal-application-petstore-ee6</a>
        for Pet Store datamodel inspiration.</p>
    </div>
    </@layout.body>
</html>