<#import "/layout.ftlh" as layout />
<!DOCTYPE html>
<html>
    <@layout.head title="My title">
        <title>Pull Reports: Ad hoc report creator demonstration</title>
        <link rel="stylesheet" href="${springMacroRequestContext.contextPath}/assets/pullreports.min.css">
        <script src="${springMacroRequestContext.contextPath}/assets/pullreports.min.js"></script>
        <script src="https://unpkg.com/esri-leaflet@2.1.4/dist/esri-leaflet-debug.js"></script>
        <link href='/navbar.css' rel='stylesheet' type='text/css'>
    </@layout.head>
    <@layout.body activePage="Creator">
        <div class='container-fluid'>
            <section id="report-container" data-pr-creator></section> 
        </div>
        <script>
            PullReports.init(function(module,L){
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

                baseLayers['ESRI Streets'] = L.esri.basemapLayer('Streets');
    
                return {
                    url:'${springMacroRequestContext.contextPath}'
                    ,map: {
                        options: {
                            layers:[baseLayers['Open Street Map']]
                        }
                        ,initCallback:initializeMap
                    }
                    ,container:"report-container"
                }

                function initializeMap(map,geojsonLayer){
                    L.control.layers(baseLayers, {'Student residences':geojsonLayer}).addTo(map);
                }
            });
        </script>
    </@layout.body>
</html>
