require 'rails_helper'

RSpec.describe User, type: :model do
  context 'when a new User is created' do
    before :each do
      @user_data = { id: '3333333333333333333333333333333333333333', first_name: 'New', last_name: 'User',
                     major: 'computer science', graduation_year: 2021, email: 'email@address.com',
                     phone_number: '3333333333' }
    end
    it 'is valid with all attributes' do
      expect(User.new(@user_data)).to be_valid
    end
    it 'is not valid without a id' do
      @user_data.delete(:id)
      expect(User.new(@user_data)).to_not be_valid
    end
    it 'is not valid without a first_name' do
      @user_data.delete(:first_name)
      expect(User.new(@user_data)).to_not be_valid
    end
    it 'is not valid without a last_name' do
      @user_data.delete(:last_name)
      expect(User.new(@user_data)).to_not be_valid
    end
    it 'is not valid without a major' do
      @user_data.delete(:major)
      expect(User.new(@user_data)).to_not be_valid
    end
    it 'is not valid without a graduation_year' do
      @user_data.delete(:graduation_year)
      expect(User.new(@user_data)).to_not be_valid
    end
    it 'is not valid without an email' do
      @user_data.delete(:email)
      expect(User.new(@user_data)).to_not be_valid
    end
    it 'is valid without a phone number' do
      @user_data.delete(:phone_number)
      expect(User.new(@user_data)).to be_valid
    end
    it 'is not valid with a first_name larger than 255 characters' do
      @user_data[:first_name] = 'a' * 256
      expect(User.new(@user_data)).to_not be_valid
    end
    it 'is not valid with a last_name larger than 255 characters' do
      @user_data[:last_name] = 'a' * 256
      expect(User.new(@user_data)).to_not be_valid
    end
    it 'is not valid with a major larger than 255 characters' do
      @user_data[:major] = 'a' * 256
      expect(User.new(@user_data)).to_not be_valid
    end
    it 'is not valid with an email larger than 255 characters' do
      @user_data[:email] = 'a' * 256
      expect(User.new(@user_data)).to_not be_valid
    end
    it 'is not valid with a phone_number larger than 255 characters' do
      @user_data[:phone_number] = 'a' * 256
      expect(User.new(@user_data)).to_not be_valid
    end
    it 'is not valid with an id shorter than 40 characters' do
      @user_data[:id] = '3' * 39
      expect(User.new(@user_data)).to_not be_valid
    end
    it 'is not valid with an id longer than 40 characters' do
      @user_data[:id] = '3' * 41
      expect(User.new(@user_data)).to_not be_valid
    end
    it 'is not valid with a graduation_year less than 0' do
      @user_data[:graduation_year] = -1
      expect(User.new(@user_data)).to_not be_valid
    end
    it 'is valid with a graduation_year equal to 0' do
      @user_data[:graduation_year] = 0
      expect(User.new(@user_data)).to be_valid
    end
    it 'is valid with a graduation_year just greater than 0' do
      @user_data[:graduation_year] = 1
      expect(User.new(@user_data)).to be_valid
    end
    it 'is not valid with a graduation_year greater than 9999' do
      @user_data[:graduation_year] = 10_000
      expect(User.new(@user_data)).to_not be_valid
    end
    it 'is valid with a graduation_year equal to 9999' do
      @user_data[:graduation_year] = 9999
      expect(User.new(@user_data)).to be_valid
    end
    it 'is valid with a graduation_year just less than 9999' do
      @user_data[:graduation_year] = 9998
      expect(User.new(@user_data)).to be_valid
    end
    it 'is invalid with an email missing an @ sign and a dot' do
      @user_data[:email] = 'emailaddresscom'
      expect(User.new(@user_data)).to_not be_valid
    end
    it 'is invalid with an email missing an @ sign' do
      @user_data[:email] = 'emailaddress.com'
      expect(User.new(@user_data)).to_not be_valid
    end
    it 'is invalid with an email missing a dot after the @ sign' do
      @user_data[:email] = 'email@addresscom'
      expect(User.new(@user_data)).to_not be_valid
    end
    it 'is invalid with a non-blank phone number containing non-numerical characters' do
      @user_data[:phone_number] = '333333333a'
      expect(User.new(@user_data)).to_not be_valid
    end
    it 'is invalid with a non-blank phone number longer than 10 digits' do
      @user_data[:phone_number] = '33333333333'
      expect(User.new(@user_data)).to_not be_valid
    end
    it 'is invalid with a non-blank phone number shorter than 10 digits' do
      @user_data[:phone_number] = '333333333'
      expect(User.new(@user_data)).to_not be_valid
    end
  end

  context 'when no Users exist in the database' do
    it 'returns no Users to Users.all' do
      expect(User.all).to eq([])
    end
  end
  context 'when Users exist in the database' do
    before :all do
      user_data = { id: '3333333333333333333333333333333333333333', first_name: 'New', last_name: 'User',
                    major: 'computer science', graduation_year: 2021, email: 'email@address.com',
                    phone_number: '3333333333' }
      @users = [User.create(user_data)]
    end
    it 'returns all to users.all' do
      expect(User.all).to eq(@users)
    end
    after :all do
      User.delete_all
    end
  end
end
