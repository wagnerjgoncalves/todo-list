(function() {
  TODO.Views.SubTaskForm = Backbone.View.extend({
    initialize: function (options) {
      this.el = $('#new_sub_task');
      this.el.bind('ajax:complete', this.onComplete.bind(this));
      this.input = this.el.find('#sub_task_description');
    },

    onComplete: function () {
      this.input.val('');

      this.trigger('sub-task-ajax-completed', {});
    }
  });
})();
