// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$().ready(function(){
  $('#ball1').bind('keyup', function(){
  if(strike() && $('#frame_number').val() != 10) {
      $('#block-ball2').hide()
    }
    else {
      $('#block-ball2').show()
    }
  })

  function strike() {
    return $('#ball1').val() == 10
  }
});