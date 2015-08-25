require 'spec_helper'
require 'top_tal_api'

describe 'Home', type: :feature do

  context '#index' do
    it "add task", js: true do
      sign_in
      visit root_path
      title = Faker::Name.title
      fill_in 'task-name', with: title
      click_button 'Add'
      page.should have_content(title)
    end

    it "complete task", js: true do
      sign_in
      visit root_path
      title = Faker::Name.title
      fill_in 'task-name', with: title
      click_button 'Add'
      page.should have_content(title)
      all(:css, "input[type='checkbox']").last.set(true)
      within('.completed') do |f|
        page.should have_content(title)
      end
    end
  end
end
