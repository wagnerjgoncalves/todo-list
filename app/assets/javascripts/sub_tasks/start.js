$(document).ready(function () {
  var container = $('#sub_tasks');

  if (container && container.length > 0) {
    var taskId = $('#task_id').val(),
        subTasksView = new TODO.Views.SubTasks({ el: container, taskId: taskId});
    subTasksView.render();
  }
});
