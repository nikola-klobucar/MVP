REDIS_URL = Rails.application.credentials.config[:REDIS_URL]

Sidekiq.configure_server do |config|
  config.redis = { url: REDIS_URL, driver: :hiredis }

  config.client_middleware do |chain|
    chain.add SidekiqUniqueJobs::Middleware::Client
  end

  config.server_middleware do |chain|
    chain.add SidekiqUniqueJobs::Middleware::Server
  end

  SidekiqUniqueJobs::Server.configure(config)
end

Sidekiq.configure_client do |config|
  config.redis = { url: REDIS_URL, driver: :hiredis }

  config.client_middleware do |chain|
    chain.add SidekiqUniqueJobs::Middleware::Client
  end
end