var airports;
var airportMarkers;
var airportJSON;
var airportOrigin;
var airportDestination;

function addAirports(map) {
  $.getJSON('airports',{
    type:1
  }).done(function(data){
    airports = data;
    airportMarkers = L.mapbox.featureLayer().addTo(map);
    airportJSON = [];
    for (var key in airports) {
      if (airports.hasOwnProperty(key)) {
        airport = airports[key];
        var coordinates = [
          airport.latitude,
          airport.longitude
        ];
        airportJSON.push(createAirportMarker({data:airport,coordinates:coordinates,markerId:airport.id}));
      }
    }
    airportMarkers.setGeoJSON(airportJSON);
    airportMarkers.on('click', function(e) {
      loadAirport(e.layer);
    });
    createAirportList();
  });
}
function createAirportMarker(args) {
  var json = {
    type: 'Feature',
    properties: {
      'marker-color': '#548cba',
      'marker-size': 'medium',
      'marker-symbol': 'airport',
      'id':args.data.id
    },
    geometry: {
      type: 'Point',
      coordinates: [args.coordinates[1],args.coordinates[0]]
    }
  }
  return json;
}
function loadAirport(marker) {
  var id = marker.feature.properties['id'];
  var airportPopup = '';
  var lock = ((airportOrigin)&&(airportOrigin > 0));
  if(lock) {
    airportDestination = id;
    unhighlightRoutes();
    var origin = airports[airportOrigin];
    var dest = airports[airportDestination];
    drawRoute({origin:origin,dest:dest,type:'new'});
    airportPopup += '<div class="route">destination</div>';
  } else {
    highlightRoutes(id);
    airportPopup += '<div class="lock">origin</div>';
  }
  var popup = L.popup({
    keepInView:true,
    offset:L.point(0,-22)
  }).setLatLng(marker.getLatLng()).setContent(airportPopup).openOn(globalMap);
  if(lock) {
  } else {
    airportOrigin = id;
    $('.leaflet-popup .lock').on('click',function(e){
    });
  }
  for(i=0;i<airportJSON.length;i++){
    var airport  = airportJSON[i];
    if(airport.properties.id == id) {
      airport.properties['marker-color'] = '#aa0114';
    } else if(airport.properties['marker-color'] == '#aa0114') {
      airport.properties['marker-color'] = '#548cba';
    }
  }
  airportMarkers.setGeoJSON(airportJSON);
}
