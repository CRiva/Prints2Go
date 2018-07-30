require 'test_helper'

class RequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get requests_index_url
    assert_response :success
  end

  test "should get preview" do
    get requests_preview_url
    assert_response :success
  end

  test "should get list" do
    get requests_list_url
    assert_response :success
  end

  test "should get show" do
    get requests_show_url
    assert_response :success
  end

  test "should get new" do
    get requests_new_url
    assert_response :success
  end

  test "should get edit" do
    get requests_edit_url
    assert_response :success
  end

  test "should get create" do
    get requests_create_url
    assert_response :success
  end

  test "should get update" do
    get requests_update_url
    assert_response :success
  end

  test "should get destroy" do
    get requests_destroy_url
    assert_response :success
  end

  test "should get complete" do
    get requests_complete_url
    assert_response :success
  end

  test "should get upload" do
    get requests_upload_url
    assert_response :success
  end

  test "should get sort_column" do
    get requests_sort_column_url
    assert_response :success
  end

  test "should get sort_direction" do
    get requests_sort_direction_url
    assert_response :success
  end

end
