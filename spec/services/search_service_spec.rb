require 'rails_helper'

RSpec.describe SearchService, type: :service do

  describe '.parse' do
    let(:user) { create :user }
    let(:base64_text) {'data:text/csv;base64,Y29mZmVlIGhvdXNlIGluIG5ldyB5b3Jr' }

    it 'should add a new sidekiq queue' do
      VCR.use_cassette('services') do
        expect {
          SearchService.parse(base64_text, user.id)
        }.to change(Sidekiq::Queues['default'], :size).by(1)
      end
    end
  end
end
