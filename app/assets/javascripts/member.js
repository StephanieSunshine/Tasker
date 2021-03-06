//= require nextTask
//= require cable
//= require ./channels/roster_notifications

// Load json list via ajax from the server to task details
var cookies = new Object;
document.cookie.split('; ').map(function(e){ var p = e.split('='); cookies[p[0]] = p[1]; });
var current_user_id = cookies.user_id
var current_user_tech = cookies.is_tech;

// switch to task summary page
function openDialog(id) {
  window.location.replace('/task/'+id);
}

// accept task
function acceptTask(id) {
  window.location.replace('/task/'+id+'/accept');
}

// load and populate edit details modal
function editDetails(task) {
  $.ajax({
    url: '/task/'+task.dataset.id+'/details'
  }).done(function(data) {
    // If the current user doesn't match, grey it out
    if(data.user_id != current_user_id) {
      $('#taskDetailsTitleField').prop('disabled', true);
      $('#taskDetailsBodyField').prop('disabled', true);
    }

    // If you are the user and it's still queued you may edit it
    if(data.state != 'queued') {
      $('#taskDetailsTitleField').prop('disabled', true);
      $('#taskDetailsBodyField').prop('disabled', true);
    }

    // If you are a tech and the task isn't completed you may edit it
    if(current_user_tech && data.state != 'completed'){
      $('#taskDetailsTitleField').prop('disabled', false);
      $('#taskDetailsBodyField').prop('disabled', false);
    }

    $('#taskDetailsHiddenID').val(data.id);
    $('#taskDetailsTitleField').val(data.title);
    $('#taskDetailsBodyField').val(data.body);
    if(data.state == 'queued') {
      $('#taskDetailsAcceptButton').show();
      $('#taskDetailsAcceptButton').attr('onclick', 'acceptTask('+data.id+')');
    } else {
      $('#taskDetailsAcceptButton').hide();
    }
    $('#taskDetailsJoinButton').attr('onclick', 'openDialog('+data.id+')');
    $('#taskDetailsModal').modal({ show: true});
  });
}

// load json list via ajax from the server to populate tasks
function loadFeeder() {
  $.ajax({
    url: '/roster/feed'
  }).done(function(d) {
    $('#task-list').html(d.map(function(data) {
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

// first time load the roster ( websockets after that )
$(loadFeeder());
