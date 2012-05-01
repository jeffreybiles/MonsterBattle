require 'spec_helper'

describe "Moves" do
  it "should create new move" do
    visit moves_path
    click_link 'New Move'
    fill_in 'Name', with: 'test'
    fill_in 'Damage', with: 10
    fill_in 'Hit chance', with: 5
    click_button 'Save'
    page.should have_content("Create successful!")
  end
end
