var allRoutes = {};
var activeRoutes = {};
var selectedFlight;

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
  var panel = '<div class="route-panel" id="routePanel">';
  panel += '<div class="route-info" data-routeid="' + id + '">';
  panel += '<div class="info">';
  panel += '<div class="ui statistic">';
  panel += '<div class="value">' + route.origin.iata + '</div>';
  panel += '<div class="label">' + route.origin.name + '</div>';
  panel += '</div>';
  panel += '<i class="resize horizontal icon"></i>';
  panel += '<div class="ui statistic">';
  panel += '<div class="value">' + route.dest.iata + '</div>';
  panel += '<div class="label">' + route.dest.name + '</div>';
  panel += '</div>';
  panel += '</div>';
  panel += '<div class="ui unordered steps flight-list vertical" id="route' + route.id + '">';
  for(i=0;i<flights.length;i++) {
    var flight = flights[i];
    var profit = (flight.revenue - flight.cost);
    flight.loadFactor = 80; ///// Needs to be added to table
    if(profit >= 0) {
      var profitString = '(<span class="greenColor">$' + comma(profit) + ' profit</span>)';
    } else {
      var profitString = '(<span class="redColor">$' + comma(Math.abs(profit)) + ' loss</span>)';
    }
    panel += '<a class="step" id="flight' + flight.id + '" data-flightid="' + flight.id + '" data-routeid="' + route.id + '" data-flighti="' + i + '"><div class="content"><div class="title">' + aircrafts[flight.aircraft_id].fullName + ' (' + flight.frequencies + 'x/week)</div><div class="description">' + flight.loadFactor + '% Load Factor ' + profitString + '</div></div></a>';
  }
  panel += '</div>';
  panel += '</div>';
  panel += '<div class="flight-info">';
  panel += '</div>';
  panel += '</div>';
  $('#routePanel').remove();
  $('body').append(panel);
  $('.flight-list').on('click','.step',function(){
    loadFlightInfo($(this).data('flightid'),$(this).data('routeid'),$(this).data('flighti'));
  });
}
function loadFlightInfo(flightid, routeid, flighti) {
  $.getJSON('flights/' + flightid).done(function(data){
    selectedFlight = data;
    var flight = data;
    var aircraft = flight.aircraft;
    var config = aircraft.config.aircraft_config;
    $('.flight-list > .step.active').removeClass('active');
    $('.step#flight' + flight.id).addClass('active');
    var profit = (flight.revenue - flight.cost);
    if(profit >= 0) {
      var profitString = '<div class="row"><span class="label">Weekly Profit:</span> $' + comma(profit) + '</div>';
    } else {
      var profitString = '<div class="row"><span class="label">Weekly Loss:</span> $' + comma(Math.abs(profit)) + '</div>';
    }
    var panel = '<div class="row-container">';
    panel += '<div class="row" data-rowtype="aircraft"><div class="ui selection dropdown"><div class="default text">' + aircraft.manufacturer + ' ' + aircraft.name + ' (' + config.f.seats + '/' + config.j.seats + '/' + config.p.seats + '/' + config.y.seats + ')</div><i class="dropdown icon"></i><input name="aircraft-id" id="aircraftInput" value="' + aircraft.id + ''+'" type="hidden"><div class="menu">' + loadUnusedAircraft(flight.route.distance, 'dropdown', aircraft.config.id) + '</div></div></div>'; // For some reason, without the string break syntax highlighting for the rest of the document doesn't work
    panel += '<div class="row" data-rowtype="flight-length"><span class="label">Flight Length:</span> <span>' + comma(flight.route.distance) + '</span> Miles</div>';
    panel += '<div class="row" data-rowtype="flight-duration"><span class="label">Flight Time:</span> <span>' + minutesToHours(flight.duration) + '</span></div>';
    panel += profitString;
    panel += '<div class="row" data-rowtype="weekly-frequencies"><span class="label">Weekly Frequencies:</span> <span id="weeklyFrequencies">' + flight.frequencies + '</span><input name="weekly-frequencies" type="range" class="frequencies" min="1" max="' + maxFrequencies(flight.duration,aircraft.type.turn_time) + '" value="' + flight.frequencies + '"></div>';
    panel += '</div>';
    panel += '<div class="tab">';
    panel += '<div class="ui secondary menu" id="classMenu">';
    panel += '<a class="item active" data-tab="f">First</a>';
    panel += '<a class="item" data-tab="j">Business</a>';
    panel += '<a class="item" data-tab="p">Premium Economy</a>';
    panel += '<a class="item" data-tab="y">Economy</a>';
    panel += '</div>';
    panel += flightCabinInfo(flight,"f");
    panel += flightCabinInfo(flight,"j");
    panel += flightCabinInfo(flight,"p");
    panel += flightCabinInfo(flight,"y");
    panel += '</div>';
    panel += '<div class="ui buttons">';
    panel += '<div class="ui button">Cancel</div>';
    panel += '<div class="or"></div>';
    panel += '<div class="ui positive button">Save</div>';
    panel += '<div class="or"></div>';
    panel += '<div class="ui red button">Cancel Flight</div>';
    panel += '</div>';
    $('.flight-info').html(panel).attr('data-flightid',flight.id);
    $('.route-panel').addClass('open');
    $('.route-panel .tab .segment[data-tab="f"]').addClass('open');
    $('.ui.dropdown').dropdown();
    $('#aircraftInput').on('change',function(){
      updateCabinView($(this).val());
    });
    $('.frequencies').on('mousemove',function(){
      $('#weeklyFrequencies').html($(this).val());
    });
    $('.fareRange').on('mousemove',function(){
      $('#' + $(this).attr("name")).html(comma($(this).val()));
    });
    $('#classMenu').on('click','a',function(){
      $(this).addClass('active').closest('.ui.menu').find('.item').not($(this)).removeClass('active');
      $(this).closest('.tab').find('div').addClass('open').not('[data-tab="' + $(this).data('tab') + '"]').removeClass('open');
    });
  });
}
function updateCabinView(aircraftid) {
  var newAircraft = userAircrafts[aircraftid];
  var oldAircraft = selectedFlight.aircraft.config.aircraft_config;
  var flight = selectedFlight;
  var newDuration = calculateDuration(flight.route.distance,newAircraft.aircraft.speed);
  console.log(newDuration);
  $('input[name="weekly-frequencies"]').attr("max",maxFrequencies(newDuration,newAircraft.aircraft.turn_time));
  $('.row[data-rowtype="flight-duration"] span:not(.label)').html(minutesToHours(newDuration));
  $.each(newAircraft.config,function(key,value){
    if(value.seats === 0) {
      $('.segment[data-tab="' + key + '"] .row').css({display:'block'}).not('.noclass').css({display:'none'});
    } else {
      var load = flight.performance.load[key];
      var newload = Math.min(Math.round((load*oldAircraft[key].seats)/(value.seats)),100);
      var classContainer = $('.segment[data-tab="' + key + '"]');
      classContainer.find('[data-rowtype="seattype"] span:not(.label)').html(seats[value.seat_id].name);
      classContainer.find('[data-rowtype="capacity"] span:not(.label)').html(value.seats);
      classContainer.find('[data-rowtype="loadfactor"] span:not(.label)').html(newload + '% (adjusted for swap)');
      classContainer.find('[data-rowtype="weeklyprofit"] span:not(.label)').html(comma(flight.performance.profit[key]) + ' (prior to swap)');
      $('.segment[data-tab="' + key + '"] .row').css({display:'none'}).not('.noclass').css({display:'block'});
    }
  });
}
function flightCabinInfo(flight, service_class) {
  var cabin = flight.aircraft.config.aircraft_config[service_class];
  var performance = flight.performance;
  var minFare = (flight.route.minFare[service_class]);
  var maxFare = (flight.route.maxFare[service_class]);
  var className = {"f":"first","j":"business","p":"premium economy","y":"economy"};
  var displayClass = '';
  var hideClass = '';
  if(cabin.seats === 0) {
    var displayClass = ' style="display:none;"';
    var hideClass = ' style="display:block;"'
  }
  var panel = '<div class="ui tab segment" data-tab="' + service_class + '">';
  panel += '<div class="row"' + displayClass + ' data-rowtype="seattype"><span class="label">Seat Type:</span> <span>' + cabin.seat.name + '</span></div>';
  panel += '<div class="row"' + displayClass + ' data-rowtype="capacity"><span class="label">Capacity:</span> <span>' + cabin.seats + '</span></div>';
  panel += '<div class="row"' + displayClass + ' data-rowtype="loadfactor"><span class="label">Load Factor:</span> <span>' + performance.load[service_class] + '</span></div>';
  panel += '<div class="row"' + displayClass + ' data-rowtype="weeklyprofit"><span class="label">Weekly Profit:</span> $<span>' + comma(performance.profit[service_class]) + '</span></div>';
  panel += '<div class="row"' + displayClass + ' data-rowtype="fare"><span class="label">Fare:</span> $<span id="' + service_class + 'fare">' + comma(performance.fare[service_class]) + '</span><input name="' + service_class + 'fare" type="range" value="' + performance.fare[service_class] + '" class="fareRange" min="' + minFare + '" max="' + maxFare + '"></div>';
  panel += '<div class="row noclass"' + hideClass + ' data-rowtype="noclass">This aircraft has no ' + className[service_class] + ' class</div>';
  panel += '</div>';
  return panel;
}
