class Dino < ActiveRecord::Base
  belongs_to :cage
  belongs_to :species
  validates :name, presence: true
  validates :species_id, presence: true
  validate :evaluate_harmony
  validate :evaluate_vacancy
  validate :evaluate_cage_power

  def evaluate_harmony
    if cage.dinos.any?
      if cage.dinos.map{|d| d.diet}.uniq.count > 1 || cage.dinos.last.diet != self.diet
        errors[:base] << ('Please select a cage containing only dinosaurs with the same diet as this one.')
      elsif cage.dinos.last.diet == 'carnivore' && cage.dinos.last.species != self.species
        errors[:base] << ('Carnivores may only be housed with their own species.')
      end        
    end
  end

  def evaluate_vacancy
    if cage.dinos.count >= cage.capacity
      errors[:base] << ('There are no vacancies in the selected cage.')
    end
  end

  def evaluate_cage_power 
    if cage.aasm_state == 'down'
      errors[:base] << ('The selected cage is down.') 
    end
  end

  def diet
    species.diet if species
  end
end
