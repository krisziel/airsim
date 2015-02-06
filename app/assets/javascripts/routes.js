var allRoutes = {};
var activeRoutes = {};
var selectedFlight, selectedRoute;

function drawRoutes() {
  $.getJSON('routes/').done(function(data) {
    $.each(data,function(i,value){
      var route = value;
      activeRoutes[route.id] = route;
      drawRoute({origin:airports[route.origin_id],dest:airports[route.destination_id],type:'normal'});
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
  var exists = false;
  var route_id;
  $.each(activeRoutes,function(i,route){
    route.origin = airports[route.origin_id];
    route.dest = airports[route.destination_id];
    var routeDest = route.dest;
    var routeOrigin = route.origin;
    if(((routeOrigin.id === origin.id)&&(routeDest.id === dest.id))||((routeDest.id === origin.id)&&(routeOrigin.id === dest.id))) {
      exists = true;
      route_id = route.id;
    }
  });
  if(exists) {
    loadExistingRoute(route_id);
  } else {
    loadNewRoute({origin:origin.id,dest:dest.id});
  }
}
function loadNewRoute(args) {
  $.getJSON('routes/' + args.origin + '/' + args.dest).done(function(data){
    showRoutePanel(data);
  });
}
function loadExistingRoute(id) {
  $.getJSON('/routes/' + id).done(function(data){
    showRoutePanel(data);
  });
}
function showRoutePanel(data) {
  selectedRoute = data;
  var route = data;
  var origin = airports[route.origin_id];
  var dest = airports[route.destination_id];
  var panel = '<div class="route-panel open transition ui modal" id="routePanel">';
  panel += '<i class="icon remove"></i>'
  panel += '<div class="route-info" data-routeid="' + data.id + '">';
  panel += '<div class="info">';
  panel += '<div class="ui statistic">';
  panel += '<div class="value">' + origin.iata + '</div>';
  panel += '<div class="label">' + origin.name + '</div>';
  panel += '</div>';
  panel += '<i class="resize horizontal icon"></i>';
  panel += '<div class="ui statistic">';
  panel += '<div class="value">' + dest.iata + '</div>';
  panel += '<div class="label">' + dest.name + '</div>';
  panel += '</div>';
  panel += '</div>';
  panel += '<div class="ui unordered steps flight-list vertical" id="route' + route.id + '">';
  panel += '<a class="step active title" id="addFlight"><div class="content"><div class="title" style="font-size: 22px;"><i class="icon plus"></i>Create Flight</div></div></a>';
  for(i=0;i<data.own.length;i++) {
    var flight = route.own[i];
    var profit = (flight.revenue - flight.cost);
    if(profit >= 0) {
      var profitString = '(<span class="greenColor">$' + comma(profit) + ' profit</span>)';
    } else {
      var profitString = '(<span class="redColor">$' + comma(Math.abs(profit)) + ' loss</span>)';
    }
    panel += '<a class="step own" id="flight' + flight.id + '" data-flightid="' + flight.id + '" data-routeid="' + route.id + '" data-flighti="' + i + '"><div class="content"><div class="title">' + flight.aircraft.type.fullName + ' (' + flight.frequencies + 'x/week)</div><div class="description">' + flight.load_factor.factor + '% Load Factor ' + profitString + '</div></div></a>';
  }
  if(route.competitors.length > 0) {
    panel += '<a class="step active title competitor-flight">Competitor Flights</a>';
  }
  for(i=0;i<route.competitors.length;i++) {
    var flight = route.competitors[i];
    var profit = (flight.revenue - flight.cost);
    panel += '<a class="step competitor-flight" id="flight' + flight.id + '" data-flightid="' + flight.id + '" data-routeid="' + route.id + '" data-flighti="' + i + '"><div class="content"><div class="title">' + flight.aircraft.type.fullName + ' (' + flight.frequencies + 'x/week)</div><div class="description">' + flight.airline.name + ' (' + flight.airline.iata + ') // ' + flight.load_factor.factor + '% load factor</div></div></a>';
  }
  panel += '</div>';
  panel += '</div>';
  panel += '<div class="line"></div>';
  panel += '<div class="flight-info">';
  panel += '<div class="empty">select a flight to view details</div>';
  panel += '</div>';
  panel += '</div>';
  $('.route-panel').remove();
  $('body').append(panel);
  $('.route-panel').modal('show');
  $('.line').css({height:$('.route-panel').height()});
  $('.route-panel .remove').on('click',function(){
    closeRoutePanel();
  });
  $('.flight-list').on('click','.step.own',function(){
    loadFlightInfo($(this).data('flightid'),$(this).data('routeid'),$(this).data('flighti'));
  });
  $('#addFlight').on('click',function(){
    displayNewFlight();
  });
}
function displayNewFlight() {
  var route = selectedRoute;
  var panel = '<div class="row-container">';
  panel += '<div class="row" data-rowtype="aircraft"><div class="ui selection dropdown"><div class="default text">Aircraft</div><i class="dropdown icon"></i><input name="aircraft-id" id="aircraftInput" value="" type="hidden"><div class="menu" style="max-height:210px;">' + loadUnusedAircraft(route.distance, 'dropdown') + '</div></div></div>';
  panel += '<div class="row" data-rowtype="flight-length"><span class="label">Flight Length:</span> <span>' + comma(route.distance) + '</span> Miles</div>';
  panel += '<div class="row" data-rowtype="flight-duration"><span class="label">Flight Time:</span> <span></span></div>';
  panel += '<div class="row" data-rowtype="weekly-frequencies"><span class="label">Weekly Frequencies:</span> <span id="weeklyFrequencies">1</span><input name="weekly-frequencies" type="range" class="frequencies" min="1" max="1" value="1"></div>';
  panel += '</div>';
  panel += '<div class="tab">';
  panel += '<div class="ui secondary menu" id="classMenu">';
  panel += '<a class="item active" data-tab="f">First</a>';
  panel += '<a class="item" data-tab="j">Business</a>';
  panel += '<a class="item" data-tab="p">Premium Economy</a>';
  panel += '<a class="item" data-tab="y">Economy</a>';
  panel += '</div>';
  $.each(route.maxfare,function(key, value){
    var className = {"f":"first","j":"business","p":"premium economy","y":"economy"};
    var averageFare = Math.round((route.minfare[key]+route.maxfare[key])/2);
    panel += '<div class="ui tab segment" data-tab="' + key + '">';
    panel += '<div class="row" data-rowtype="seattype"><span class="label">Seat Type:</span> <span></span></div>';
    panel += '<div class="row" data-rowtype="capacity"><span class="label">Capacity:</span> <span></span></div>';
    panel += '<div class="row" data-rowtype="fare"><span class="label">Fare:</span> $<span id="' + key + 'fare">' + comma(averageFare) + '</span><input name="' + key + 'fare" type="range" value="' + averageFare + '" class="fareRange" min="' + route.minfare[key] + '" max="' + route.maxfare[key] + '"></div>';
    panel += '<div class="row noclass" data-rowtype="noclass" style="height: 57px; line-height: 57px !important;">This aircraft has no ' + className[key] + ' class</div>';
    panel += '</div>';
  });
  panel += '</div>';
  panel += '<div class="ui buttons">';
  panel += '<div class="ui button" id="cancelButton">Cancel</div>';
  panel += '<div class="or"></div>';
  panel += '<div class="ui button" id="launchFlightButton">Launch Flight</div>';
  panel += '</div>';
  $('.route-panel').addClass('open');
  $('.flight-info').html(panel);
  $('.flight-info .dropdown .menu').css({maxHeight:$('.route-panel').height()-15});
  $('.route-panel .tab .segment[data-tab="f"]').addClass('open');
  $('.line').css({height:$('.route-panel').height()});
  $('.ui.dropdown').dropdown();
  $('#aircraftInput').on('change',function(){
    updateNewCabinView($(this).val());
  });
  $('#cancelButton').on('click',function(){
    closeFlightInfoPanel();
  });
  $('#launchFlightButton').on('click',function(){
    createFlight();
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
}
function updateNewCabinView(aircraftid) {
  var newAircraft = userAircrafts[aircraftid];
  var newDuration = calculateDuration(selectedRoute.distance,newAircraft.type.speed);
  $('#launchFlightButton').addClass('positive');
  $('input[name="weekly-frequencies"]').attr("max",maxFrequencies(newDuration,newAircraft.type.turn_time));
  $('.row[data-rowtype="flight-duration"] span:not(.label)').html(minutesToHours(newDuration));
  $.each(newAircraft.config,function(key,value){
    if(value.seats === 0) {
      $('.segment[data-tab="' + key + '"] .row').css({display:'block'}).not('.noclass').css({display:'none'});
    } else {
      var classContainer = $('.segment[data-tab="' + key + '"]');
      classContainer.find('[data-rowtype="seattype"] span:not(.label)').html(seats[value.seat_id].name);
      classContainer.find('[data-rowtype="capacity"] span:not(.label)').html(value.seats);
      $('.segment[data-tab="' + key + '"] .row').css({display:'none'}).not('.noclass').css({display:'block'});
    }
  });
}
function loadFlightInfo(flightid, routeid, flighti) {
  if($('.flight-info').attr('data-flightid') === flightid) {
    return false;
  }
  $.getJSON('flights/' + flightid).done(function(data){
    selectedFlight = data;
    var flight = data;
    var aircraft = flight.aircraft;
    var config = aircraft.config;
    $('.flight-list > .step.active').not('.title').removeClass('active');
    $('.step#flight' + flight.id).addClass('active');
    var profit = (flight.revenue - flight.cost);
    if(profit >= 0) {
      var profitString = '<div class="row"><span class="label">Weekly Profit:</span> $' + comma(profit) + '</div>';
    } else {
      var profitString = '<div class="row"><span class="label">Weekly Loss:</span> $' + comma(Math.abs(profit)) + '</div>';
    }
    var panel = '<div class="row-container">';
    panel += '<div class="row" data-rowtype="aircraft"><div class="ui selection dropdown"><div class="default text">' + aircraft.type.fullName + ' (' + config.f.seats + '/' + config.j.seats + '/' + config.p.seats + '/' + config.y.seats + ')</div><i class="dropdown icon"></i><input name="aircraft-id" id="aircraftInput" value="' + aircraft.id + ''+'" type="hidden"><div class="menu" style="max-height: 300px;">' + loadUnusedAircraft(flight.route.distance, 'dropdown', aircraft.id) + '</div></div></div>'; // For some reason, without the string break syntax highlighting for the rest of the document doesn't work
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
    panel += '<div class="ui button" id="cancelButton">Cancel</div>';
    panel += '<div class="or"></div>';
    panel += '<div class="ui positive button" id="saveFlightButton">Save</div>';
    panel += '<div class="or"></div>';
    panel += '<div class="ui red button" id="cancelFlightButton">Cancel Flight</div>';
    panel += '</div>';
    $('.route-panel').addClass('open');
    $('.flight-info .dropdown .menu').css({maxHeight:$('.route-panel').height()-15});
    $('.flight-info').html(panel).attr('data-flightid',flight.id);
    $('.route-panel .tab .segment[data-tab="f"]').addClass('open');
    $('.line').css({height:$('.route-panel').height()});
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
    $('#cancelButton').on('click',function(){
      closeFlightInfoPanel();
    });
    $('#saveFlightButton').on('click',function(){
      updateFlight();
    });
    $('#cancelFlightButton').on('click',function(){
      cancelFlight();
    });
    $('#classMenu').on('click','a',function(){
      $(this).addClass('active').closest('.ui.menu').find('.item').not($(this)).removeClass('active');
      $(this).closest('.tab').find('div').addClass('open').not('[data-tab="' + $(this).data('tab') + '"]').removeClass('open');
    });
  });
}
function updateCabinView(aircraftid) {
  var newAircraft = userAircrafts[aircraftid];
  var oldAircraft = selectedFlight.aircraft.config;
  var flight = selectedFlight;
  var newDuration = calculateDuration(flight.route.distance,newAircraft.type.speed);
  $('input[name="weekly-frequencies"]').attr("max",maxFrequencies(newDuration,newAircraft.type.turn_time));
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
  var cabin = flight.aircraft.config[service_class];
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
  panel += '<div class="row"' + displayClass + ' data-rowtype="seattype"><span class="label">Seat Type:</span> <span>' + cabin.name + '</span></div>';
  panel += '<div class="row"' + displayClass + ' data-rowtype="capacity"><span class="label">Capacity:</span> <span>' + cabin.seats + '</span></div>';
  panel += '<div class="row"' + displayClass + ' data-rowtype="loadfactor"><span class="label">Load Factor:</span> <span>' + performance.load[service_class] + '%</span></div>';
  panel += '<div class="row"' + displayClass + ' data-rowtype="weeklyprofit"><span class="label">Weekly Revenue:</span> $<span>' + comma(performance.profit[service_class]) + '</span></div>';
  panel += '<div class="row"' + displayClass + ' data-rowtype="fare"><span class="label">Fare:</span> $<span id="' + service_class + 'fare">' + comma(performance.fare[service_class]) + '</span><input name="' + service_class + 'fare" type="range" value="' + performance.fare[service_class] + '" class="fareRange" min="' + minFare + '" max="' + maxFare + '"></div>';
  panel += '<div class="row noclass"' + hideClass + ' data-rowtype="noclass">This aircraft has no ' + className[service_class] + ' class</div>';
  panel += '</div>';
  return panel;
}
function createFlight() {
  var route_id = selectedRoute.id;
  var user_aircraft_id = $('#aircraftInput').val();
  var frequencies = $('#weeklyFrequencies').html();
  var fare = getFlightFares();
  var flightData = {
    route_id:route_id,
    user_aircraft_id:user_aircraft_id,
    frequencies:frequencies,
    fare:JSON.stringify(fare)
  }
  $.post('flights/new',{
    flight:flightData
  }).done(function(data){
    flight = data;
    $('#addFlight').after('<a class="step own" id="flight' + flight.id + '" data-flightid="' + flight.id + '" data-routeid="' + flight.route_id + '"><div class="content"><div class="title">' + flight.aircraft.type.fullName + ' (' + flight.frequencies + 'x/week)</div><div class="description">Just Launched</div></div></a>');
    loadFlightInfo(flight.id,flight.route_id);
    $('#flight' + flight.id).on('click',function(){
      loadFlightInfo($(this).data('flightid'),$(this).data('routeid'),$(this).data('flighti'));
    });
  });
}
function updateFlight() {
  var route_id = selectedRoute.id;
  var flight_id = selectedFlight.id;
  var user_aircraft_id = $('#aircraftInput').val();
  var frequencies = $('#weeklyFrequencies').html();
  var fare = getFlightFares();
  var flightData = {
    route_id:route_id,
    user_aircraft_id:user_aircraft_id,
    frequencies:frequencies,
    fare:JSON.stringify(fare),
    id:flight_id
  }
  $.post('flights/update',{
    flight:flightData
  }).done(function(flight){
    $('#flight' + flight.id).find('.title').html(flight.aircraft.type.fullName + ' (' + flight.frequencies + 'x/week)');
  });
}
function cancelFlight() {
  var route_id = selectedRoute.id;
  var flightData = {
    route_id:route_id,
  }
  $.post('flights/delete',{
    flight:flightData
  }).done(function(data){
    closeFlightInfoPanel();
    $('#flight' + flight.id).remove();
  });
}
function getFlightFares() {
  var f = $('.ui.segment[data-tab="f"] input').val();
  var j = $('.ui.segment[data-tab="j"] input').val();
  var p = $('.ui.segment[data-tab="p"] input').val();
  var y = $('.ui.segment[data-tab="y"] input').val();
  var fares = {
    f:f,
    j:j,
    p:p,
    y:y
  }
  return fares;
}
function closeRoutePanel() {
  $('.route-panel').modal('hide');
  setTimeout(function(){ $('.route-panel').remove(); },500);
}
function closeFlightInfoPanel() {
  if($('#flight' + selectedFlight.id)) {
    $('#flight' + selectedFlight.id).removeClass('active');
  }
  $('.flight-info').html('<div class="empty">select a flight to view details</div>').removeAttr('data-flightid');
}
