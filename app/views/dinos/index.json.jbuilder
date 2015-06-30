json.array!(@dinos) do |dino|
  json.extract! dino, :id, :name, :species_id, :aasm_state
  json.url dino_url(dino, format: :json)
end
