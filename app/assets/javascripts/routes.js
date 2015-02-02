var allRoutes = {};
var activeRoutes = {};

function drawRoutes() {
  $.getJSON('routes/').done(function(data) {
    $.each(data,function(i,value){
      var route = value;
      activeRoutes[value.route.id] = route;
      drawRoute({origin:airports[route.route.origin_id],dest:airports[route.route.destination_id],type:'normal'});
    });
  });
}
function highlightRoutes(id) {
  unhighlightRoutes();
  $.each(allRoutes,function(i,value){
    if((value.origin.id === id)||(value.dest.id === id)) {
      drawRoute({origin:value.origin,dest:value.dest,type:'highlight'});
    }
  });
}
function unhighlightRoutes() {
  $.each(allRoutes,function(i,value){
    if((value.linetype === 'new')||(value.linetype === 'highlight')) {
      drawRoute({origin:value.origin,dest:value.dest,type:'normal'});
    }
  });
}
function drawRoute(args) {
  var origin = args.origin;
  var dest = args.dest;
  if(origin === dest) {
    return true;
  }
  var type = args.type;
  var lineid = 'route' + origin.id + dest.id;
  var lineid2 = 'route' + dest.id + origin.id;
  if(allRoutes[lineid]) {
    globalMap.removeLayer(allRoutes[lineid]);
    delete allRoutes[lineid];
  }
  if(allRoutes[lineid2]) {
    globalMap.removeLayer(allRoutes[lineid2]);
    delete allRoutes[lineid2];
  }
  if(type === 'new') {
    routeSettings = {
      color: '#eeaa77',
      weight: 3,
      opacity: 1
    }
  } else if(type === 'highlight') {
    routeSettings = {
      color: '#aa0114',
      weight: 2,
      opacity: 1
    }
  } else {
    routeSettings = {
      color: '#548cba',
      weight: 2,
      opacity: 1
    }
    type = 'normal';
  }
  var start = { x: origin.longitude, y: origin.latitude };
  var end = { x: dest.longitude, y: dest.latitude };
  var generator = new arc.GreatCircle(start, end);
  var line = generator.Arc(100, { offset: 10 });
  var newLine = L.polyline(line.geometries[0].coords.map(function(c) {
    return c.reverse();
  }),routeSettings);
  newLine.addTo(globalMap);
  newLine.linetype = type;
  newLine.origin = origin;
  newLine.dest = dest;
  allRoutes[lineid] = newLine;
}
function viewRoute(args) {
  var origin = airports[args.origin];
  var dest = airports[args.dest];
  $.each(activeRoutes,function(i,value){
    value.route.origin = airports[value.route.origin_id];
    value.route.dest = airports[value.route.destination_id];
    var routeDest = value.route.dest;
    var routeOrigin = value.route.origin;
    if(((routeOrigin.id === origin.id)&&(routeDest.id === dest.id))||((routeDest.id === origin.id)&&(routeOrigin.id === dest.id))) {
      loadExistingRoute(value.route.id);
    } else {
      loadNewRoute({origin:origin.id,dest:dest.id});
    }
  });
}
function loadNewRoute(args) {
  $.getJSON('routes/' + args.origin + '/' + args.destination).done(function(data){

  });
}
function loadExistingRoute(id) {
  var route = activeRoutes[id];
  var flights = route.flights;
  var route = route.route;
  var routePanel = '<div class="route-panel" id="routePanel" data-routeid="' + route.id + '">';
  routePanel += '<div class="route-list">';
  routePanel += '<div class="airport"><span>' + route.origin.iata + '</span>' + route.origin.name + '</div>';
  routePanel += '<span class="fa fa-arrows-h"></span>';
  routePanel += '<div class="airport"><span>' + route.dest.iata + '</span>' + route.dest.name + '</div>';
  routePanel += '<ul id="route' + route.id + '">';
  for(i=0;i<flights.length;i++) {
    var flight = flights[i];
    var flightContent = '<li class="flight" id="flight' + flight.id + '" class="flight" data-flightid="' + flight.id + '">';
    var profit = (flight.revenue - flight.cost);
    var profitColor = 'colorBlack';
    if(profit > 0) {
      profitColor = 'colorDarkGreen';
    } else if(profit < 0) {
      profitColor = 'colorDarkRed';
    }
    flightContent += '<div class="equipment">' + aircrafts[flight.aircraft_id].fullName + '</div>';
    flightContent += '<div class="frequencies">' + flight.frequencies + 'x weekly</div>';
    flightContent += '<div class="profit ' + profitColor + '">Profit: $' + comma(profit) + '</div>';
    flightContent += '</li>';
    routePanel += flightContent;
  }
  routePanel += '</ul>';
  routePanel += '</div>';
  if($('#routePanel')) {
    $('#routePanel').remove();
  }
  $('body').append(routePanel);
  $('#route' + route.id).on('click','.flight',function(){
    loadFlightInfo($(this).attr('data-flightid'));
  });
}
function loadFlightInfo(id) {
  $('.flight.selected').removeClass('selected');
  $('.flight#flight' + id).addClass('selected');
  $('.flight-info').remove();
  var infoContent = '<div class="flight-info">';
  infoContent += '<div>Boeing 777-300ER (550 seats)</div>';
  infoContent += '<div>Y: 400; PY: 50; J: 90; F: 10</div>';
  infoContent += '</div>';
  $('#routePanel').append(infoContent).css({width:600,marginLeft:-300});
}
