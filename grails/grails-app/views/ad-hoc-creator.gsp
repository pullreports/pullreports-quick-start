<!doctype html>
<html lang="en">
<head>
	<meta name="layout" content="main"/>
	<meta name="activePage" content="Creator"/>
    <title>Pull Reports: Ad hoc report creator demonstration</title>
    <meta name="description" content="Demonstration of Pull Reports embeddable, web-based ad hoc reporting, mapping, and data services software.">
    <link rel="shortcut icon" type="image/x-icon" href="/favicon.ico"></link>
	<link rel="stylesheet" href="${request.contextPath}/static/assets/pullreports.min.css">
	<script src="${request.contextPath}/static/assets/pullreports.min.js"></script>
	<script>
        require(['pr-require-config'],function(){
            require(['angular','pr-main','leaflet'], function(angular,prMain,L) {

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
        
                    angular.element(document).ready(function() {
                        prMain.init({
                        	url:'${request.contextPath}'
                        	,map: {
                        		options: {
                                    layers:[baseLayers['Open Street Map']]
                        		}
                                ,initCallback:initializeMap
                        	}
                        	,container:"report-container"
                        });
                    });

                    function initializeMap(map,geojsonLayer){
                        L.control.layers(baseLayers, {'Student residences':geojsonLayer}).addTo(map);
                    }

                }
            );
        });
	</script>
</head>
<body>
    <div class='container-fluid'>
	    <section id="report-container" data-pr-creator></section> 
    </div>
</body>
</html>
