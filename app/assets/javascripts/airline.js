var airline = {}

function updateMoney() {
  $('#money').html('Current Cash: $' + comma(airline.money)).css({display:'block'});
}
function checkAirline() {
  $.getJSON('airline/login').done(function(data){
    if(data.id) {
      airline = data;
      launchApp();
      $('#turn').css({display:'block'}).on('click',function(){
        turn();
      });
      updateMoney();
    } else {
      create();
    }
  }).fail(function(){
    create();
  });
}
function create() {
  var modal = '<div class="ui small modal transition" id="loginModal">';
  modal += '<div class="header">Create An Airline</div>';
  modal += '<div class="ui form segment" style="margin: 10px;">';
  modal += '<div class="inline fields">';
  modal += '<div class="field">';
  modal += '<label>Airline Name</label>';
  modal += '<input placeholder="Airline Name" type="text" style="width:100%;" id="airlineName">';
  modal += '</div>';
  modal += '<div class="field" style="margin-top: 10px;">';
  modal += '<label>Airline Code</label>';
  modal += '<input placeholder="3-digit code" type="text" max="3" style="width:100%;margin-left:3px;" id="airlineCode">';
  modal += '</div>';
  modal += '<div class="ui submit button" style="margin-top: 10px;" id="createAirlineButton">Submit</div>';
  modal += '</div>';
  modal += '</div>';
  $('body').append(modal);
  $('#createAirlineButton').on('click',function(){
    createAirline();
  })
  $('#loginModal').modal('show',{
    closable:false
  });
}
function createAirline() {
  $.post('airline/create',{
    airline:{
      name:$('#airlineName').val(),
      iata:$('#airlineCode').val()
    }
  }).done(function(data){
    if(data.name) {
      airline = data;
      $('#loginModal').modal('hide');
      launchApp();
      $('#turn').css({display:'block'}).on('click',function(){
        turn();
      });
      updateMoney();
    } else {
      console.log('welp…');
    }
  });
}
