function createAirportList() {
  $('#content').html('');
  for (var key in airports) {
    if (airports.hasOwnProperty(key)) {
      airport = airports[key];
      var airportHTML = '<div class="title">' + airport.name + ' (' + airport.iata + ')</div>';
      airportHTML += '<div>' + airport.city + ', ' + airport.country + '</div>';
      airportHTML += '<div>Population: ' + airport.population + '</div>';
      airportHTML += '<div>Slots: '+ comma(airport.slots_total) + ' (' + comma(airport.slots_available) + ' available)</div>';
      airportHTML += '<div class="info">i</div>';
      airportHTML += '<div class="operationDetails">';
      airportHTML += '<div class="title">Your Operation</div>';
      airportHTML += '<div>Routes: ' + airport.routes + '</div>';
      airportHTML += '<div>Flights: ' + airport.flights + '</div>';
      airportHTML += '<div class="button routes-btn">Show Routes</div>';
      airportHTML += '</div>';
      var thisAirport = $('<li/>',{
        class:'airport',
        id:'airportlist' + airport.id,
        html:airportHTML
      }).attr('data-id',airport.id);
      $('#content').append(thisAirport);
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
