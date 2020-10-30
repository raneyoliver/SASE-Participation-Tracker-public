require 'rails_helper'

RSpec.describe FormUserMailer, type: :mailer do
  describe 'confirmation_email' do
    context 'when it creates a form confirmation email' do
      before :each do
        user_data = { id: '95e229d8aca716874c8feca1501379e06f239d03', first_name: 'New', last_name: 'User',
                      major: 'computer science', graduation_year: 2021, email: 'email@address.com',
                      phone_number: '3333333333' }
        @user = User.create(user_data)
        event_data = { id: 1, name: 'Test Event', description: 'description', event_type: 'GBM',
                       start_time: '2020-09-15T01:00:00.000Z', end_time: '2020-09-15T00:00:00.000Z' }
        @event = Event.create(event_data)
        form_data = { id: '8888888888', event_id: 1, form_type: 'sign-in' }
        @form = Form.create(form_data)
        form_user_data = { id: 1, form_id: '8888888888', user_id: '95e229d8aca716874c8feca1501379e06f239d03' }
        @form_user = FormUser.create(form_user_data)
      end
      let(:mail) { described_class.with(form_user: @form_user).confirmation_email.deliver_now }
      it 'renders the subject' do
        expect(mail.subject).to eq("Form submission confirmation for event: #{@event.name}")
      end
      it 'renders the sender email' do
        expect(mail.to).to eq([@user.email])
      end
      it 'renders the receiver email' do
        expect(mail.from).to eq(['saseparticipationtracker@gmail.com'])
      end
      it "contains the user's name" do
        expect(mail.body.encoded).to match("#{@user.first_name} #{@user.last_name}")
      end
      it 'contains the form type' do
        expect(mail.body.encoded).to match(@form.form_type)
      end
      it 'contains the event description' do
        expect(mail.body.encoded).to match(@event.description)
      end
      it 'contains the event type' do
        expect(mail.body.encoded).to match(@event.event_type)
      end
      it 'contains the event start time' do
        formatted_start_time = @event.start_time.in_time_zone('Central Time (US & Canada)')
                                     .strftime('%B %d, %Y, %I:%M %p')
        expect(mail.body.encoded).to match(formatted_start_time)
      end
      it 'contains the event end time' do
        formatted_end_time = @event.end_time.in_time_zone('Central Time (US & Canada)')
                                   .strftime('%B %d, %Y, %I:%M %p')
        expect(mail.body.encoded).to match(formatted_end_time)
      end
      after :all do
        User.destroy_all
        Event.destroy_all
        Form.destroy_all
      end
    end
  end
end
