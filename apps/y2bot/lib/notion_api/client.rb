# frozen_string_literal: true

require "json"
require "faraday"
require "faraday/follow_redirects"
require "faraday/retry"

require_relative "config"
require_relative "endpoints"

module NotionApi
  class Client
    include Config
    include Endpoints

    def get_page(page_id:)
      # @type var method: Symbol
      # @type var path: String
      method, path = get_page_endpoint(page_id:).values_at(:method, :path)

      client.send(method, path)
    end

    def create_page_to_database(database_id:, name:, emoji_icon: nil, additional_properties: {})
      # @type var method: Symbol
      # @type var path: String
      method, path = post_page_endpoint.values_at(:method, :path)

      client.send(method, path, {
        parent: {database_id:},
        icon: emoji_icon ? {emoji: emoji_icon} : nil,
        properties: {
          Name: {
            title: [
              {
                text: {
                  content: name
                }
              }
            ]
          }
        }.merge(additional_properties)
      }.compact.to_json)
    end

    private

    def client
      @client ||= Faraday.new(url: base_url) do |f|
        f.adapter :net_http

        f.request :url_encoded
        f.request :authorization, "Bearer", token
        f.request :retry, {max: 5, retry_statuses: [429]}

        f.response :follow_redirects
        f.response :raise_error

        f.headers = {
          "Content-Type" => "application/json",
          "Notion-Version" => notion_version
        }
      end
    end
  end
end
