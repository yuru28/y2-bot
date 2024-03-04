# frozen_string_literal: true

require_relative "models/episode"
require_relative "models/show_note"
require_relative "lib/slack/client"

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

      user_ids = %w[
        64609878-9e13-4eed-abde-f34470c6ece9
        e3e92817-37b1-478e-ad41-1980c4cc1db5
        c9c0887b-ace2-4152-acf6-ad46cb27914e
      ]

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

      show_note = ShowNote.create!(name: "EP#{number}", number:, date:, user_ids:, children:)

      show_note.to_h
    end
  end

  class NotifyNewEpisodeShowNoteToSlackHandler
    def self.process(event:, context:)
      slack_client = Slack::Client.new

      notion_page_id = event["Payload"]["notion_page_id"]

      # NotionのページIDはUUIDv4だが、ページURLとして利用する際はハイフンを取り除かなければ404になる
      url = "https://www.notion.so/m6a-jp/#{notion_page_id.delete("-")}"

      content = <<~CONTENT
        <!channel>
        新しいエピソードのShow Noteが作成されました！
        以下のリンクから確認してください。
        #{url}
      CONTENT

      res = slack_client.post(content:)

      {status: res.body}
    end
  end
end
