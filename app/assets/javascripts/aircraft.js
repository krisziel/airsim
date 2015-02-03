var aircrafts = {};
var userAircrafts = {};
var seats = {};

function loadAircraft() {
  $.getJSON('aircrafts/').done(function(data){
    $.each(data,function(i,value){
      value.fullName = value.manufacturer + ' ' + value.name;
      aircrafts[value.id] = value;
    });
    loadUserAircraft();
    loadSeats();
  });
}
function loadUserAircraft() {
  $.getJSON('aircrafts/airline').done(function(data){
    $.each(data,function(i,value){
      value.aircraft = aircrafts[value.aircraft_id];
      value.fullName = value.aircraft.manufacturer + ' ' + value.aircraft.name;
      userAircrafts[value.id] = value;
    });
  });
}
function loadUnusedAircraft(range, type, defaultAircraft) {
  var list = [];
  $.each(userAircrafts,function(key,value) {
    if((value.aircraft.range >= range)&&(value.inuse === false)) {
      list.push(value);
    }
  });
  if(type === "dropdown") {
    var dropdown = '';
    if(defaultAircraft) {
      list.unshift(userAircrafts[defaultAircraft]);
    }
    $.each(list,function(i,value){
      var selected = '';
      if(i === 0) {
        selected = ' active selected';
      }
      dropdown += '<div class="item' + selected + '" data-value="' + value.id + '">' + value.fullName + ' (' + value.config.f.seats + '/' + value.config.j.seats + '/' + value.config.p.seats + '/' + value.config.y.seats + ')</div>';
    });
    return dropdown;
  }
}

function loadSeats() {
  $.getJSON('seats/').done(function(data){
    seats = data;
  });
}
