# frozen_string_literal: true

require "faraday"
require "faraday/retry"
require "nokogiri"

require_relative "base_model"
require_relative "../lib/yuru28_feed_parser"

class Episode < BaseModel
  # @dynamic number, title, date
  attr_accessor :number, :title, :date

  def initialize(number:, title:, date:)
    @number = number
    @title = title
    @date = date
  end

  def self.all
    parser = Yuru28FeedParser.new
    raw_episodes = parser.parse

    raw_episodes.map do |raw_episode|
      number = raw_episode[:title].split[0].match(/\d+/).to_s.to_i
      date = Date.parse(raw_episode[:date])

      new(
        number:,
        title: raw_episode[:title],
        date:
      )
    end.sort_by(&:date).reverse
  end

  def self.recent
    all.first
  end
end
