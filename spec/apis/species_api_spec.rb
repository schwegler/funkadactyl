# spec/apis/dinos_api_spec.rb
require 'spec_helper'

describe SpeciesController, :type => :request do
  let(:valid_session) { {} }
  context 'reading species' do
    it 'retrieves a specific species' do
      species = create(:species)
      get "/species/#{species.id}", { format: :json }

      expect(response).to be_success
      expect(response.body).to eq(species.to_json) 
    end

    it 'retrieves index of species' do
      species = create_list(:species, 10)
      get "/species", { format: :json }

      expect(response).to be_success

      json = JSON.parse(response.body)

      expect(json.length).to eq(10)
    end

    it 'retrieves index of species filtered by diet' do
      create_list(:species, 10, diet: 'carnivore')
      create_list(:species, 20, diet: 'herbivore')
      get "/species?diet=carnivore", { format: :json }

      expect(response).to be_success

      json = JSON.parse(response.body)
      expect(json.length).to eq(10)
    end
  end

  context 'new/updated species success' do
    it 'creates a new species with valid params' do
      species_params = {
        "species" => {
          "name" => '#DadBod',
          "diet" => 'carnivore'
        }
      }.to_json
      request_headers = {
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      }
      post "/species", species_params, request_headers

      expect(response.status).to eq(201)
      expect(Species.last.diet).to eq('carnivore') 
    end

    it 'updates an old species with valid params' do
      species = create(:species, diet: 'herbivore')
      new_dino_params = {
        "species" => {
          "diet" => 'carnivore'
        }
      }.to_json
      request_headers = {
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      }
      put "/species/#{species.id}", new_dino_params, request_headers

      expect(response.status).to eq(204)
      expect(Species.find_by_id(species.id).diet).to eq('carnivore') 
    end

    it 'deletes an old species' do
      species = create(:species)
      delete "/species/#{species.id}"

      expect(response.status).to eq(204)
      expect(Species.count).to eq(0) 
    end
  end

  context 'update species when invalid' do
    before do
      species = create(:species, diet: 'herbivore', name: 'Salady')
    end

    it 'fails to update' do
      species_params = {
        "species" => {
          "diet" => nil,
        }
      }.to_json
      request_headers = {
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      }
      post "/species", species_params, request_headers

      expect(response.status).to eq(422)
      expect(Species.last.diet).to eq('herbivore') 
    end
  end 
end
