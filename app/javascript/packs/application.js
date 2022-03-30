// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import 'bootstrap'
require('jquery')

Rails.start()
Turbolinks.start()
ActiveStorage.start()

$(document).ready(function () {
  $('.nav-toggle').click(function () {
    let collapse_content_selector = $(this).attr('href');
    let toggle_switch = $(this);
    $(collapse_content_selector).toggle(function () {
      if($(this).css('display')=='none') {
        toggle_switch.html('Read More');
      } else {
        toggle_switch.html('Read Less');
      }
    })
  })
})
let load = () =>  {
    // Hide flash message
    window.setTimeout(function () {
        $(".alert").fadeTo(500, 0).slideUp(500, function () {
            $(this).remove();
        });
    }, 3000);
};

$(document).on('turbolinks:load', load);
