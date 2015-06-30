class Species < ActiveRecord::Base
  has_many :dinos
  validates :name, presence: true
  validates :diet, presence: true
  enum diet: [ :carnivore, :herbivore ]

  def humanized_diet
    diet.humanize
  end
end
