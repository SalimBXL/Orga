require 'test_helper'

class AbsencesControllerTest < ActionDispatch::IntegrationTest
  setup do
    groupe = Groupe.new(nom: "nom")
    service = Service.new(nom: "nom")
    utilisateur = Utilisateur.new(nom: "nom", prenom: "prenom", email: "test@test.com", groupe: groupe, service: service)
    typeAbsence = TypeAbsence.new(nom: "test")
    @absence = Absence.create(date: Date.today, date_fin: Date.today + 5.days, type_absence: typeAbsence, utilisateur: utilisateur)
  end

  teardown do
    Rails.cache.clear
  end

  test "should get index" do
    get absences_path
    assert_response :success
  end

  test "should get new" do
    get new_absence_url
    assert_response :success
  end

  test "should create absence" do
    assert_difference('Absence.count') do
      post :create, post: @absence 
    end

    assert_redirected_to absences_path
  end

  test "should show absence" do
    get absence_path(@absence)
    assert_response :success
  end

  test "should get edit" do
    get edit_absence_url(@absence)
    assert_response :success
  end

  test "should update absence" do
    patch absence_url(@absence), params: { absence: { date: Today-1.day } }
    assert_redirected_to absences_path
    @absence.reload
    assert_equal Today-1.day, @absence.date
  end

  test "should destroy absence" do
    assert_difference('Absence.count', -1) do
      delete absence_path(@absence), xhr: true
    end    
  end

end
