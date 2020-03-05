# frozen_string_literal: true

require 'test_helper'

class UnnovelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @unnovel = unnovels(:one)
  end

  test "should get index" do
    get unnovels_url
    assert_response :success
  end

  test "should get new" do
    get new_unnovel_url
    assert_response :success
  end

  test "should create unnovel" do
    assert_difference('Unnovel.count') do
      post unnovels_url, params: { unnovel: {} }
    end

    assert_redirected_to unnovel_url(Unnovel.last)
  end

  test "should show unnovel" do
    get unnovel_url(@unnovel)
    assert_response :success
  end

  test "should get edit" do
    get edit_unnovel_url(@unnovel)
    assert_response :success
  end

  test "should update unnovel" do
    patch unnovel_url(@unnovel), params: { unnovel: {} }
    assert_redirected_to unnovel_url(@unnovel)
  end

  test "should destroy unnovel" do
    assert_difference('Unnovel.count', -1) do
      delete unnovel_url(@unnovel)
    end

    assert_redirected_to unnovels_url
  end
end
