require 'spec_helper'

describe "UsersPages" do
<<<<<<< HEAD
  describe "Sign Up" do
      let(:submit) { 'Create User' }

    before { visit signup_path }

    describe "with invalid information" do
      it "does not add the user to the system" do
expect { click_button submit }.not_to change(User, :count)
=======
  subject { page }

  describe "Sign Up" do
    let(:submit) { 'Create new account' }

    before { visit signup_path }

    describe "passwords are not visible when typing" do
      it { should have_field 'user_password', type: 'password' }
      it { should have_field 'user_password_confirmation', type: 'password' }
    end

    describe "with invalid information" do
      it "does not add the user to the system" do
	expect { click_button submit }.not_to change(User, :count)
>>>>>>> bd5b9b574d2c967426d3b273e6122c673a63e46f
      end
    end

    describe "with valid information" do
      before do
<<<<<<< HEAD
        fill_in 'username', with: 'User Name'
        fill_in 'email', with: 'user@example.com'
        fill_in 'password', with: 'password'
        fill_in 'confirmation', with: 'password'
=======
	fill_in 'Username', with: 'User Name'
	fill_in 'Email', with: 'user@example.com'
	fill_in 'Password', with: 'password'
	fill_in 'Confirmation', with: 'password'
>>>>>>> bd5b9b574d2c967426d3b273e6122c673a63e46f
      end

      it "allows the user to fill in user fields" do
        click_button submit
      end

      it "adds a new user to the system" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end

  describe "Display Users" do
<<<<<<< HEAD
    subject { page }

=======
>>>>>>> bd5b9b574d2c967426d3b273e6122c673a63e46f
    describe "individually" do
      let(:user) { FactoryGirl.create(:user) }

      before { visit user_path(user) }

      it { should have_content(user.username) }
      it { should have_content(user.email) }
      it { should_not have_content(user.password) }
      it { should_not have_content(user.password_digest) }
    end

    describe "all" do
      before(:all) { 25.times { FactoryGirl.create(:user) } }
      after(:all) { User.all.each { |user| user.destroy } }

      before(:each) { visit users_path }

      it { should have_content('List of users') }
      it { should have_content('25 users') }

      # fix up with pagination later...
      User.all.each do |user|
<<<<<<< HEAD
it { should have_selector('li', text: user.username) }
=======
	it { should have_selector('li', text: user.username) }
>>>>>>> bd5b9b574d2c967426d3b273e6122c673a63e46f
      end
    end
  end

  describe "Edit users" do
<<<<<<< HEAD
    subject { page }

    let (:user) { FactoryGirl.create(:user) }
    let!(:orig_username) { user.username }
    let (:submit) { 'Update User' }

    before { visit edit_user_path(user) }

    it { should have_field('username', with: user.username) }
    it { should have_field('email', with: user.email) }
    it { should_not have_field('password', with: user.password) }

    describe "with invalid information" do
      before do
fill_in 'username', with: ''
fill_in 'password', with: user.password
fill_in 'confirmation', with: user.password
=======
    let (:user) { FactoryGirl.create(:user) }
    let!(:orig_username) { user.username }
    let (:submit) { 'Update account' }

    before { visit edit_user_path(user) }

    it { should have_field('Username', with: user.username) }
    it { should have_field('Email', with: user.email) }
    it { should_not have_field('Password', with: user.password) }

    describe "with invalid information" do
      before do
	fill_in 'Username', with: ''
	fill_in 'Password', with: user.password
	fill_in 'Confirmation', with: user.password
>>>>>>> bd5b9b574d2c967426d3b273e6122c673a63e46f
      end

      describe "does not change data" do
        before { click_button submit }

        specify { expect(user.reload.username).not_to eq('') }
        specify { expect(user.reload.username).to eq(orig_username) }
      end

      it "does not add a new user to the system" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
<<<<<<< HEAD
fill_in 'username', with: 'Changed name'
fill_in 'password', with: user.password
fill_in 'confirmation', with: user.password
=======
	fill_in 'Username', with: 'Changed name'
	fill_in 'Password', with: user.password
	fill_in 'Confirmation', with: user.password
>>>>>>> bd5b9b574d2c967426d3b273e6122c673a63e46f
      end

      describe "changes the data" do
        before { click_button submit }

        specify { expect(user.reload.username).to eq('Changed name') }
        specify { expect(user.reload.username).not_to eq(orig_username) }
      end

      it "does not add a new user to the system" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end
  end
<<<<<<< HEAD
=======

  describe "Delete users" do
    let!(:user) { FactoryGirl.create(:user) }

    before { visit users_path }

    it { should have_link('delete', href: user_path(user)) }
    it "removes a user from the system" do
      expect { click_link('delete') }.to change(User, :count).by(-1)
    end
  end
>>>>>>> bd5b9b574d2c967426d3b273e6122c673a63e46f
end
