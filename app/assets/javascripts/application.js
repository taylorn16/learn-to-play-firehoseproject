// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require jquery.stickyfooter
//= require_tree .
//= require jquery-ui

$(function(){ $(document).foundation(); });

// $(document).on('ready page:load', function() {
//   $('footer').stickyFooter({
//     content: '#page',
//     frame: 'body',
//     class: 'sticky-footer'
//   });
// });

$(function () {
  // Use jQuery UI to make lessons and sections sortable on the instructor views
  $('.lessons').sortable({
    update: function (evt, ui) {
      $.ajax({
        type: 'PATCH',
        url: ui.item.data('update-url'),
        dataType: 'json',
        data: {"lesson": {"row_order_position": ui.item.index()}}
      });
    }
  });
  $('.sections').sortable({
    update: function (evt, ui) {
      $.ajax({
        type: 'PATCH',
        url: ui.item.data('update-url'),
        dataType: 'json',
        data: {"section": {"row_order_position": ui.item.index()}}
      });
    }
  });

  // Dynamically update the new lesson modal's form target URL
  var lessonModalForm = $('#createLessonModalForm');
  $('button.new-lesson-button').on('click', function (evt) {
    lessonModalForm.attr('action', $(this).data('action-url'));
  });
  // Reset the URL if the modal is closed
  $('#createLessonModal').on('closed.zf.reveal', function (evt) {
    lessonModalForm.attr('action', '#');
  });
});
