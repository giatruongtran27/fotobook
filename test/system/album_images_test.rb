require "application_system_test_case"

class AlbumImagesTest < ApplicationSystemTestCase
  setup do
    @album_image = album_images(:one)
  end

  test "visiting the index" do
    visit album_images_url
    assert_selector "h1", text: "Album Images"
  end

  test "creating a Album image" do
    visit album_images_url
    click_on "New Album Image"

    click_on "Create Album image"

    assert_text "Album image was successfully created"
    click_on "Back"
  end

  test "updating a Album image" do
    visit album_images_url
    click_on "Edit", match: :first

    click_on "Update Album image"

    assert_text "Album image was successfully updated"
    click_on "Back"
  end

  test "destroying a Album image" do
    visit album_images_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Album image was successfully destroyed"
  end
end
