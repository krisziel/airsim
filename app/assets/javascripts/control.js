function createAirportList() {
  $('#content').html('');
  for (var key in airports) {
    if (airports.hasOwnProperty(key)) {
      airport = airports[key];
      var airportRow = '<div class="content">';
      airportRow += '<div>' + airport.name + ' (' + airport.iata + ')</div>';
      airportRow += '<div>' + airport.city + ', ' + airport.country + '</div>'
      airportRow += '<div>Population: ' + airport.population + '</div>'
      airportRow += '<div>Slots: '+ comma(airport.slots_total) + ' (' + comma(airport.slots_available) + ' available)</div>'
      airportRow += '<i class="info circle icon"></i>'
      var thisAirport = $('<a/>',{
        class:'step active',
        id:'airportlist' + airport.id,
        html:airportRow
      }).attr('data-id',airport.id);
      $('#airportList').append(thisAirport);
      $('#airportlist' + airport.id).on('click','.info',function(){
        expandAirportInfo($(this).parent().attr('data-id'));
      });
    }
  }
}
function expandAirportInfo(id) {
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
