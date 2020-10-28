require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'new_user_email' do
    context 'when it creates a new user email' do
      before :each do
        user_data = { id: '95e229d8aca716874c8feca1501379e06f239d03', first_name: 'New', last_name: 'User',
                      major: 'computer science', graduation_year: 2021, email: 'email@address.com',
                      phone_number: '3333333333' }
        @user = User.create(user_data)
      end
      let(:mail) { described_class.with(user: @user).new_user_email.deliver_now }
      it 'renders the subject' do
        expect(mail.subject).to eq('Welcome to the SASE Participation Tracker!')
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
      it "contains the user's major" do
        expect(mail.body.encoded).to match(@user.major)
      end
      it "contains the user's graduation year" do
        expect(mail.body.encoded).to match(@user.graduation_year.to_s)
      end
      it "contains the user's phone number" do
        expect(mail.body.encoded).to match(@user.phone_number)
      end
      after :all do
        User.destroy_all
      end
    end
  end
end
