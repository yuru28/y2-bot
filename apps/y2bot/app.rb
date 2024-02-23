# frozen_string_literal: true

require_relative "models/episode"
require_relative "models/show_note"

module App
  class FetchRecentEpisodeHandler
    def self.process(event:, context:)
      recent_episode = Episode.recent

      recent_episode.to_h
    end
  end

  class CreateNewEpisodeShowNoteHandler
    def self.process(event:, context:)
      latest_number = event["Payload"]["number"].to_i

      number = latest_number + 1
      date = Date.today

      show_note = ShowNote.create!(name: "EP#{number}", number:, date:)

      show_note.to_h
    end
  end
end
