# typed: strict
# frozen_string_literal: true

class FetchFile < Base
  extend T::Sig

  sig { params(url: String, target: String).void }
  def initialize(url:, target:)
    super()

    @url = T.let(url, String)
    @target = T.let(target.gsub("~", Dir.home), String)
  end

  sig { override.void }
  def run
    debug("Fetching url #{@url} to #{@target}")
    if File.exist?(@target)
      debug("Target file already exists, skipping")
      return
    end

    `curl -L #{@url} --output #{@target}`
  end
end
