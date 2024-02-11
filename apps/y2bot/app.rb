# frozen_string_literal: true

module App
  class SampleHandler
    def self.process(event:, context:)
      {message: "Hello from y2-bot sample app!"}
    end
  end
end
