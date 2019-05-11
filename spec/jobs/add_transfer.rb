require 'rails_helper'

RSpec.describe AddTransferJob, type: :job do
  describe "#perform_later" do
    let(:user) { create(:user) }
    let(:user2) { create(:user) }
    let!(:account) { create(:account, user: user) }
    let!(:account2) { create(:account, user: user2) }

    before { ActiveJob::Base.queue_adapter = :test }

    it "have enqueued" do
      expect {
        AddTransferJob.perform_later(account.number, account2.number. account.amount / 10 )
      }.to have_enqueued_job
    end

    it 'is in trendings queue' do
      expect(AddHashtagsJob.new.queue_name).to eq('transfers')
    end
  end
end