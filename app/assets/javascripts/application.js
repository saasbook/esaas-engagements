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
//= require bootstrap-sprockets
//= require jquery_ujs
//= require select2

$(document).ready(function(){
  $('.select2').select2({
    theme: 'bootstrap'
  });
  
  
  // Fix for lack of a11y in Select2
  // https://github.com/select2/select2/issues/4930
  // https://stackoverflow.com/questions/53563588/the-select2-plugin-and-508-compliance
  $(".select2-search__field").each(function() {
      $(this).removeAttr("role");
      $(this).attr("aria-label", $(this).closest(".form-group").children("label").text());
      $(this).attr("type", "text");
  });

  $('span.select2-selection.select2-selection--single').each(function() {
     $(this).removeAttr('role');
  });
});
