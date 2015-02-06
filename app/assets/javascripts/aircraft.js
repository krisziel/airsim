var aircrafts = {};
var userAircrafts = {};
var seats = {};
var selectedAircraft;

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
  var totalUserAircraft = 0;
  var unusedUserAircraft = 0;
  $.each(userAircrafts,function(key,value){
    totalUserAircraft++;
    if(value.inuse == false) {
      unusedUserAircraft++;
    }
  });
  var panel = '<div class="route-panel open transition ui modal" id="aircraftPanel">';
  panel += '<i class="icon remove"></i>'
  panel += '<div class="fleet-info">';
  panel += '<div class="info" style="border: 1px solid rgba(0,0,0,.15) !important; border-width: 0 0 1px 0 !important;">';
  panel += '<div class="ui statistic">';
  panel += '<div class="value total-aircraft">' + totalUserAircraft + '</div>';
  panel += '<div class="label">Owned Aircraft</div>';
  panel += '</div>';
  panel += '<div class="ui statistic">';
  panel += '<div class="value unused-aircraft">' + unusedUserAircraft + '</div>';
  panel += '<div class="label">Unused Aircraft</div>';
  panel += '</div>';
  panel += '</div>';
  panel += '<div class="ui unordered steps aircraft-list vertical">';
  $.each(aircrafts,function(key, value){
    var aircraft = value;
    panel += '<a class="step own" id="aircraft' + aircraft.id + '" data-aircraftid="' + aircraft.id + '"><div class="content"><div class="title">' + aircraft.fullName + '</div><div class="description">Range: ' + comma(aircraft.range) + 'mi // Capacity: ' + aircraft.capacity + '</div></div></a>';
  });
  panel += '</div>';
  panel += '</div>';
  panel += '<div class="line"></div>';
  panel += '<div class="aircraft-info">';
  panel += '<div class="empty">select an aircraft to view</div>'
  panel += '</div>';
  panel += '</div>';
  $('#aircraftPanel').remove();
  $('body').append(panel);
  $('.aircraft-list').css({height:$('#aircraftPanel').height()-55});
  $('#aircraftPanel').modal('show');
  $('.line').css({height:$('#aircraftPanel').height()});
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
  selectedAircraft = aircraft;
  var availableSpace = aircraft.sqft;
  var maxPlanes = Math.floor(airline.money/aircraft.price);
  $('.row-container').remove();
  var panel = '<div class="row-container">';
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
  panel += '<div class="row" data-rowtype="price">';
  panel += '<span class="label">Price: </span>';
  panel += '<span class="price">$' + comma(aircraft.price) + '</span>';
  panel += '<span class="total"></span>';
  panel += '</div>';
  panel += '<div class="row config-row" data-rowtype="quantity">';
  panel += '<div class="ui checkbox" style="opacity:0;"><input type="checkbox"></div>';
  panel += '<div class="label">Quantity</div>';
  panel += '<span>1</span>';
  panel += '<input type="range" value="1" min="1" max="' + maxPlanes + '" />';
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
    classRow += '<div class="ui checkbox" style="opacity:0;"><input type="checkbox"></div>';
    classRow += '<div class="label">' + value.name + '</div>';
    classRow += '<span>' + seatsVal + '</span>'
    classRow += '<input type="range" value="' + seatsVal + '" min="0" max="' + seatsMax + '" />';
    classRow += '</div>';
    panel += classRow;
  });
  if(maxPlanes > 0) {
    panel += '<div class="ui button positive" id="purchaseButton">Purchase Aircraft</div>';
  } else {
    panel += '<div class="ui button" id="purchaseButton">Purchase Aircraft</div>';
  }
  panel += '</div>';
  panel += '</div>';
  $('.aircraft-info').append(panel);
  $('.empty').css({display:'none'});
  $('.ui.checkbox').checkbox();
  $('.aircraft-info').on('mousemove','input[type="range"]',function(){
    changeConfiguration($(this).parent().data('cabintype'));
  });
  $('.row[data-rowtype="quantity"] input[type="range"]').on('mousemove',function(){
    var priceData = changeAircraftQuantity($(this).val());
    $(this).parent().find('span').html(priceData.quantity);
    $('.row-container .row[data-rowtype="price"] .price').html('$' + comma(priceData.price));
    $('.row-container .row[data-rowtype="price"] .total').html(' ($' + comma(priceData.price*priceData.quantity) + ' total)');
  });
  $('#purchaseButton').on('click',function(){
    purchaseAircraft();
  });
}
function changeConfiguration(cabinClass) {
  var aircraft = selectedAircraft;
  var availableSpace = aircraft.sqft;
  var classType = {f:{name:"First",id:9},j:{name:"Business",id:6},p:{name:"Premium",id:2},y:{name:"Economy",id:1}};
  $.each(classType,function(key,value){
    var seat = seats[value.id];
    var row = $('.row[data-cabintype="' + key + '"]');
    var seatsVal = Math.max(Math.ceil(row.find('input[type="range"]').val()),0);
    var space = (seatsVal*seat.sqft);
    if(space > availableSpace) {
      seatsVal = Math.floor(availableSpace/seat.sqft);
      space = availableSpace;
    }
    if(key == "y") {
      if(space < availableSpace) {
        seatsVal = Math.floor(availableSpace/seat.sqft);
      }
    }
    row.find('span').html(seatsVal);
    row.find('input[type="range"]').val(seatsVal);
    availableSpace -= space;
  });
}
function changeAircraftQuantity(quantity) {
  var maxPlanes = Math.floor(airline.money/selectedAircraft.price);
  if(quantity > maxPlanes) {
    quantity = maxPlanes;
  }
  var discount = Math.min(((quantity-1)*selectedAircraft.discount),50);
  var price = Math.round(selectedAircraft.price*(1-(discount*0.01)));
  return {quantity:quantity,price:price,discount:discount};
}
function purchaseAircraft() {
  var quantity = changeAircraftQuantity($('.row[data-rowtype="quantity"] input[type="range"]').val());
  var config = {
    f:{seats:0,seat_id:9},
    j:{seats:0,seat_id:6},
    p:{seats:0,seat_id:2},
    y:{seats:0,seat_id:1},
  }
  $.each(config,function(key,value){
    value.seats = parseInt($('.row[data-cabintype="' + key + '"] input[type="range"]').val());
  });
  $.post('/aircrafts/buy',{
    aircraft_id:selectedAircraft.id,
    quantity:quantity.quantity,
    config:JSON.stringify(config)
  }).done(function(data){
    $.each(data.purchases,function(i,value){
      userAircrafts[value.id] = value;
    });
    airline.money = data.airline.money;
    updateMoney();
    $('.aircraft-info .row-container').remove();
    $('.aircraft-info .empty').html(data.purchases.length + ' ' + plural(data.purchases.length,selectedAircraft.fullName) + ' successfully purchased').css({display:'block'});
    $('.total-aircraft').html(parseInt($('.total-aircraft').html())+data.purchases.length);
    $('.unused-aircraft').html(parseInt($('.unused-aircraft').html())+data.purchases.length);
    drawAircraftList(userAircrafts);
  });
}

function plural(count, text) {
  if(!text) {
    text = '';
  }
  if(count == 1) {
    text = text;
  } else {
    text = text + "s";
  }
  return text;
}
