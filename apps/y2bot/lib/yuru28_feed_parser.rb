# frozen_string_literal: true

require "faraday"
require "faraday/retry"
require "faraday/follow_redirects"
require "nokogiri"

class Yuru28FeedParser
  def self.parse
    new.parse
  end

  def parse
    response = client.get(feed_path)
    feed = Nokogiri::XML(response.body)

    feed.search("item").map do |item|
      title = item.at("title").text

      utc_datetime = DateTime.parse(item.at("pubDate").text)
      date = utc_datetime.new_offset("+09:00").to_date.to_s

      {
        title:,
        date:
      }
    end
  end

  private

  def client
    @client ||= Faraday.new(url: base_url) do |f|
      f.request :url_encoded
      f.response :follow_redirects
      f.adapter :net_http
      f.request :retry, {max: 5, retry_statuses: [429]}
    end
  end

  def base_url
    ENV["FEED_BASE_URL"] || "https://yuru28.com"
  end

  def feed_path
    "/feed"
  end
end
