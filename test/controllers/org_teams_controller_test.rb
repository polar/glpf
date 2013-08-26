require 'test_helper'

class OrgTeamsControllerTest < ActionController::TestCase
  fixtures :all
  setup do
    @org_team = org_teams(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:org_teams)
  end

  test "should not get new if not admin" do
    get :new
    assert_response 302
  end

  test "should get new" do
    login_as :admin
    get :new
    assert_response :success
  end

  test "should not create org_team if not admin"  do
    assert_no_difference('OrgTeam.count') do
      post :create, org_team: { name: "Three", description: "Description for 3" }
    end
    # Should redirect to sign in page
    assert_response 302
  end

  test "should create org_team and corresponding category with same name" do
    login_as :admin
    assert_difference('OrgTeam.count') do
      post :create, org_team: { name: "Three", description: "Description for 3" }
    end

    org_team = assigns(:org_team)
    assert_not_nil org_team.category
    assert_equal org_team.name, org_team.category.name
    assert_redirected_to org_team_path(org_team)
  end

  test "should show org_team" do
    get :show, id: @org_team

    assert_equal @org_team, assigns(:org_team)
    assert_response :success
  end

  test "should not get edit if not admin" do
    get :edit, id: @org_team
    assert_response 302
  end

  test "should get edit" do
    login_as :admin
    get :edit, id: @org_team
    assert_equal @org_team, assigns(:org_team)
    assert_response :success
  end

  test "should update org_team and category" do
    login_as :admin
    patch :update, id: org_teams(:one), org_team: { name: "Changed" }
    assert_not_nil assigns(:org_team)
    assert_equal org_teams(:one), assigns(:org_team)
    assert_equal "Changed", assigns(:org_team).name
    assert_equal "Changed", assigns(:org_team).category.name
    assert_redirected_to org_team_path(assigns(:org_team))
  end

  test "should not destroy org_team if not admin" do
    assert_difference('OrgTeam.count', 0) do
      delete :destroy, id: @org_team
    end
  end

  test "should destroy org_team" do
    login_as :admin
    assert_difference('OrgTeam.count', -1) do
      delete :destroy, id: @org_team
    end

    assert_redirected_to org_teams_path
  end
end
