<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Demonstration Map format report</title>
    <sitemesh:write property="head"/>
    <script>
        var baseLayers = [];
        baseLayers['ESRI World Topo'] = 
            L.tileLayer('http://server.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer/tile/{z}/{y}/{x}', {
            attribution: 'Tiles &copy; Esri &mdash; Esri, DeLorme, NAVTEQ, TomTom, Intermap, iPC, USGS, FAO, NPS, NRCAN, GeoBase, Kadaster NL, Ordnance Survey, Esri Japan, METI, Esri China (Hong Kong), and the GIS User Community'
            ,maxZoom:18
        });
        baseLayers['Open Street Map'] = 
            L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: 'Map data � <a href="http://openstreetmap.org">OpenStreetMap</a> contributors'
            ,maxZoom: 18
        });
        
        function initializeMap(map,geojsonLayer){
            L.control.layers(baseLayers, {'Student residences':geojsonLayer}).addTo(map);
        }

        var mapConfig = {
            options: {
                layers:[baseLayers['Open Street Map']]
            }
            ,initCallback:initializeMap
        };
    </script>
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
