require 'spec_helper'

describe "AuthenticationPages" do
  subject { page }
  describe "login page" do
    before { visit login_path }

    it { should have_content('Log In') }

    describe "with invalid account" do
      before { click_button 'Log In' }

      it { should have_alert(:danger, text: 'Invalid') }

      describe "visiting another page" do
	before { click_link 'Home' }

	it { should_not have_alert(:danger) }
      end
    end

    describe "with valid account" do
      let(:user) { FactoryGirl.create(:user) }

      before do
	fill_in 'Username', with: user.username
	fill_in 'Password', with: user.password
	click_button 'Log In'
      end

      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Settings', href: edit_user_path(user)) }
      it { should have_link('Log Out', href: logout_path) }
      it { should_not have_link('Log In', href: login_path) }
      it { should_not have_link('Sign Up', href: signup_path) }

      it { should have_alert(:success) }

      describe "followed by logout" do
	before { click_link 'Log Out' }

	it { should have_link('Log In', href: login_path) }
	it { should have_link('Sign Up', href: signup_path) }
	it { should_not have_link('Log Out', href: logout_path) }
	it { should_not have_link('Profile') }

	it { should have_alert(:info) }
      end
    end
  end
end

describe "AuthorizationPages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }

  describe "non-authenticated users" do
    describe "for Users controller" do
      describe "edit action" do
	it_behaves_like "redirects to a login" do
	  let (:path) { edit_user_path(user) }
	  let (:method) { :patch }
	  let (:http_path) { user_path(user) }
	end
      end
    end

    describe "for Referees controller" do
      describe "new action" do
	it_behaves_like "redirects to a login" do
	  let (:path) { new_referee_path }
	  let (:method) { :post }
	  let (:http_path) { referees_path }
	end
      end
    end
  end

  describe "authenticated users" do
    describe "for Users controller" do
      it_behaves_like "redirects to root" do
	let (:login_user) { user }
	let (:path) { new_user_path }
	let (:signature) { 'Sign Up' }
	let (:error_type) { :warning }
	let (:method) { :post }
	let (:http_path) { users_path }
      end
    end

    describe "for Referees controller" do
      let(:creator) { FactoryGirl.create(:contest_creator) }

      before { login creator, avoid_capybara: true }
    end
  end

  describe "authenticated, but wrong user" do
    describe "for Users controller" do
      it_behaves_like "redirects to root" do
        let (:other_user) { FactoryGirl.create(:user) }
	let (:login_user) { user }
	let (:path) { edit_user_path(other_user) }
	let (:signature) { 'Edit user' }
	let (:error_type) { :danger }
	let (:method) { :patch }
	let (:http_path) { user_path(other_user) }
      end
    end

    describe "for Referees controller" do
      it_behaves_like "redirects to root" do
	let (:login_user) { user }
	let (:path) { new_referee_path }
	let (:signature) { 'Create Referee' }
	let (:error_type) { :danger }
	let (:method) { :post }
	let (:http_path) { referees_path }
      end

      it_behaves_like "redirects to root" do
	let (:referee) { FactoryGirl.create(:referee) }
	let (:login_user) { user }
	let (:path) { new_referee_path(referee) }
	let (:signature) { 'Edit Referee' }
	let (:error_type) { :danger }
	let (:method) { :patch }
	let (:http_path) { referee_path(referee) }
      end

      it_behaves_like "redirects to root", skip_browser: true do
	let (:referee) { FactoryGirl.create(:referee) }
	let (:login_user) { user }
	let (:error_type) { :danger }
	let (:method) { :delete }
	let (:http_path) { referee_path(referee) }
      end
    end
  end

  describe "authenticated, but non-admin user" do
    describe "for Users controller" do
      it_behaves_like "redirects to root", skip_browser: true do
	let (:other_user) { FactoryGirl.create(:user) }
	let (:login_user) { user }
	let (:error_type) { :danger }
	let (:method) { :delete }
	let (:http_path) { user_path(other_user) }
      end
    end
  end

  describe "authenticated admin user" do
    let(:admin) { FactoryGirl.create(:admin) }

    describe "delete action (self)", type: :request do
      it_behaves_like "redirects to root", skip_browser: true do
	let (:login_user) { admin }
	let (:error_type) { :danger }
	let (:method) { :delete }
	let (:http_path) { user_path(admin) }
      end
    end

    pending "edit action (other)" do
    end

    pending "update action (other)", type: :request do
    end
  end
end
