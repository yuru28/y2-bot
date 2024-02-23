# frozen_string_literal: true

module NotionApi
  module Config
    private

    def base_url
      "https://api.notion.com"
    end

    def api_version
      "/v1"
    end

    def notion_version
      "2022-06-28"
    end

    def token
      raise "ENV['NOTION_API_TOKEN'] is not set" unless ENV["NOTION_API_TOKEN"]

      ENV["NOTION_API_TOKEN"].to_s
    end

    def show_notes_database_id
      raise "ENV['NOTION_SHOW_NOTES_DATABASE_ID'] is not set" unless ENV["NOTION_SHOW_NOTES_DATABASE_ID"]

      ENV["NOTION_SHOW_NOTES_DATABASE_ID"].to_s
    end
  end
end
