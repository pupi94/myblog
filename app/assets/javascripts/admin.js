//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets

//= require include_bootstrap_validator
//= require bootstrap-dialog

//= require jquery_file_upload
//= require attachment_upload

function stopEventBubble(event) {
  if (event && event.stopPropagation) {
    event.stopPropagation()
  } else {
    event.cancelBubble = true;
  }
}