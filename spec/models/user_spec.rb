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

  end

end
