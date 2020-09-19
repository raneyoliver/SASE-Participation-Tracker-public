require 'rails_helper'

RSpec.describe Attendee, type: :model do
  context 'when a new Attendee is created' do
    before :each do
      @attendee_data = { UIN: '333333333', first_name: 'New', last_name: 'User', major: 'computer science',
                         graduation_year: 2021, email: 'email@address.com', phone_number: '333-333-3333' }
    end
    it 'is valid with all attributes' do
      expect(Attendee.new(@attendee_data)).to be_valid
    end
    it 'is not valid without a UIN' do
      @attendee_data.delete(:UIN)
      expect(Attendee.new(@attendee_data)).to_not be_valid
    end
    it 'is not valid without a first_name' do
      @attendee_data.delete(:first_name)
      expect(Attendee.new(@attendee_data)).to_not be_valid
    end
    it 'is not valid without a last_name' do
      @attendee_data.delete(:last_name)
      expect(Attendee.new(@attendee_data)).to_not be_valid
    end
    it 'is not valid without a major' do
      @attendee_data.delete(:major)
      expect(Attendee.new(@attendee_data)).to_not be_valid
    end
    it 'is not valid without a graduation_year' do
      @attendee_data.delete(:graduation_year)
      expect(Attendee.new(@attendee_data)).to_not be_valid
    end
    it 'is not valid without an email' do
      @attendee_data.delete(:email)
      expect(Attendee.new(@attendee_data)).to_not be_valid
    end
    it 'is valid without a phone number' do
      @attendee_data.delete(:phone_number)
      expect(Attendee.new(@attendee_data)).to be_valid
    end

    it 'is not valid with a first_name larger than 255 characters' do
      @attendee_data[:first_name] = 'a' * 256
      expect(Attendee.new(@attendee_data)).to_not be_valid
    end
    it 'is not valid with a last_name larger than 255 characters' do
      @attendee_data[:last_name] = 'a' * 256
      expect(Attendee.new(@attendee_data)).to_not be_valid
    end
    it 'is not valid with a major larger than 255 characters' do
      @attendee_data[:major] = 'a' * 256
      expect(Attendee.new(@attendee_data)).to_not be_valid
    end
    it 'is not valid with an email larger than 255 characters' do
      @attendee_data[:email] = 'a' * 256
      expect(Attendee.new(@attendee_data)).to_not be_valid
    end
    it 'is not valid with a phone_number larger than 255 characters' do
      @attendee_data[:phone_number] = 'a' * 256
      expect(Attendee.new(@attendee_data)).to_not be_valid
    end
    it 'is not valid with a UIN shorter than 9 characters' do
      @attendee_data[:UIN] = '33333333'
      expect(Attendee.new(@attendee_data)).to_not be_valid
    end
    it 'is not valid with a UIN longer than 9 characters' do
      @attendee_data[:UIN] = '3333333333'
      expect(Attendee.new(@attendee_data)).to_not be_valid
    end
    it 'is not valid with a graduation_year less than 2000' do
      @attendee_data[:graduation_year] = 1999
      expect(Attendee.new(@attendee_data)).to_not be_valid
    end
    it 'is valid with a graduation_year equal to 2000' do
      @attendee_data[:graduation_year] = 2000
      expect(Attendee.new(@attendee_data)).to be_valid
    end
    it 'is valid with a graduation_year just greater than 2000' do
      @attendee_data[:graduation_year] = 2001
      expect(Attendee.new(@attendee_data)).to be_valid
    end
    it 'is not valid with a graduation_year greater than 2050' do
      @attendee_data[:graduation_year] = 2051
      expect(Attendee.new(@attendee_data)).to_not be_valid
    end
    it 'is valid with a graduation_year equal to 2050' do
      @attendee_data[:graduation_year] = 2050
      expect(Attendee.new(@attendee_data)).to be_valid
    end
    it 'is valid with a graduation_year just less than 2050' do
      @attendee_data[:graduation_year] = 2049
      expect(Attendee.new(@attendee_data)).to be_valid
    end
  end

  context 'when no Attendees exist in the database' do
    it 'returns no Attendees to Attendees.all' do
      expect(Attendee.all).to eq([])
    end
  end
  context 'when Attendees exist in the database' do
    before :all do
      attendee_data = { UIN: '333333333', first_name: 'New', last_name: 'User', major: 'computer science',
                        graduation_year: 2021, email: 'email@address.com', phone_number: '333-333-3333' }
      @attendees = [Attendee.create(attendee_data)]
    end
    it 'returns all to Attendees.all' do
      expect(Attendee.all).to eq(@attendees)
    end
    after :all do
      Attendee.delete_all
    end
  end
end
