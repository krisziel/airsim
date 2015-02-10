function activateNav() {
  $('#controlTabs').on('click','.item',function(){
    $('#controlTabs .item').removeClass('active');
    $(this).addClass('active');
    $('#control .steps').css({display:'none'});
    $('#control .list-header').css({display:'none'});
    $('#' + $(this).attr('data-tabid') + 'List').css({display:'block'});
    $('.' + $(this).attr('data-tabid') + 'List').css({display:'block'});
  });
}
function createAirportList() {
  var airportArray = [];
  $.each(airports,function(key,value){
    airportArray.push(value);
  });
  var source = $('#airport-list-template').html();
  var template = Handlebars.compile(source);
  var html = template({airports:airportArray});
  $('#airportList').html(html);
  $('#airportList').on('click','a',function(){
    expandAirportInfo($(this).attr('data-id'));
  });
  var emptySearch = $('<a/>',{
    class:'step',
    id:'airportNotFound',
    html:'<div class="content">No Airports Found</div>',
    style:'display:none;'
  });
  $('#airportList').append(emptySearch);
  $('#airportSearch').on('keyup',function(){
    searchAirports();
  });
  $('#airportSearchButton').on('click',function(){
    searchAirports();
  });
}
function searchAirports() {
  var value = $("#airportSearch").val().toLowerCase();
  var results = 0;
  $('#airportList .step:not(#airportNotFound)').each(function(i,el){
    if($(el).data("iata").toLowerCase().match(value)||$(el).data("city").toLowerCase().match(value)) {
      $(el).css({display:'block'});
      results++;
    } else {
      $(el).css({display:'none'});
    }
  });
  if(results === 0) {
    $('#airportNotFound').css({display:'block'});
  } else {
    $('#airportNotFound').css({display:'none'});
  }
}
function expandAirportInfo(id) {
  $('img[title="airport' + id + '"]').click();
  $('#airportList .step').removeClass('active');
  $('#airportlist' + id).addClass('active');
}
function expandAirportInfoOld(id) {
  var operation = $('#airportlist' + id + ' .operationDetails');
  if(operation.hasClass('open')) {
    operation.removeClass('open');
  } else {
    operation.addClass('open');
    operation.on('click','.routes-btn',function(){
      createRouteList(id);
    });
  }
}
function createRouteList() {
  $.getJSON('/flights').done(function(data){
    drawRouteList(data);
  });
  $('#routeSearch').on('keyup',function(){
    searchRoutes();
  });
  $('#routeSearchButton').on('click',function(){
    searchRoutes();
  });
}
function drawRouteList(data) {
  var panel = '';
  var flightArray = [];
  $.each(data,function(key,value){
    var flight = value;
    var profit = (flight.revenue - flight.cost);
    if(profit >= 0) {
      var profitString = '<span class="greenColor">$' + comma(profit) + ' profit</span>';
    } else {
      var profitString = '<span class="redColor">$' + comma(Math.abs(profit)) + ' loss</span>';
    }
    value.profit = profitString;
    flightArray.push(value);
  });
  var source = $('#flight-list-template').html();
  var template = Handlebars.compile(source);
  var html = template({flights:flightArray});
  $('#flightList').html(html);
  $('#flightList').on('click','.step',function(){
    loadExistingRoute($(this).attr('data-routeid'));
    selectedRoute = $(this).attr('data-routeid');
    selectedFlight = $(this).attr('data-flightid');
    loadFlightInfo(selectedFlight, selectedRoute);
  });
}
function searchRoutes() {
  var route = $('#routeSearch').val().toUpperCase();
  console.log(route);
  if(route.length < 3) {
    $('#flightList .step').css({display:'block'});
    return false;
  } else if((route.length !== 3)&&(route.length !== 7)) {
    return false;
  }
  var airports = route.split("-");
  if(airports.length == 2) {
    var searchOrigin = airports[0];
    var searchDestination = airports[1];
  } else {
    var searchOrigin = airports[0];
    var searchDestination = false;
  }
  $('#flightList .step').each(function(index){
    var route = $(this).find('.title').html().split(" ")[0].split("-");
    var flightOrigin = route[0];
    var flightDestination = route[1];
    var display = 'block';
    if(searchDestination) {
      if(((flightOrigin === searchOrigin)&&(flightDestination === searchDestination))||((flightOrigin === searchDestination)&&(flightDestination === searchOrigin))) {
        display = 'block';
      } else {
        display = 'none';
      }
    } else {
      if((flightOrigin === searchOrigin)||(flightDestination === searchOrigin)) {
        display = 'block';
      } else {
        display = 'none';
      }
    }
    $(this).css({display:display});
  });
}
function createAircraftList() {
  $.getJSON('/aircrafts/airline').done(function(data){
    drawAircraftList(data);
  });
}
function drawAircraftList(data) {
  var aircraftOrder = {
    Boeing:{B73G:[],B738:[],B739:[],B744:[],B748:[],B752:[],B753:[],B762:[],B763:[],B764:[],B772:[],B77L:[],B77W:[],B788:[],B789:[],B780:[]},
    Airbus:{A318:[],A319:[],A320:[],A321:[],A332:[],A333:[],A342:[],A343:[],A345:[],A346:[],A358:[],A359:[],A35X:[],A388:[]},
    Bombardier:{BCR2:[],BCR7:[],BCR9:[],BCR1:[]},
    Embraer:{EE4X:[],EE70:[],EE75:[],EE90:[],EE95:[]}
  }
  var panel = '';
  $.each(data,function(key,value){
    userAircrafts[value.id] = value;
    var aircraft = value;
    var config = aircraft.config;
    var route = ' (unused)'
    if(aircraft.flight.origin) {
      route = ' (' + aircraft.flight.origin + '-' + aircraft.flight.destination + ')'
    }
    var row = '<a class="step own" id="menuAircraft' + aircraft.id + '" data-inuse="' + aircraft.inuse + '" data-aircraftid="' + aircraft.id + '"><div class="content"><div class="title">' + aircraft.type.fullName + route + '</div>'+'<div class="description">F: ' + config.f.seats + ' // J: ' + config.j.seats + ' // PY: ' + config.p.seats + ' // Y: ' + config.y.seats + '</div></div></a>';
    aircraftOrder[aircraft.type.manufacturer][aircraft.type.manufacturer.toUpperCase().substr(0,1)+aircraft.type.iata].push(row);
  });
  var aircraftList = '<a class="step title" id="purchaseAircraftButton"><div class="content"><div class="title" style="font-size: 22px;">Purchase Aircraft</div></div></a>';
  $.each(aircraftOrder,function(key,value){
    var title = '<a class="step own header"><div class="content"><div>' + key + '</div></div></a>';
    var type = '';
    $.each(value,function(key,value){
      if(value.length > 0) {
        type += value.join('');
      }
    });
    if(type.length > 0) {
      type = title + type;
      aircraftList += type;
    }
  });
  aircraftList += '<a class="step title unused" style="display:none;"><div class="content"><div class="title" style="text-align: center;">no unused aircraft</div></div></a>'
  $('#aircraftList').html(aircraftList);
  $('#aircraftList').on('click','.step',function(){
    // loadAircraftInfo($(this).attr('data-aircraftid'));
  });
  $('.aircraftList').on('click','.item',function(){
    $(this).parent().children().removeClass('active');
    $(this).addClass('active');
    sortAircraftList($(this).attr('data-type'));
  });
  $('#purchaseAircraftButton').on('click',function(){
    showAircraftPanel();
  });
}
function sortAircraftList(type) {
  if(type === "unused") {
    $('#aircraftList .header').css({display:'none'});
    $('#aircraftList .step[data-inuse="true"]').css({display:'none'});
    if($('#aircraftList .step[data-inuse="true"]').length > 0) {
      $('#aircraftList .unused').css({display:'block'});
    } else {
      $('#aircraftList .unused').css({display:'none'});
    }
  } else {
    $('#aircraftList .header').css({display:'block'});
    $('#aircraftList .step').css({display:'block'});
    $('#aircraftList .unused').css({display:'none'});
  }
}
function createGameList() {
  $.getJSON('/airline/list').done(function(data){
    $('#gameList').html('');
    $.each(data,function(i,airline){
      var airline = '<a class="step"><div class="content"><div class="title">' + airline.name + ' (' + airline.iata + ')</div>'+'<div class="description">' + airline.routes + ' Routes (' + airline.flights + ' total flights)</div></div></a>';
      $('#gameList').append(airline);
    });
  });
}
