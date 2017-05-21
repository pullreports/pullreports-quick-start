<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="decorator" content="basic-theme"/>
	<meta name="activePage" content="Creator"/>
    <title>Pull Reports: Ad hoc report creator demonstration</title>
    <meta name="description" content="Demonstration of Pull Reports embeddable, web-based ad hoc reporting, mapping, and data services software.">
    <link rel="shortcut icon" type="image/x-icon" href="/favicon.ico"></link>
	<link rel="stylesheet" href="/assets/pullreports.min.css">
	<script src="/assets/pullreports.min.js"></script>
	<script>
        var baseLayers = [];
        baseLayers['ESRI World Topo'] = 
            L.tileLayer('http://server.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer/tile/{z}/{y}/{x}', {
            attribution: 'Tiles &copy; Esri &mdash; Esri, DeLorme, NAVTEQ, TomTom, Intermap, iPC, USGS, FAO, NPS, NRCAN, GeoBase, Kadaster NL, Ordnance Survey, Esri Japan, METI, Esri China (Hong Kong), and the GIS User Community'
            ,maxZoom:18
        });
        baseLayers['Open Street Map'] = 
            L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: 'Map data © <a href="http://openstreetmap.org">OpenStreetMap</a> contributors'
            ,maxZoom: 18
        });
        
        function initializeMap(map,geojsonLayer){
            L.control.layers(baseLayers, {'Student residences':geojsonLayer}).addTo(map);
        }

        require(['pr-require-config'],function(){
            require(['angular','pr-main'], function(angular,prMain) {
                    angular.element(document).ready(function() {
                        prMain.init({
                        	url:'${pageContext.request.contextPath}'
                        	,map: {
                        		options: {
                                    layers:[baseLayers['Open Street Map']]
                        		}
                                ,initCallback:initializeMap
                        	}
                        	,container:"report-container"
                        });
                    });
                }
            );
        });
	</script>
</head>
<body>
    <div class='container'>
	    <section id="report-container" data-pr-layout></section> 
    </div>
</body>
</html>
