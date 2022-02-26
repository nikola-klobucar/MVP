class SimpleJob
  include Sidekiq::Worker
  sidekiq_options lock: :until_and_while_executing


  def perform
    # block that will be retried in case of failure
    Cart.create(user: User.last)
  end
end
