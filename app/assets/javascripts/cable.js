// Action Cable provides the framework to deal with WebSockets in Rails.
// You can generate new channels where WebSocket features live using the `rails generate channel` command.
//
//= require action_cable
//= require_self
//= require_tree ./channels

(function() {
  this.App || (this.App = {});

  App.cable = ActionCable.createConsumer();
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

}).call(this);
