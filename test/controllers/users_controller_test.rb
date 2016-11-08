require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { authority: @user.authority, email: @user.email, id_num: @user.id_num, name: @user.name, office: @user.office, party_member: @user.party_member, password: 'secret', password_confirmation: 'secret', phone: @user.phone, phone_short: @user.phone_short } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { authority: @user.authority, email: @user.email, id_num: @user.id_num, name: @user.name, office: @user.office, party_member: @user.party_member, password: 'secret', password_confirmation: 'secret', phone: @user.phone, phone_short: @user.phone_short } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
