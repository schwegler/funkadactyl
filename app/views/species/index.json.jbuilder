json.array!(@species) do |species|
  json.extract! species, :id, :name, :diet, :aasm_state
  json.url species_url(species, format: :json)
end
