require File.dirname(__FILE__) + '/../test_helper'

class StarsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:stars)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_star
    assert_difference('Star.count') do
      post :create, :star => { }
    end

    assert_redirected_to star_path(assigns(:star))
  end

  def test_should_show_star
    get :show, :id => stars(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => stars(:one).id
    assert_response :success
  end

  def test_should_update_star
    put :update, :id => stars(:one).id, :star => { }
    assert_redirected_to star_path(assigns(:star))
  end

  def test_should_destroy_star
    assert_difference('Star.count', -1) do
      delete :destroy, :id => stars(:one).id
    end

    assert_redirected_to stars_path
  end
end
