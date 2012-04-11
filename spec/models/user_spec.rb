require 'spec_helper'

describe User do
  before(:each) {User.create!(email: 'example@example.com', name: 'example', password: 'hellothere')}
  it {should validate_presence_of :email}
  it {should validate_uniqueness_of :email}

  specify {should_not allow_value('oetuhotueh').for(:email) }
  specify {should_not allow_value('').for(:email)}
  specify {should_not allow_value('uhuhuhu@uhuhuh').for(:email)}
  specify {should_not allow_value('uhoetuh.com').for(:email)}
  specify {should_not allow_value('example@example.com').for(:email)} #value already in use
  specify {should allow_value('test@example.com').for(:email)}
  specify {should allow_value('hellothere').for(:password)}
  specify {should_not allow_value('blah').for(:password)}
  specify {should_not allow_value('').for(:password)}

  specify {should have_many(:authentications)}
  specify {should have_many(:monsters)}
  #now test relationships with authentications
end
