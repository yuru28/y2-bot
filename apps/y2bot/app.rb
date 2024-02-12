# frozen_string_literal: true

require_relative "models/episode"

module App
  class SampleHandler
    def self.process(event:, context:)
      {message: "Hello from y2-bot sample app!"}
    end
  end

  class FetchRecentEpisodeHandler
    def self.process(event:, context:)
      recent_episode = Episode.recent

      recent_episode.to_h
    end
  end
end
