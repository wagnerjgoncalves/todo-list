require 'rails_helper'

describe Updater::Task do
  let!(:task) { create(:task) }
  let!(:sub_task_1) { create(:sub_task, task: task, completed: true) }
  let!(:sub_task_2) { create(:sub_task, task: task, completed: true) }

  describe '#mark_as_completed!' do
    context 'when all sub taks are completed' do
      let!(:sub_task_3) { create(:sub_task, task: task, completed: true) }

      before do
        described_class.new(task).mark_as_completed!

        task.reload
      end

      it { expect(task.completed).to be true }
      it { expect(task.completed_at).to_not be_nil }
    end

    context 'when at least one subtask is not completed' do
      let!(:sub_task_3) { create(:sub_task, task: task, completed: false) }

      before do
        described_class.new(task).mark_as_completed!

        task.reload
      end

      it { expect(task.completed).to be false }
      it { expect(task.completed_at).to be_nil }
    end
  end
end
