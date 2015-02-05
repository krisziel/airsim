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
  $('#airportList').empty();
  $.each(airports,function(key,value){
    airport = airports[key];
    var airportRow = '<div class="content">';
    airportRow += '<div>' + airport.name + ' (' + airport.iata + ')</div>';
    airportRow += '<div>' + airport.city + ', ' + airport.country + '</div>';
    var thisAirport = $('<a/>',{
      class:'step',
      id:'airportlist' + airport.id,
      html:airportRow,
    }).attr('data-id',airport.id).attr('data-iata',airport.iata).attr('data-city',airport.city);
    $('#airportList').append(thisAirport);
    $('#airportlist' + airport.id).on('click',function(){
      expandAirportInfo($(this).attr('data-id'));
    });
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
    var panel = '';
    $.each(data,function(key,value){
      flight = value;
      var profit = (flight.revenue - flight.cost);
      if(profit >= 0) {
        var profitString = '(<span class="greenColor">$' + comma(profit) + ' profit</span>)';
      } else {
        var profitString = '(<span class="redColor">$' + comma(Math.abs(profit)) + ' loss</span>)';
      }
      panel += '<a class="step own" id="menuFlight' + flight.id + '" data-flightid="' + flight.id + '" data-routeid="' + flight.route_id + '"><div class="content"><div class="title">' + flight.origin.iata + '-' + flight.destination.iata + ' (' + flight.aircraft.type.fullName + ' x ' + flight.frequencies + ')</div>'+'<div class="description">' + flight.load_factor.factor + '% Load Factor ' + profitString + '</div></div></a>';
    });
    $('#flightList').html(panel);
    $('#flightList').on('click','.step',function(){
      loadExistingRoute($(this).attr('data-routeid'));
      selectedRoute = $(this).attr('data-routeid');
      selectedFlight = $(this).attr('data-flightid');
      loadFlightInfo(selectedFlight, selectedRoute);
    });
  });
}
function createAircraftList() {
  $.getJSON('/aircrafts/airline').done(function(data){
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
    var aircraftList = '<a class="step title" id="purchaseAircraftButton"><div class="content"><div class="title" style="font-size: 22px;"><i class="icon plus"></i>Purchase Aircraft</div></div></a>';
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
    aircraftList += '<a class="step title unused"><div class="content"><div class="title" style="text-align: center;">no unused aircraft</div></div></a>'
    $('#aircraftList').html(aircraftList);
    $('#aircraftList').on('click','.step',function(){
      // loadAircraftInfo($(this).attr('data-aircraftid'));
    });
    $('.aircraftList').on('click','.item',function(){
      $(this).parent().children().removeClass('active');
      $(this).addClass('active');
      sortAircraftList($(this).attr('data-type'));
    });
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
