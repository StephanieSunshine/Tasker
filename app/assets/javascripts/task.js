//= require nextTask
//= require cable
//= require ./channels/dialog_notifications

// scroll dialog messages to the bottom on DOM Ready
function scrollFix() {
  $(window).scrollTop($('body').prop('scrollHeight'));
}

// send a message back to the server
function sendInput(id) {
  Rails.ajax({
    url: '/task/'+id+'/dialog/message',
    type: 'POST',
    data: 'data='+$('#message-input').val(),
    success: function(data) {
      $('#message-input').val('');
    }
  });
}

// scroll on DOM ready
$(scrollFix());
