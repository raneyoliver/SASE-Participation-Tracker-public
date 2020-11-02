require 'rails_helper'

RSpec.describe FormUser, type: :model do
  context 'when a new FormUser is created' do
    before :each do
      @event_data = { id: 1, name: 'Test Event', description: 'description', event_type: 'GBM',
                      start_time: '2020-09-15T01:00:00.000Z', end_time: '2020-09-15T00:00:00.000Z' }
      Event.create(@event_data)
      @form_data = { id: '8888888888', event_id: 1, form_type: 'sign-in' }
      Form.create(@form_data)
      @user_data = { id: '3333333333333333333333333333333333333333', first_name: 'New', last_name: 'User',
                     major: 'computer science', graduation_year: 2021, email: 'email@address.com',
                     phone_number: '3333333333' }
      User.create(@user_data)
      @form_user_data = { form_id: '8888888888', user_id: '3333333333333333333333333333333333333333' }
    end
    it 'is valid with all attributes' do
      expect(FormUser.new(@form_user_data)).to be_valid
    end
    it 'is not valid without form_id' do
      @form_user_data.delete(:form_id)
      expect(FormUser.new(@form_user_data)).to_not be_valid
    end
    it 'is not valid without a user_id' do
      @form_user_data.delete(:user_id)
      expect(FormUser.new(@form_user_data)).to_not be_valid
    end
    it 'is not valid with a form_id larger than 32 characters' do
      @form_user_data[:form_id] = 'a' * 33
      expect(FormUser.new(@form_user_data)).to_not be_valid
    end
    it 'is not valid with a user_id shorter than 40 characters' do
      @form_user_data[:user_id] = '3' * 39
      expect(FormUser.new(@form_user_data)).to_not be_valid
    end
    it 'is not valid with a user_id longer than 40 characters' do
      @form_user_data[:user_id] = '3' * 41
      expect(FormUser.new(@form_user_data)).to_not be_valid
    end
    after :all do
      Event.delete_all
      Form.delete_all
      User.delete_all
    end
  end

  context 'when no FormUser exist in the database' do
    it 'returns no FormUser to FormUser.all' do
      expect(FormUser.all).to eq([])
    end
  end

  context 'when FormUser exist in the database' do
    before :all do
      @event_data = { id: 1, name: 'Test Event', description: 'description', event_type: 'GBM',
                      start_time: '2020-09-15T01:00:00.000Z', end_time: '2020-09-15T00:00:00.000Z' }
      Event.create(@event_data)
      @form_data = { id: '8888888888', event_id: 1, form_type: 'sign-in' }
      Form.create(@form_data)
      @user_data = { id: '3333333333333333333333333333333333333333', first_name: 'New', last_name: 'User',
                     major: 'computer science', graduation_year: 2021, email: 'email@address.com',
                     phone_number: '3333333333' }
      User.create(@user_data)
      @form_user_data = { form_id: '8888888888', user_id: '3333333333333333333333333333333333333333' }
      @form_users = [FormUser.create(@form_user_data)]
    end
    it 'returns all to FormUser.all' do
      expect(FormUser.all).to eq(@form_users)
    end
    after :all do
      Event.delete_all
      Form.delete_all
      User.delete_all
      FormUser.delete_all
    end
  end
end
