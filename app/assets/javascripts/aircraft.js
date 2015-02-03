var aircrafts = {};

function loadAircraft() {
  $.getJSON('aircrafts/').done(function(data){
    $.each(data,function(i,value){
      value.fullName = value.manufacturer + ' ' + value.name;
      aircrafts[value.id] = value;
    });
  });
}

function loadUnusedAircraft(range, type) {
  var list = [];
  $.each(aircrafts,function(key,value){
    if((value.range >= range)&&(value.status === "unused")) {
      list.push(value);
    }
  });
  if(type === "dropdown") {
    $.each(list,function(i,value){

    });
  }
}
