require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    it 'is not valid if password and password confirmation do not match' do
      @user = User.create({
        first_name: "John",
        last_name: "Doe",
        email: "john.doe@gmail.com",
        password: "password",
        password_confirmation: "PASSWORD"
      })
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'is valid if password and password confirmation match' do
      @user = User.create({
        first_name: "John",
        last_name: "Doe",
        email: "john.doe@gmail.com",
        password: "password",
        password_confirmation: "password"
      })
      expect(@user).to be_valid
    end

    it 'is not valid if email addresses are not unique' do
      @user1 = User.create({
        first_name: "John",
        last_name: "Doe",
        email: "john.doe@gmail.com",
        password: "password",
        password_confirmation: "password"
      })
      @user2 = User.create({
        first_name: "Jonathan", 
        last_name: "Doenut",
        email: "JOHN.DOE@GMAIL.COM",
        password: "password2",
        password_confirmation: "password2"
      })
      expect(@user1).to be_valid
      expect(@user2).not_to be_valid
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it 'is not valid without an email address' do
      @user = User.create({
        first_name: "John",
        last_name: "Doe",
        email: nil,
        password: "password",
        password_confirmation: "password"
      })
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'is not valid without a first name' do
      @user = User.create({
        first_name: nil,
        last_name: "Doe",
        email: "john.doe@gmail.com",
        password: "password",
        password_confirmation: "password"
      })
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'is not valid without a last name' do
      @user = User.create({
        first_name: "John",
        last_name: nil,
        email: "john.doe@gmail.com",
        password: "password",
        password_confirmation: "password"
      })
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'is not valid without a password shorter than 8 characters' do
      @user = User.create({
        first_name: "John",
        last_name: "Doe",
        email: "john.doe@gmail.com",
        password: "pass",
        password_confirmation: "pass"
      })
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    it 'returns a user instance with a valid email and password' do
      @user = User.create({
        first_name: "John",
        last_name: "Doe",
        email: "john.doe@gmail.com",
        password: "password",
        password_confirmation: "password"
      })
      authenticated_user = User.authenticate_with_credentials("john.doe@gmail.com", "password")
      expect(authenticated_user).to eq(@user)
    end

    it 'returns a nil value when credentials do not match the record' do
      @user = User.create({
        first_name: "John",
        last_name: "Doe",
        email: "john.doe@gmail.com",
        password: "password",
        password_confirmation: "password"
      })
      authenticated_user = User.authenticate_with_credentials("john.doe@gmail.com", "D'OE!! I forgot...")
      expect(authenticated_user).to be_nil
    end

    it 'returns a valid user instance when user enters an email with leading or trailing spaces' do
      @user = User.create({
        first_name: "John",
        last_name: "Doe",
        email: "john.doe@gmail.com",
        password: "password",
        password_confirmation: "password"
      })
      authenticated_user = User.authenticate_with_credentials(" john.doe@gmail.com  ", "password")
      expect(authenticated_user).to eq(@user)
    end

    it 'returns a valid user instance when user enters an email in case-insensitive manner' do
      @user = User.create({
        first_name: "John",
        last_name: "Doe",
        email: "john.doe@gmail.com",
        password: "password",
        password_confirmation: "password"
      })
      authenticated_user = User.authenticate_with_credentials("JoHn.DoE@GmAiL.CoM", "password")
      expect(authenticated_user).to eq(@user)
    end
  end

end
