<!doctype html>
<html lang="en">
<head>
	<meta name="layout" content="main"/>
    <title>Item Report</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" crossorigin="anonymous">
    <script src='https://code.jquery.com/jquery-2.2.3.min.js' type="text/javascript"></script>
    <script src='https://cdnjs.cloudflare.com/ajax/libs/URI.js/1.18.4/URI.min.js'></script>

</head>
<body>
    <div class='container'>
        <h1>Item Summary</h1>
        <p>Simple example of retrieving item attributes via Pull Reports web services.
        View page source to see the JavaScript AJAX call.</p>
        <table id='attributes' class='table table-striped table-bordered'>
            <tbody></tbody>
        </table>
    </div>
<script>

$(function(){

    var itemId = new URI().search(true).id;

    var itemAttributesURL = 
        './pullreports/catalog/petstore/report/items/export?filter=@id%3D' + itemId;

    $.get(itemAttributesURL, function( response ) {
        
        var $studentAttributeTableBody = $('#attributes tbody')

        for (var i=0;i<response.meta.columns.length;i++){
            var column = response.meta.columns[i];
            var value = response.data[0][i];
            if (typeof value === 'object' && value.value){
                value = value.value;
            }
            $studentAttributeTableBody.append(
                '<tr><th>' + column.displayName + '</th><td>' + value + '</td></tr>');
            
        }
    }); 
});
</script>
</body>
</html>
