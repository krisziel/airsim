var airports;

function addAirports(map) {
  $.getJSON('airports',{
    type:1
  }).done(function(data){
    airports = data;
    var markerLayer = L.mapbox.featureLayer().addTo(map);
    var airportJSON = [];
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
    markerLayer.setGeoJSON(airportJSON);
    markerLayer.on('click', function(e) {
      loadAirport(e.layer.feature.properties['id']);
    });
    loadAirport(1);
  });
}
function createAirportMarker(args) {
  var json = {
    type: 'Feature',
    properties: {
      'marker-color': '#548cba',
      'marker-size': 'large',
      'marker-symbol': 'airport',
      'title':args.symbol + args.data.id,
      'id':args.data.id
    },
    geometry: {
      type: 'Point',
      coordinates: [args.coordinates[1],args.coordinates[0]]
    }
  }
  return json;
}
function loadAirport(id) {
  highlightRoutes(id);
  
}
