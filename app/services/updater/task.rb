module Updater
  class Task
    attr_accessor :task

    def initialize (task)
      @task = task
    end

    def mark_as_completed!
      if sub_tasks_completed? && !task.completed?
        task.update_attributes(completed: true, completed_at: DateTime.current)
      end

      if !sub_tasks_completed? && task.completed?
        task.update_attributes(completed: false, completed_at: nil)
      end
    end

    private

    def sub_tasks_completed?
      task.sub_tasks.collect(&:completed).compact.uniq == [true]
    end
  end
end
