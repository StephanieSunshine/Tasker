//= require nextTask

$(function() {
  $(window).scrollTop($('body').prop('scrollHeight'));
});

function sendInput(id) {
  Rails.ajax({
    url: '/task/'+id+'/dialog/message',
    type: 'POST',
    data: 'data='+$('#message-input').val(),
    success: function(data) {
      window.location.replace('/task/'+id+'/dialog');
    }
  });
}
