require 'test_helper'

class TypeAbsencesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @type_absence = TypeAbsence.create(nom: "Nom Absence", description: "Une description...")
  end

  teardown do
    Rails.cache.clear
  end

  test "should get index" do
    get type_absences_url
    assert_response :success
  end

  test "should get new" do
    get new_type_absence_url
    assert_response :success
  end

  test "should create type_absence" do
    assert_difference('TypeAbsence.count') do
      post type_absences_url, params: { type_absence: { nom: "test", description: "Description" } }
    end

    assert_redirected_to type_absences_path
  end

  test "should show type_absence" do
    get type_absence_url(@type_absence)
    assert_response :success
  end

  test "should get edit" do
    get edit_type_absence_url(@type_absence)
    assert_response :success
  end

  test "should update type_absence" do
    patch type_absence_path(@type_absence), params: { type_absence: { nom: "Nouveau" } }
    assert_redirected_to type_absences_path
    @type_absence.reload
    assert_equal "Nouveau", @type_absence.nom
  end

  test "should destroy type_absence" do
    assert_difference('TypeAbsence.count', -1) do
      delete type_absence_url(@type_absence)
    end

    assert_redirected_to type_absences_url
  end
end
