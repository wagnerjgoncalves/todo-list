Capybara.configure do |config|
  config.default_max_wait_time = 5
  config.default_driver = :webkit
end

Capybara.register_driver :webkit do |app|
  Capybara::Webkit::Driver.new(app, {
    timeout: 60,
    js_errors: false,
    block_unknown_urls: true
  })
end
