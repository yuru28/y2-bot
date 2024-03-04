# frozen_string_literal: true

require "faraday"
require "faraday/follow_redirects"
require "faraday/retry"

module Slack
  class Client
    attr_reader :webhook_url

    def initialize(webhook_url: nil)
      @webhook_url = webhook_url || ENV["SLACK_WEBHOOK_URL"].to_s
    end

    def post(content:)
      client.post(
        webhook_url,
        {
          text: content
        }.to_json,
        "Content-Type" => "application/json"
      )
    end

    private

    def client
      @client ||= Faraday.new do |f|
        f.adapter :net_http

        f.request :url_encoded
        f.request :retry, {max: 5, retry_statuses: [429]}

        f.response :raise_error

        f.headers = {
          "Content-Type" => "application/json"
        }
      end
    end
  end
end
