require 'test_helper'

class UserfeedbacksControllerTest < ActionController::TestCase
  setup do
    @userfeedback = userfeedbacks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:userfeedbacks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create userfeedback" do
    assert_difference('Userfeedback.count') do
      post :create, userfeedback: { email: @userfeedback.email, feedback: @userfeedback.feedback }
    end

    assert_redirected_to userfeedback_path(assigns(:userfeedback))
  end

  test "should show userfeedback" do
    get :show, id: @userfeedback
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @userfeedback
    assert_response :success
  end

  test "should update userfeedback" do
    patch :update, id: @userfeedback, userfeedback: { email: @userfeedback.email, feedback: @userfeedback.feedback }
    assert_redirected_to userfeedback_path(assigns(:userfeedback))
  end

  test "should destroy userfeedback" do
    assert_difference('Userfeedback.count', -1) do
      delete :destroy, id: @userfeedback
    end

    assert_redirected_to userfeedbacks_path
  end
end
