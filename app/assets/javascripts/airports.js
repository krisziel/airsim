var airports;
var airportMarkers;
var airportJSON;
var airportSelected;
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
    drawRoutes();
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
      'id':args.data.id,
      title: 'airport' + args.data.id
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
  var airport = airports[id];
  var airportPopup = '';
  var airportSelected = id;
  var destinationAirport = ((airportOrigin)&&(airportOrigin > 0));
  if(airportOrigin === id) {
    highlightRoutes(id);
    airportPopup += '<div class="fa-star-o fa" title="Unselect Airport"></div>';
  } else if(destinationAirport) {
    airportDestination = id;
    unhighlightRoutes();
    var origin = airports[airportOrigin];
    var dest = airports[airportDestination];
    drawRoute({origin:origin,dest:dest,type:'new'});
    var kmdist = (L.latLng({lat:origin.latitude,lng:origin.longitude}).distanceTo(L.latLng({lat:dest.latitude,lon:dest.longitude}))/1000);
    var midist = (kmdist * 0.621371);
    airportPopup += '<div class="fa-arrows-h fa" title="View Route"></div>';
  } else {
    highlightRoutes(id);
    airportPopup += '<div class="fa-star fa" title="Select Airport"></div>';
  }
  airportPopup += '<div class="title">' + airport.name + ' (' + airport.iata + ')</div>';
  airportPopup += '<div>' + airport.city + ', ' + airport.country + '</div>';
  airportPopup += '<div>Population: ' + comma(airport.population) + '</div>';
  airportPopup += '</div>';
  var popup = L.popup({
    offset:L.point(0,-22),
    closeOnClick:false
  }).setLatLng(marker.getLatLng()).setContent(airportPopup).openOn(globalMap);
  if(destinationAirport) {
    $('.leaflet-popup .fa-arrows-h').on('click',function(e){
      viewRoute({origin:airportOrigin,dest:airportDestination});
    });
  } else {
    $('.leaflet-popup .fa-star').on('click',function(e){
      $(this).toggleClass('selected');
      if(airportOrigin === airportSelected) {
        airportOrigin = null;
      } else {
        airportOrigin = airportSelected;
      }
    });
  }
  if((destinationAirport)&&(id != airportOrigin)) {
    selectMarker(id,airportOrigin);
    $('.leaflet-popup-close-button').on('click',function(){
      $('.leaflet-marker-icon[title="airport' + airportOrigin + '"]').click();
      airportDestination = null;
    });
  } else {
    selectMarker(id);
    $('.leaflet-popup-close-button').on('click',function(){
      airportOrigin = null;
      airportDestination = null;
      unhighlightRoutes();
      selectMarker(0);
    });
  }
}

function selectMarker(id,id2) {
  id2 = id2 || 0;
  for(i=0;i<airportJSON.length;i++){
    var airport = airportJSON[i];
    if((airport.properties.id === id)||(airport.properties.id === id2)) {
      airport.properties['marker-color'] = '#aa0114';
    } else if(airport.properties['marker-color'] === '#aa0114') {
      airport.properties['marker-color'] = '#548cba';
    }
  }
  airportMarkers.setGeoJSON(airportJSON);
}
