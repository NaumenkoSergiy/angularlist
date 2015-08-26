require 'spec_helper'
require 'top_tal_api'

describe 'Home', type: :feature do
  include Capybara::Angular::DSL

  context '#index' do
    let(:title) { Faker::Name.title }
    let!(:completed_task) { FactoryGirl.create(:task, completed: true) }
    let!(:uncompleted_task) { FactoryGirl.create(:task, completed: false) }

    it 'add task', js: true do
      sign_in
      visit root_path

      fill_in 'task-name', with: title
      click_button 'Add'
      page.should have_content(title)
    end

    it 'complete task', js: true do
      sign_in
      visit root_path

      all(:css, "input[type='checkbox']").last.set(true)
      within('.completed') do |f|
        page.should have_content(completed_task.title)
      end
    end

    it 'uncomplete task', js: true do
      sign_in
      visit root_path

      all(:css, "input[type='checkbox']").last.set(false)
      within('.completed') do |f|
        page.should_not have_content(uncompleted_task.title)
      end
    end

    it 'delete task' do
      sign_in
      visit root_path

      find('.glyphicon-trash').click
      page.should_not have_content(uncompleted_task.title)
    end

    it 'set priority for task' do
      sign_in
      visit root_path

      all('.due_date_priority').first.click
      find('input.editable-input').set(2)
      page.should have_content('priority: 2')
    end

    it 'set due date for task' do
      sign_in
      visit root_path

      all('.due_date_editable').first.click
      find('input.editable-input').set('2015-08-10')
      page.should have_content('due date: 2015-08-10 ')
    end
  end
end
