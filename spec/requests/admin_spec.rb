require 'rails_helper'

RSpec.feature "Admin panel", :type => :feature do
  let!(:password){'123456'}
  let!(:email){'user@example.com'}
  let!(:user){
    User.create(
      email: email,
      password: password,
      password_confirmation: password
    ).add_role :admin
  }

  scenario "User enter admin panel" do
    visit admin_path
    expect(current_path).to eq new_user_session_path

    visit admin_path
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Log in'

    expect(current_path).to eq admin_path
    expect(page).to have_text("Orders")
  end
end