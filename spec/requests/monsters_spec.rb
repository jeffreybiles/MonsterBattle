require 'spec_helper'

describe "Monsters" do
  describe "GET /monsters" do
    before(:each) {visit monsters_path}

    specify {page.should have_content("monsters")}
    specify {page.should have_content("Level")}
    specify {page.should have_content("New Monster")}

    describe "new monster page" do
      let(:user){ @user ||= FactoryGirl.create(:user) }
      let(:species){ @species ||= FactoryGirl.create(:species) }

      before(:each) do
         user
         species
         click_link "New Monster"
      end

      specify {page.should have_content("Back")}
      it "should make new monster" do
        fill_in 'Custom name', with: "Testy!"
        fill_in 'Level', with: 10
        fill_in 'Experience', with: 0
        page.select 'test', from: 'User'
        page.select 'Grassachu', from: 'Species'
        click_button 'Save'
        page.should have_content("Create successful!")
      end
    end
  end
end
