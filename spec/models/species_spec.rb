require 'spec_helper'

describe Species do
  before(:each) {Species.create!(name: 'Grassachu', hp_growth: 5, attack_growth: 1, defense_growth: 0.4)}

  it {should validate_numericality_of(:hp_growth)}
  it {should validate_numericality_of(:attack_growth)}
  it {should validate_numericality_of(:defense_growth)}
  it {should validate_presence_of(:name)}
  it {should validate_uniqueness_of(:name)}

  it {should have_many(:monsters)}
end