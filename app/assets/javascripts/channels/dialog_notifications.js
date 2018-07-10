App.cable.subscriptions.create("DialogNotificationsChannel",{
  received: function(data) {
    // this is super kuldgy and hopefully I will rewrite this into something better
    current_task_id = window.location.pathname.split('/')[2];
    if(current_task_id == data.task) {
      $('#dialogHistory').append(data.data);
      scrollFix();
    }
  }
});
