require "application_system_test_case"

class FileResourcesTest < ApplicationSystemTestCase
  setup do
    @file_resource = file_resources(:one)
  end

  test "visiting the index" do
    visit file_resources_url
    assert_selector "h1", text: "File Resources"
  end

  test "creating a File resource" do
    visit file_resources_url
    click_on "New File Resource"

    fill_in "Name", with: @file_resource.name
    click_on "Create File resource"

    assert_text "File resource was successfully created"
    click_on "Back"
  end

  test "updating a File resource" do
    visit file_resources_url
    click_on "Edit", match: :first

    fill_in "Name", with: @file_resource.name
    click_on "Update File resource"

    assert_text "File resource was successfully updated"
    click_on "Back"
  end

  test "destroying a File resource" do
    visit file_resources_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "File resource was successfully destroyed"
  end
end
