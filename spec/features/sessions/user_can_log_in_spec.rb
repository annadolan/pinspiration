require 'rails_helper'

describe "a user can log in" do
  scenario "a user visits login page and logs in" do
    user = create(:user)
    visit login_path

    fill_in "email", with: "#{user.email}"
    fill_in "password", with: "#{user.password}"

    click_button "Login"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Successfully logged in as #{user.name}")
    expect(page).to have_selector("#logout")
    expect(page).to_not have_selector("#login")
  end

  describe "a user cannot log in" do
    scenario "a user enters an incorrect password" do
      user = create(:user)
      visit login_path

      fill_in "email", with: "#{user.email}"
      fill_in "password", with: "dogs"

      click_button "Login"

      expect(page).to have_content("Login failed, please try again.")

      expect(page).to have_selector("#login")
      expect(page).to_not have_selector("#logout")
    end

    scenario "a user cannot log in with incomplete information" do
      user = create(:user)
      visit login_path

      fill_in "email", with: ""
      fill_in "password", with: "#{user.password}"

      click_button "Login"

      expect(page).to have_content("Login failed, please try again.")
      expect(page).to have_selector("#login")
      expect(page).to_not have_selector("#logout")
    end
  end
end
