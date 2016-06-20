(function() {
  TODO.Models.SubTask = Backbone.Model.extend({
    url: function () {
      return '/tasks/' + this.get('taskId') + '/sub_tasks/' + this.get('id');
    }
  });

  TODO.Collections.SubTasks = Backbone.Collection.extend({
    initialize: function (options) {
      this.taskId = options.taskId;
    },

    url: function () {
      return '/tasks/' + this.taskId + '/sub_tasks';
    }
  });
})();
