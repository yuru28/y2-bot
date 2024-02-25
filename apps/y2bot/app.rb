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

      children = [
        {
          object: "block",
          heading_2: {
            rich_text: [{text: {content: "出囃子トーク"}}]
          }
        },
        {
          object: "block",
          type: "bulleted_list_item",
          bulleted_list_item: {
            rich_text: [{type: "text", text: {content: "mk"}}]
          }
        },
        {
          object: "block",
          type: "bulleted_list_item",
          bulleted_list_item: {
            rich_text: [{type: "text", text: {content: "ふっくん"}}]
          }
        },
        {
          object: "block",
          type: "bulleted_list_item",
          bulleted_list_item: {
            rich_text: [{type: "text", text: {content: "とっしー"}}]
          }
        },
        {
          object: "block",
          heading_2: {
            rich_text: [{text: {content: "メインコンテンツ"}}]
          }
        },
        {
          object: "block",
          type: "bulleted_list_item",
          bulleted_list_item: {
            rich_text: [{type: "text", text: {content: ""}}]
          }
        }
      ]

      show_note = ShowNote.create!(name: "EP#{number}", number:, date:, children:)

      show_note.to_h
    end
  end
end
