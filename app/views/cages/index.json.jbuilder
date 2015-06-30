json.array!(@cages) do |cage|
  json.extract! cage, :id, :capacity, :aasm_state
  json.url cage_url(cage, format: :json)
end
