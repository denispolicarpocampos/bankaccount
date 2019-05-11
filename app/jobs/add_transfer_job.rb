class AddTransferJob < ApplicationJob # >
  queue_as :transfers

  def perform(source_id, destination_id, amount)
    ActiveRecord::Base.transaction do
      begin
        @transfer = Historic.new(source_id: source_id, destination_id: destination_id, amount: amount)
        if @transfer.save
          source = Account.find_by(number: source_id)
          destination = Account.find_by(number: destination_id)
          source.update(amount: source.amount - amount)
          destination.update(amount: destination.amount + amount)
        else
          raise "Failed to transfer the money: #{@transfer.errors.full_messages}"
        end
      rescue StandardError => e
        raise ActiveRecord::Rollback
      end
    end

  end
end
