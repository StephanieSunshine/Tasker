// present next task to accept
function nextTask(e) {
  e.preventDefault();
  $.ajax({
    url: '/roster/next'
  }).done(function(data) {
    if(data.length) {
      data=data[0];
      $('#nextTaskTitle').text(data.title);
      $('#nextTaskBody').text(data.body);

      // $('#taskDetailsHiddenID').val(data.id);
      // $('#taskDetailsTitleField').val(data.title);
      // $('#taskDetailsBodyField').val(data.body);
      $('#nextTaskAcceptButton').attr('onclick', 'acceptTask('+data.id+')');
      $('#nextTaskModal').modal({ show: true});
    }else{
      alert('No new tasks available at this time');
    }
  });
}
