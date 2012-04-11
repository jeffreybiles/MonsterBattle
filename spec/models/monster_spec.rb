require 'spec_helper'

describe Monster do
  before(:each) {
    user = User.create!(name: "John", email: 'john@john.com', password: 'blahblahblah')
  }

  it {should belong_to(:user)}
  it {should belong_to(:species)}

  it {should validate_numericality_of(:level)}
  it {should validate_numericality_of(:experience)}

  it "will find the name of the connected user" do
    monster = FactoryGirl.build(:monster)
    monster.user.name == 'test'
  end

  it "will find the name of the connected species" do
    monster = FactoryGirl.build(:monster)
    monster.species.name == 'Grassachu'
  end

  it "will automatically set hp" do
    monster = FactoryGirl.create(:monster)
    monster.set_stats
    monster.max_hp <= monster.species.hp_growth * monster.level
    monster.max_hp >= monster.species.hp_growth * (monster.level - 0.5)
    monster.current_hp == monster.max_hp
  end

end
