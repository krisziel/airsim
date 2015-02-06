var aircrafts = {};
var userAircrafts = {};
var seats = {};

function loadAircraft() {
  $.getJSON('aircrafts/').done(function(data){
    $.each(data,function(i,value){
      value.fullName = value.manufacturer + ' ' + value.name;
      aircrafts[value.id] = value;
    });
    loadSeats();
  });
}
function loadUnusedAircraft(range, type, defaultAircraft) {
  var list = [];
  $.each(userAircrafts,function(key,value) {
    if((value.type.range >= range)&&(value.inuse === false)) {
      list.push(value);
    }
  });
  if(type === "dropdown") {
    var dropdown = '';
    if(defaultAircraft) {
      list.unshift(userAircrafts[defaultAircraft]);
    }
    if(list.length === 0) {
      dropdown = '<div class="item active selected" data-value="0">No Available Aircraft</div>';
    }
    $.each(list,function(i,value){
      var selected = '';
      if(i === 0) {
        selected = ' active selected';
      }
      dropdown += '<div class="item' + selected + '" data-value="' + value.id + '">' + value.type.fullName + ' (' + value.config.f.seats + '/' + value.config.j.seats + '/' + value.config.p.seats + '/' + value.config.y.seats + ')</div>';
    });
    return dropdown;
  }
}

function loadSeats() {
  $.getJSON('seats/').done(function(data){
    seats = data;
    seats[1].sqft += 0.5;
    seats[3].sqft += 0.5;
  });
}
function showAircraftPanel() {
  var panel = '<div class="route-panel open transition ui modal" id="aircraftPanel">';
  panel += '<div class="ui unordered steps aircraft-list vertical">';
  $.each(aircrafts,function(key, value){
    var aircraft = value;
    panel += '<a class="step own" id="aircraft' + aircraft.id + '" data-aircraftid="' + aircraft.id + '"><div class="content"><div class="title">' + aircraft.fullName + '</div><div class="description">Range: ' + comma(aircraft.range) + 'mi // Capacity: ' + aircraft.capacity + '</div></div></a>';
  });
  panel += '</div>';
  panel += '<div class="line"></div>';
  panel += '<div class="aircraft-info">';
  panel += '</div>';
  panel += '</div>';
  $('#aircraftPanel').remove();
  $('body').append(panel);
  $('#aircraftPanel').modal('show');
  $('.line').css({height:$('.aircraft-list').height()});
  $('#aircraftPanel .remove').on('click',function(){
    closeRoutePanel();
  });
  $('.aircraft-list').on('click','.step.own',function(){
    $('.aircraft-list .step').removeClass('active');
    $(this).addClass('active');
    loadAircraftInfo($(this).data('aircraftid'));
  });
}
function loadAircraftInfo(id) {
  var classType = {f:{name:"First",percent:12,id:9},j:{name:"Business",percent:23,id:6},p:{name:"Premium",percent:15,id:2},y:{name:"Economy",percent:50,id:1}};
  var aircraft = aircrafts[id];
  var panel = '<div class="row-container">';
  var availableSpace = aircraft.sqft
  panel += '<h2 class="ui header">' + aircraft.fullName + '</h2>';
  panel += '<div class="row">';
  panel += '<span class="label">Capacity: </span>';
  panel += comma(aircraft.capacity) + ' passengers';
  panel += '</div>';
  panel += '<div class="row">';
  panel += '<span class="label">Range: </span>';
  panel += comma(aircraft.range) + ' miles';
  panel += '</div>';
  panel += '<div class="row">';
  panel += '<span class="label">Speed: </span>';
  panel += comma(aircraft.speed) + 'mph';
  panel += '</div>';
  panel += '<div class="row">';
  panel += '<span class="label">Turn Time: </span>';
  panel += comma(aircraft.turn_time) + ' minutes';
  panel += '</div>';
  panel += '<div class="row">';
  panel += '<span class="label">Price: </span>';
  panel += '$' + comma(aircraft.price);
  panel += '</div>';
  panel += '<h4 class="ui header">Configuration</h4>';
  $.each(classType,function(key,value){
    var seat = seats[value.id];
    var seatsCount = ((value.percent*0.01*aircraft.sqft)/seat.sqft);
    var seatsSpace = Math.ceil(seatsCount*seat.sqft);
    var seatsVal = Math.ceil(Math.min(seatsCount,(availableSpace/seat.sqft)));
    availableSpace -= (seatsVal*seat.sqft);
    var seatsMax = Math.floor(aircraft.sqft/seat.sqft);
    var classRow = '<div class="row config-row" data-cabintype="' + key + '">';
    classRow += '<div class="ui checkbox">';
    classRow += '<input type="checkbox">';
    classRow += '</div>';
    classRow += '<div class="label">' + value.name + '</div>';
    classRow += '<span>' + seatsVal + '</span>'
    classRow += '<input type="range" value="' + seatsVal + '" min="0" max="' + seatsMax + '" />';
    classRow += '</div>';
    panel += classRow;
  });
  panel += '</div>';
  panel += '</div>';
  $('.aircraft-info').html(panel);
  $('.ui.checkbox').checkbox();
}
