require 'rails_helper'

feature 'Tasks' do
  let!(:wagner) { create(:user, :auth) }

  before { fill_login wagner }

  context 'create task' do
    scenario 'validates form and list task at tasks list' do
      click_link 'New Task'
      click_button 'Create Task'

      expect(page).to have_content "Description can't be blank"

      fill_in 'Description', with: 'Big Data Course'
      select 'particular', from: 'Kind'

      click_button 'Create Task'

      expect(page).to have_content 'Editing Task'

      click_link 'Back'

      expect(page).to have_content 'Listing Tasks'

      within 'tbody tr:nth-child(1)' do
        expect(page).to have_content 'false'
        expect(page).to have_content 'Big Data Course'
        expect(page).to have_link 'Edit'
        expect(page).to have_link 'Destroy'
      end
    end
  end

  context 'list tasks' do
    let!(:carla) { create(:user, name: 'Carla') }
    let!(:course) { create(:task, user: wagner, kind: :particular) }
    let!(:salon) { create(:task, user: carla, kind: :common) }

    scenario 'only display user tasks and public tasks from others users' do
      expect(page).to have_content 'Listing Tasks'

      within 'tbody tr:nth-child(1)' do
        expect(page).to have_content course.description
        expect(page).to have_link 'Edit'
        expect(page).to have_link 'Destroy'
      end

      within 'tbody tr:nth-child(2)' do
        expect(page).to have_content salon.description
        expect(page).to have_link 'Show'

        click_link 'Show'
      end

      expect(page).to have_content "User: #{carla.name}"
      expect(page).to have_content "Description: #{salon.description}"
      expect(page).to have_content "Kind: common"
    end
  end

  context 'edit task' do
    let!(:course) { create(:task, user: wagner, kind: :particular) }

    scenario 'create sub taks' do
      within 'tbody tr:nth-child(1)' do
        expect(page).to have_content course.description

        click_link 'Edit'
      end

      within '#sub_task_form' do
        fill_in 'Description', with: 'Big Data Course - Part 1'
        page.execute_script("$('#new_sub_task').submit()")

        fill_in 'Description', with: 'Big Data Course - Part 2'
        page.execute_script("$('#new_sub_task').submit()")

        fill_in 'Description', with: 'Big Data Course - Part 3'
        page.execute_script("$('#new_sub_task').submit()")
      end

      within '#sub_tasks' do
        expect(page).to have_content 'Big Data Course - Part 1'
        expect(page).to have_content 'Big Data Course - Part 2'
        expect(page).to have_content 'Big Data Course - Part 3'

        within('li:nth-child(3)') { click_button 'Remove' }

        expect(page).to have_content 'Big Data Course - Part 1'
        expect(page).to have_content 'Big Data Course - Part 2'

        expect(page).to_not have_content 'Big Data Course - Part 3'

        within('li:nth-child(1)') { find("input[type='checkbox']").set(true) }
        within('li:nth-child(2)') { find("input[type='checkbox']").set(true) }
      end

      click_link 'Back'

      within 'tbody tr:nth-child(1)' do
        expect(page).to have_content "true #{course.description}"
      end
    end
  end
end
