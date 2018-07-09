// Load json list via ajax from the server to task details
var current_user_id;

function openDialog(id) {
  window.location.replace('/task/'+id);
}

function acceptTask(id) {
  window.location.replace('/task/'+id+'/accept');
}

function loadCurrentUserID() {
  $.ajax({
    url: '/users/userID'
  }).done(function(data){
    current_user_id=data;
  });
}

function editDetails(task) {
  $.ajax({
    url: '/task/'+task.dataset.id+'/details'
  }).done(function(data) {
    if(data.user_id!=current_user_id||data.state!="queued") {
      $('#taskDetailsTitleField').prop('disabled', true);
      $('#taskDetailsBodyField').prop('disabled', true);
    }
    $('#taskDetailsHiddenID').val(data.id);
    $('#taskDetailsTitleField').val(data.title);
    $('#taskDetailsBodyField').val(data.body);
    $('#taskDetailsJoinButton').attr('onclick', 'openDialog('+data.id+')')
    $('#taskDetailsModal').modal({ show: true});
  });
}

function nextTask() {
  $.ajax({
    url: '/roster/next'
  }).done(function(data) {

    $('#nextTaskTitle').text(data[0].title);
    $('#nextTaskBody').text(data[0].body);

    // $('#taskDetailsHiddenID').val(data.id);
    // $('#taskDetailsTitleField').val(data.title);
    // $('#taskDetailsBodyField').val(data.body);
    $('#nextTaskAcceptButton').attr('onclick', 'acceptTask('+data[0].id+')');
    $('#nextTaskModal').modal({ show: true});
  });
}

// Load json list via ajax from the server to populate tasks
function loadFeeder() {
  $.ajax({
    url: '/roster/feed'
  }).done(function(data) {
    $('#task-list').replaceWith(data.map(function(data) {
      var result = [];
      if(data.state=="completed") {
        result.push("<tr class='table-success' onClick=\"editDetails(this)\" data-id=\""+data.id+"\">");
      }else if(data.state=="active"){
        result.push("<tr class='table-info' onClick=\"editDetails(this)\" data-id=\""+data.id+"\">");
      }else{
        result.push("<tr class='table-warning' onClick=\"editDetails(this)\" data-id=\""+data.id+"\">");
      }
      result.push("<td>"+data.state.charAt(0).toUpperCase()+data.state.substr(1)+"</td>");
      result.push("<td>"+data.title+"</td>");
      result.push("<td>"+data.assigned_to+"</td>");
      result.push("<td>"+data.created_by+"</td>");
      result.push("<td>"+data.last_update+"</td>");
      result.push("<td>"+data.age+"</td>");
      return(result.join());
    }).join("\n"));
  });
}

loadFeeder();
loadCurrentUserID();
