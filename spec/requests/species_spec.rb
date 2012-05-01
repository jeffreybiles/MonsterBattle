require 'spec_helper'

describe "Species" do
  it "should create new species" do
    visit species_index_path
    click_link 'New Species'
    fill_in 'Name', with: 'test'
    fill_in 'Hp growth', with: 10
    fill_in 'Attack growth', with: 5
    fill_in 'Defense growth', with: 5
    click_button 'Save'
    page.should have_content("Create successful!")
  end
end
