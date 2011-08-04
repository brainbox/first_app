source :gemcutter
gem "rails", "2.3.8"
gem "sqlite3-ruby", :require => "sqlite3"
gem "rdoc"
gem "rake", "0.9.2"

gem 'sqlite3'
group :development, :test do
 gem 'cucumber', '0.10.7'
 gem 'cucumber-rails', '0.5.2'
 gem 'rspec', '1.3.0'
 gem 'rspec-rails', '1.3.2'
 gem 'capybara', '1.0.0'
 gem 'database_cleaner', '0.6.7'
 gem 'annotate', '2.4.0'

end

# bundler requires these gems in all environments
# gem "nokogiri", "1.4.2"
# gem "geokit"

group :development do
  # bundler requires these gems in development
  # gem "rails-footnotes"
end

group :test do
  # bundler requires these gems while running tests
  # gem "rspec"
  # gem "faker"
end

gem 'simplecov', '>=0.3.8', :require=>false, :group=>:test