# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem "sorbet-runtime"

group :development do
  gem "rubocop", require: false
  gem "rubocop-sorbet", require: false
  gem "ruby-lsp", "~> 0.1.0", require: false
  gem "sorbet"
  gem "sorbet-runtime"
  gem "tapioca", require: false
  gem "unparser", require: false
end
