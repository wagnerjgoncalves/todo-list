(function() {
  TODO.Views.SubTaskItem = Backbone.View.extend({
    initialize: function (model) {
      this.model = model;
      this.template = Handlebars.compile($('#sub-task-template').html());
    },

    render: function () {
      return this.template(this.model.toJSON());
    }
  });
})();
