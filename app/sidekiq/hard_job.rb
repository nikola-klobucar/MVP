class HardJob
  include Sidekiq::Job

  def perform(*current_user)
    UserMailer.purchased(current_user).deliver_later
  end
end
