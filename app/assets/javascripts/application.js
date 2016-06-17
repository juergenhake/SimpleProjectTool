// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery
//= require bootstrap-sprockets
//= require bootstrap-datepicker
//= require_tree .
//= require select2
//= require filterrific/filterrific-jquery

$(document).ready(function() {


  function displayprojectmodal(item)
{
    alert(item.value);
}
$('.cProject_type').change(function() {

  if (this.value == "Reklamation") {
   $('#p_customer').show();
   $('#p_reknr').show();
   $('#p_lsnr').show();
} else {
   $('#p_customer').hide();
    $('#p_reknr').hide();
   $('#p_lsnr').hide();
}

  });
});

