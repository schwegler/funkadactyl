# spec/apis/dinos_api_spec.rb
require 'spec_helper'

describe CagesController, :type => :request do
  let(:valid_session) { {} }
  context 'reading cages' do
    it 'retrieves a specific cage' do
      cage = create(:cage)
      get "/cages/#{cage.id}", { format: :json }

      expect(response).to be_success
      expect(response.body).to eq(cage.to_json) 
    end

    it 'retrieves index of cages' do
      cages = create_list(:cage, 10)
      get "/cages", { format: :json }

      expect(response).to be_success

      json = JSON.parse(response.body)

      expect(json.length).to eq(10)
    end

    it 'retrieves index of cages filtered by aasm_state' do
      create_list(:cage, 10)
      get "/cages/1/power_down", { format: :json }
      get "/cages?aasm_state=down", { format: :json }

      expect(response).to be_success

      json = JSON.parse(response.body)
      expect(json.length).to eq(1)
    end
  end

  context 'new/updated cage success' do
    it 'creates a new cage with valid params' do
      dino_params = {
        "cage" => {
          "capacity" => 1,
        }
      }.to_json
      request_headers = {
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      }
      post "/cages", dino_params, request_headers

      expect(response.status).to eq(201)
      expect(Cage.last.capacity).to eq(1) 
    end

    it 'updates an old cage with valid params' do
      cage = create(:cage, capacity: 100)
      new_dino_params = {
        "cage" => {
          "capacity" => 99
        }
      }.to_json
      request_headers = {
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      }
      put "/cages/#{cage.id}", new_dino_params, request_headers

      expect(response.status).to eq(204)
      expect(Cage.find_by_id(cage.id).capacity).to eq(99) 
    end

    it 'deletes an old cage' do
      cage = create(:cage)
      delete "/cages/#{cage.id}"

      expect(response.status).to eq(204)
      expect(Cage.count).to eq(0) 
    end
  end

  context 'update cage when invalid' do
    before do
      cage_up = create(:cage, capacity: 11)
      species1 = create(:species, diet: 'herbivore', name: 'Salady')
      create_list(:dino, 10, cage_id: cage_up.id, species_id: species1.id)
    end

    it 'fails to power down an occupied cage' do
      cage_up = create(:cage)
      create_list(:dino, 2, cage_id: cage_up.id) 
      get "/cages/#{cage_up.id}/power_down", { format: :json }

      expect(response.status).to eq(403)
      json = JSON.parse(response.body)
      expect(json['error'].to_s).to eq("Cage is occupied, so it can't power down.")
    end
  end 
end
