require 'test_helper'

class CagesControllerTest < ActionController::TestCase
  setup do
    @cage = cages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cages)
  end

  test "should create cage" do
    assert_difference('Cage.count') do
      post :create, cage: { aasm_state: @cage.aasm_state, capacity: @cage.capacity }
    end

    assert_response 201
  end

  test "should show cage" do
    get :show, id: @cage
    assert_response :success
  end

  test "should update cage" do
    put :update, id: @cage, cage: { aasm_state: @cage.aasm_state, capacity: @cage.capacity }
    assert_response 204
  end

  test "should destroy cage" do
    assert_difference('Cage.count', -1) do
      delete :destroy, id: @cage
    end

    assert_response 204
  end
end
