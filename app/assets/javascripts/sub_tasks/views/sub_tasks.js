(function() {
  TODO.Views.SubTasks = Backbone.View.extend({
    initialize: function (options) {
      this.el = options.el;
      this.taskId = options.taskId;
      this.setupCollection();
      this.setupForm();
    },

    render: function () {
      this.collection.fetch();
    },

    renderItems: function (model, collection) {
      this.el.html('');

      _.each(collection.models, function(sub_task) {
        var subTaskItem = new TODO.Views.SubTaskItem(sub_task);

        this.el.append(subTaskItem.render());
      }, this);

      this.el.find("input[type='checkbox']").on('change', this.onCheckBoxChanged.bind(this));
      this.el.find("button[type='remove']").on('click', this.onRemoveClicked.bind(this));
    },

    onCheckBoxChanged: function (event) {
      var target = $(event.currentTarget),
          subTaskId = target.data('sub-task-id'),
          model = new TODO.Models.SubTask({
                    id: subTaskId,
                    taskId: this.taskId,
                    completed: target.is(":checked")
                  });
      model.save();
    },

    onRemoveClicked: function (event) {
      var self = this,
          target = $(event.currentTarget),
          subTaskId = target.data('sub-task-id'),
          model = new TODO.Models.SubTask({ id: subTaskId, taskId: self.taskId });

      model.destroy({
        success: function (model, response) {
          self.collection.remove(self.collection.get(subTaskId));
        }
      });
    },

    setupCollection: function () {
      this.collection = new TODO.Collections.SubTasks({ taskId: this.taskId });
      this.collection.on('add', this.renderItems, this);
      this.collection.on('reset', this.renderItems, this);
      this.collection.on('remove', this.renderItems, this);
    },

    setupForm: function () {
      this.form = new TODO.Views.SubTaskForm();
      this.form.on('sub-task-ajax-completed', this.render.bind(this));
    }
  });
})();
