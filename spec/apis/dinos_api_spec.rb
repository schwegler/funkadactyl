# spec/apis/dinos_api_spec.rb
require 'spec_helper'

describe DinosController, :type => :request do
  let(:valid_session) { {} }
  context 'reading dinos' do
    it 'retrieves a specific dino' do
      dino = create(:dino)
      get "/dinos/#{dino.id}", { format: :json }

      expect(response).to be_success
      expect(response.body).to eq(dino.to_json) 
    end

    it 'retrieves index of dinos' do
      dinos = create_list(:dino, 10)
      get "/dinos", { format: :json }

      expect(response).to be_success

      json = JSON.parse(response.body)

      expect(json.length).to eq(10)
    end

    it 'retrieves index of dinos filtered by cage_id' do
      create_list(:cage, 2)
      create_list(:dino, 10, cage_id: 1)
      create_list(:dino, 5, cage_id: 2)

      get "/dinos?cage_id=2", { format: :json }

      expect(response).to be_success

      json = JSON.parse(response.body)

      expect(json.length).to eq(5)
    end
  end

  context 'new/updated dino success' do
    before do
      create(:cage)
      create(:species)
    end

    it 'creates a new dino with valid params' do
      dino_params = {
        "dino" => {
          "name" => "RuPaul",
          "cage_id" => 1,
          "species_id" => 1
        }
      }.to_json
      request_headers = {
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      }
      post "/dinos", dino_params, request_headers

      expect(response.status).to eq(201)
      expect(Dino.last.name).to eq("RuPaul") 
    end

    it 'updates an old dino with valid params' do
      dino = create(:dino, name: "RuRu")
      new_dino_params = {
        "dino" => {
          "name" => "Charles"
        }
      }.to_json
      request_headers = {
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      }
      put "/dinos/#{dino.id}", new_dino_params, request_headers

      expect(response.status).to eq(204)
      expect(Dino.find_by_id(dino.id).name).to eq("Charles") 
    end

    it 'deletes an old dino' do
      dino = create(:dino)
      delete "/dinos/#{dino.id}"

      expect(response.status).to eq(204)
      expect(Dino.count).to eq(0) 
    end
  end

  context 'new/updated dino when invalid' do
    before do
      cage_up = create(:cage, capacity: 11)
      species1 = create(:species, diet: 'herbivore', name: 'Salady')
      create_list(:dino, 10, cage_id: cage_up.id, species_id: species1.id)
    end

    it 'fails to add a dino to a full cage' do
      dino_params = {
        "dino" => {
          "name" => "RuPaul",
          "cage_id" => 1,
          "species_id" => 1
        }
      }.to_json
      request_headers = {
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      }
      post "/dinos", dino_params, request_headers
      expect(response.status).to eq(201)
      post "/dinos", dino_params, request_headers 
      expect(response.status).to eq(422)
      json = JSON.parse(response.body)
      expect(json['base'].last.to_s).to eq("There are no vacancies in the selected cage.")
    end

    it 'fails to add a dino to a down cage' do
      cage_down = create(:cage, aasm_state: 'down')
      dino_params = {
        "dino" => {
          "name" => "RuPaul",
          "cage_id" => 2,
          "species_id" => 1
        }
      }.to_json
      request_headers = {
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      }
      post "/dinos", dino_params, request_headers 
      expect(response.status).to eq(422)
      json = JSON.parse(response.body)
      expect(json['base'].last.to_s).to eq("The selected cage is down.")
    end

    it 'fails to add a carnivore to a cage with hippies' do
      species2 = create(:species, diet: 'carnivore', name: 'Meaty')
      dino_params = {
        "dino" => {
          "name" => "Hannibal",
          "cage_id" => 1,
          "species_id" => 2
        }
      }.to_json
      request_headers = {
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      }
      post "/dinos", dino_params, request_headers 
      expect(response.status).to eq(422)
      json = JSON.parse(response.body)
      expect(json['base'].last.to_s).to eq("Please select a cage containing only dinosaurs with the same diet as this one.")
    end

    it 'fails to add a carnivore to a cage with a different carnivore' do
      cage3 = create(:cage, capacity: 11)
      species2 = create(:species, diet: 'carnivore', name: 'Meaty')
      species3 = create(:species, diet: 'carnivore', name: 'Monster')
      dino1_params = {
        "dino" => {
          "name" => "Hannibal",
          "cage_id" => cage3.id,
          "species_id" => species2.id,
        }
      }.to_json
      dino2_params = {
        "dino" => {
          "name" => "Lady Gaga",
          "cage_id" => cage3.id,
          "species_id" => species3.id,
        }
      }.to_json
      request_headers = {
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      }
      post "/dinos", dino1_params, request_headers 
      expect(response.status).to eq(201)
      post "/dinos", dino2_params, request_headers
      json = JSON.parse(response.body)
      expect(response.status).to eq(422)
      expect(json['base'].last.to_s).to eq("Carnivores may only be housed with their own species.")
    end
  end 
end
