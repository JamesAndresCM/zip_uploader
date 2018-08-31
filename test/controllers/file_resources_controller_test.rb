require 'test_helper'

class FileResourcesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @file_resource = file_resources(:one)
  end

  test "should get index" do
    get file_resources_url
    assert_response :success
  end

  test "should get new" do
    get new_file_resource_url
    assert_response :success
  end

  test "should create file_resource" do
    assert_difference('FileResource.count') do
      post file_resources_url, params: { file_resource: { name: @file_resource.name } }
    end

    assert_redirected_to file_resource_url(FileResource.last)
  end

  test "should show file_resource" do
    get file_resource_url(@file_resource)
    assert_response :success
  end

  test "should get edit" do
    get edit_file_resource_url(@file_resource)
    assert_response :success
  end

  test "should update file_resource" do
    patch file_resource_url(@file_resource), params: { file_resource: { name: @file_resource.name } }
    assert_redirected_to file_resource_url(@file_resource)
  end

  test "should destroy file_resource" do
    assert_difference('FileResource.count', -1) do
      delete file_resource_url(@file_resource)
    end

    assert_redirected_to file_resources_url
  end
end
