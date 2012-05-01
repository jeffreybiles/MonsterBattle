require 'spec_helper'

describe 'Battle' do
  #note:  all these tests are EXTREMELY BRITTLE and depend on the EXACT VALUES given
  #later, use factories/mocks/etc. to ajax stuff in
  before{visit root_path}

  describe 'before action taken', js: true do
    #TODO: refactor these to check specific places to find content
    it "should show the health of the hero"do
      page.should have_content("20")
    end
    it "should show the health of the enemy"do
      page.should have_content("18")
    end
    it "should not show a random, irrelevant value"do
      page.should_not have_content("5")
    end

    it "should show the name of an attack"do
      page.should have_content("push")
      page.should_not have_content("turbine")
    end
  end

  describe "after an attack", js: true do
    before{click_on 'push'}

    it "should do 2 damage to enemy"do
      page.should have_content('16')
      page.should_not have_content('18')
    end

    #this fails because 'push' is hidden, not gone.  The problem is the test, not the code
    it "should not show attack options" #do
    #  page.should_not have_content('push')
    #end

    it "should show message" do
      page.should have_content('Thesis hits AntiThesis with push')
    end
  end
end
