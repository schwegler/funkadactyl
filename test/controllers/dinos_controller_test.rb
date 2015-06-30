require 'test_helper'

class DinosControllerTest < ActionController::TestCase
  setup do
    @dino = dinos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dinos)
  end

  test "should create dino" do
    assert_difference('Dino.count') do
      post :create, dino: { aasm_state: @dino.aasm_state, name: @dino.name, species_id: @dino.species_id }
    end

    assert_response 201
  end

  test "should show dino" do
    get :show, id: @dino
    assert_response :success
  end

  test "should update dino" do
    put :update, id: @dino, dino: { aasm_state: @dino.aasm_state, name: @dino.name, species_id: @dino.species_id }
    assert_response 204
  end

  test "should destroy dino" do
    assert_difference('Dino.count', -1) do
      delete :destroy, id: @dino
    end

    assert_response 204
  end
end
