require 'rails_helper'

describe SubTasksController do
  let!(:user) { create(:user, :auth) }
  let!(:task) { create(:task, user: user) }
  let!(:sub_task_1) do
    create(:sub_task, description: 'Sub Task 1', completed: true, task_id: task.id)
  end
  let!(:sub_task_2) do
    create(:sub_task, description: 'Sub Task 2', task_id: task.id)
  end

  before { sign_in(user) }

  describe "GET #index" do
    before { get :index, task_id: task.id }

    subject { JSON.parse(response.body) }

    it { expect(response.status).to eq 200 }

    it 'check JSON size' do
      expect(subject.size).to eq 2
    end

    it 'check JSON keys' do
      expect(subject.first.keys).to eq %w(id description completed)
      expect(subject.last.keys).to eq %w(id description completed)
    end

    it 'check JSON values' do
      expect(subject.first['description']).to eq 'Sub Task 1'
      expect(subject.first['completed']).to be true

      expect(subject.last['description']).to eq 'Sub Task 2'
      expect(subject.last['completed']).to be false
    end
  end

  describe '#create' do
    let(:json) { JSON.parse(response.body) }

    before { post :create, params }

    context 'success' do
      let(:params) do
        {
          task_id: task.id,
          sub_task: {
            description: 'Sample sub task'
          }
        }
      end

      it { expect(response.status).to eq 200 }
      it { expect(json['description']).to eq 'Sample sub task' }
    end

    context 'error' do
      let(:params) do
        {
          task_id: task.id,
          sub_task: {
            description: nil
          }
        }
      end

      it { expect(response.status).to eq 400 }
      it { expect(json['errors']).to eq ["Description can't be blank"] }
    end
  end

  describe '#destroy' do
    let(:message) { JSON.parse(response.body)['message'] }

    before { delete :destroy, params }

    context 'success' do
      let(:params) { { task_id: task.id, id: sub_task_1.id } }

      it { expect(response.status).to eq 200 }
      it { expect(message).to eq 'destroyed' }
    end

    context 'error' do
      let(:params) { { task_id: 9999, id: 9999 } }

      it { expect(response.status).to eq 409 }
      it { expect(message).to eq 'not destroyed' }
    end
  end

  describe '#update' do
    let(:message) { JSON.parse(response.body)['message'] }

    before { put :update, params }

    context 'success' do
      let(:params) do
        {
          task_id: task.id,
          id: sub_task_2.id,
          sub_task: {
            completed: true
          }
        }
      end

      it { expect(response.status).to eq 200 }
      it { expect(message).to eq 'updated' }

      it 'check completed attribute' do
        sub_task_2.reload

        expect(sub_task_2.completed).to be true
      end
    end

    context 'error' do
      let(:params) do
        {
          task_id: task.id,
          id: 999,
          sub_task: {
            completed: true,
          }
        }
      end

      it { expect(response.status).to eq 400 }
      it { expect(message).to eq 'not updated' }
    end
  end
end
