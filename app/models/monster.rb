class Monster < ActiveRecord::Base
  before_create :set_stats
  attr_accessible :custom_name, :experience, :level, :user_id, :species_id, :user_name

  belongs_to :user
  belongs_to :species

  validates :level, numericality: true
  validates :experience, numericality: true

  STATS = %w(hp attack defense)

  def set_stats
    unless self.level then self.level = 1 end
    unless self.experience then self.experience = 0 end
    #metaprogramming!  so proud! (It's safe too, because there is no way for user to modify STATS)
    STATS.each do |stat|
      eval("self.max_#{stat} = self.level * self.species.#{stat}_growth - (rand()*self.level/2).round(0)")
      eval("self.current_#{stat} = self.max_#{stat}")
    end
  end

end
