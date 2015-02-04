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
function createRouteList(id) {
  console.log(id);
}
