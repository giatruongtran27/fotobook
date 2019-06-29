require 'test_helper'

class AlbumImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @album_image = album_images(:one)
  end

  test "should get index" do
    get album_images_url
    assert_response :success
  end

  test "should get new" do
    get new_album_image_url
    assert_response :success
  end

  test "should create album_image" do
    assert_difference('AlbumImage.count') do
      post album_images_url, params: { album_image: {  } }
    end

    assert_redirected_to album_image_url(AlbumImage.last)
  end

  test "should show album_image" do
    get album_image_url(@album_image)
    assert_response :success
  end

  test "should get edit" do
    get edit_album_image_url(@album_image)
    assert_response :success
  end

  test "should update album_image" do
    patch album_image_url(@album_image), params: { album_image: {  } }
    assert_redirected_to album_image_url(@album_image)
  end

  test "should destroy album_image" do
    assert_difference('AlbumImage.count', -1) do
      delete album_image_url(@album_image)
    end

    assert_redirected_to album_images_url
  end
end
