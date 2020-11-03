require 'rails_helper'

RSpec.describe Form, type: :model do
  before(:each) do
    @event = Event.new(
      name: 'cool social',
      start_time: @now,
      end_time: @now,
      event_type: 'Socials'
    )
  end

  describe 'when a Form is saved' do
    it 'succeeds if all required fields are present' do
      @event.save
      expect(Form.new(id: '1',
                      form_type: 'Socials',
                      time_restricted: false,
                      event: @event)).to be_valid
    end

    it 'fails if no form_type is provided' do
      @event.save
      expect(Form.new(id: '1', time_restricted: false, event: @event)).to_not be_valid
    end

    it 'fails if no event is provided' do
      expect(Form.new(id: '1', form_type: 'Socials', time_restricted: false)).to_not be_valid
    end
  end
end
