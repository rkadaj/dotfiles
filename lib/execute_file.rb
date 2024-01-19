# typed: strict
# frozen_string_literal: true

class ExecuteFile < Base
    extend T::Sig
  
    sig { params(url: String, executable: String).void }
    def initialize(url:, executable:)
      super()
  
      @url = url
      @executable = executable
    end
  
    sig { override.void }
    def run
      debug("Fetching url #{@url} to execute")
      if executable_exists?(@executable)
        debug("Executable #{@executable} exists, skipping")
        return
      end
  
      `curl -fsSL #{@url} | sh -s -- -f`
    end
  end
  