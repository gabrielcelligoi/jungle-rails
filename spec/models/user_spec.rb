require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'Validations' do

    it 'saves a new user if all fiels are correctly filled' do
      @new_user = User.new(
        first_name: 'Max', 
        last_name: "Verstappen", 
        email: 'max@redbull.com', 
        password: 'q1w2e3', 
        password_confirmation: 'q1w2e3'
      )
      @new_user.save

      expect(@new_user).to be_valid
    end

    it 'throws an error if the password and the confirmation password dont match' do
      @new_user = User.new(
        first_name: 'Max', 
        last_name: "Verstappen", 
        email: 'max@redbull.com', 
        password: 'q1w2e3', 
        password_confirmation: 'q1w2e4'
      )
      @new_user.save

      expect(@new_user).not_to be_valid
    end

    it 'throws an error if the password is empty' do
      @new_user = User.new(
        first_name: 'Max', 
        last_name: "Verstappen", 
        email: 'max@redbull.com', 
        password: nil, 
        password_confirmation: 'q1w2e3'
      )
      @new_user.save

      expect(@new_user).not_to be_valid
    end

    it 'throws an error if the email is already in use' do
      @user = User.new(
        first_name: 'Max', 
        last_name: "Wilson", 
        email: 'max@redbull.com', 
        password: 'qwerty', 
        password_confirmation: 'qwerty'
      )
      @user.save

      @new_user = User.new(
        first_name: 'Max', 
        last_name: "Verstappen", 
        email: 'max@redbull.com', 
        password: 'q1w2e3', 
        password_confirmation: 'q1w2e3'
      )
      @new_user.save

      expect(@user.id).to be_present
      expect(@new_user.id).to_not be_present
    end

    it 'the email verification should be case sensitive. throws an error if the email is already in use' do
      @user = User.new(
        first_name: 'Max', 
        last_name: "Wilson", 
        email: 'MAX@redbull.com', 
        password: 'qwerty', 
        password_confirmation: 'qwerty'
      )
      @user.save

      @new_user = User.new(
        first_name: 'Max', 
        last_name: "Verstappen", 
        email: 'max@redbull.com', 
        password: 'q1w2e3', 
        password_confirmation: 'q1w2e3'
      )
      @new_user.save

      expect(@user.id).to be_present
      expect(@new_user.id).to_not be_present
    end

    it 'Throws an error if the password have less than 3 characteres' do
      @new_user = User.new(
        first_name: 'Max', 
        last_name: "Verstappen", 
        email: 'max@redbull.com', 
        password: '12', 
        password_confirmation: '12'
      )
      @new_user.save

      expect(@new_user.id).to_not be_present
    end

  end

  describe '.authenticate_with_credentials' do
    
    it 'allows login if the authentication pass' do
      @new_user = User.create(
        first_name: 'Max', 
        last_name: "Verstappen", 
        email: 'max@redbull.com', 
        password: 'q1w2e3', 
        password_confirmation: 'q1w2e3'
      )
      @new_user.save

      @new_user_auth = User.authenticate_with_credentials('max@redbull.com', 'q1w2e3')

      expect(@new_user).to eq(@new_user_auth)

    end

    it 'not allows login if the authentication pass' do
      @new_user = User.create(
        first_name: 'Max', 
        last_name: "Verstappen", 
        email: 'max@redbull.com', 
        password: 'q1w2e3', 
        password_confirmation: 'q1w2e3'
      )
      @new_user.save

      @new_user_auth = User.authenticate_with_credentials('max@redbull.com', 'qwerty')

      expect(@new_user_auth).to eq(nil)

    end

    it 'allows authentication with spaces before or after email address' do
      @new_user = User.create(
        first_name: 'Max', 
        last_name: "Verstappen", 
        email: 'max@redbull.com', 
        password: 'q1w2e3', 
        password_confirmation: 'q1w2e3'
      )
      @new_user.save

      @new_user_auth = User.authenticate_with_credentials('   max@redbull.com   ', 'q1w2e3')

      expect(@new_user).to eq(@new_user_auth)

    end

    it 'allows login if there is case difference between the email registered and the auth email' do
      @new_user = User.create(
        first_name: 'Max', 
        last_name: "Verstappen", 
        email: 'max@redbull.com', 
        password: 'q1w2e3', 
        password_confirmation: 'q1w2e3'
      )
      @new_user.save

      @new_user_auth = User.authenticate_with_credentials('MAX@redbull.com', 'q1w2e3')

      expect(@new_user).to eq(@new_user_auth)

    end

  end


end
