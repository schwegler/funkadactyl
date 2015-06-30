class Cage < ActiveRecord::Base
  include AASM
	has_many :dinos

  aasm do
    state :active, :initial => true
    state :down

    event :power_down do
      transitions :from => :active, :to => :down, :guard => :cage_empty?
    end

    event :power_up do
      transitions :from => :down, :to => :active
    end
  end

  def dino_count
    dinos.count
  end

  def cage_empty?
    dinos.count == 0
  end
end
