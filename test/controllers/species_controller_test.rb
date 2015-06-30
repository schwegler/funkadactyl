require 'test_helper'

class SpeciesControllerTest < ActionController::TestCase
  setup do
    @species = species(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:species)
  end

  test "should create species" do
    assert_difference('Species.count') do
      post :create, species: { aasm_state: @species.aasm_state, diet: @species.diet, name: @species.name }
    end

    assert_response 201
  end

  test "should show species" do
    get :show, id: @species
    assert_response :success
  end

  test "should update species" do
    put :update, id: @species, species: { aasm_state: @species.aasm_state, diet: @species.diet, name: @species.name }
    assert_response 204
  end

  test "should destroy species" do
    assert_difference('Species.count', -1) do
      delete :destroy, id: @species
    end

    assert_response 204
  end
end
