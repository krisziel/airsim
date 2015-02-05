function activateNav() {
  $('#control .ui.menu').on('click','.item',function(){
    $('#control .ui.menu .item').removeClass('active');
    $(this).addClass('active');
    $('#control .steps').css({display:'none'});
    $('#' + $(this).attr('data-tabid') + 'List').css({display:'block'});
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
