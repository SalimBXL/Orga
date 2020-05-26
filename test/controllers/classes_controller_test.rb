require 'test_helper'

class ClassesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @classe = Classe.create(nom: "Nom", description: "Description...")
  end

  teardown do
    Rails.cache.clear
  end

  test "should get index" do
    get classes_url
    assert_response :success
  end

  test "should get new" do
    get new_class_url
    assert_response :success
  end

  test "should create classe" do
    assert_difference('Classe.count') do
      post classes_url, params: { classe: { nom: "test", description: "Description" } }
    end

    assert_redirected_to classes_path
  end

  test "should show class" do
    get class_url(@classe)
    assert_response :success
  end

  test "should get edit" do
    get edit_class_url(@classe)
    assert_response :success
  end

  test "should update class" do
    patch class_url(@classe), params: { classe: { nom:"Autre" } }
    assert_redirected_to classes_path
    @classe.reload
    assert_equal "Autre", @classe.nom
  end

  test "should destroy class" do
    assert_difference('Classe.count', -1) do
      delete class_path(@classe), xhr: true
    end    
  end
end
