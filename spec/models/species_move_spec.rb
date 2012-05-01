require 'spec_helper'

describe SpeciesMove do
  describe "SpeciesMove" do
    #let(:move){ @move ||= FactoryGirl.create(:move) }
    #let(:species){ @species ||= FactoryGirl.create(:species) }

    it "should make new species_move" do
      visit '/'  #test, why you broke?!?!?!
      click_link 'species_moves'
      move
      species
      click_link "New Species Move"

      fill_in 'Level learned', with: 10
      page.select 'slash', from: 'Move'
      page.select 'Grassachu', from: 'Species'
      click_button 'Save'
      page.should have_content("Create successful!")
    end
  end
end
