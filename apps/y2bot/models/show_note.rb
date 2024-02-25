# frozen_string_literal: true

require_relative "base_model"

require_relative "../lib/notion_api/client"

class ShowNote < BaseModel
  # @dynamic notion_page_id
  attr_reader :notion_page_id
  # @dynamic name, number, date
  attr_accessor :name, :number, :date

  def initialize(name:, notion_page_id: nil, number: nil, date: nil)
    @name = name
    @notion_page_id = notion_page_id
    @number = number
    @date = date
  end

  def self.find(notion_page_id)
    client = NotionApi::Client.new

    response = client.get_page(page_id: notion_page_id)

    json = JSON.parse(response.body, symbolize_names: true)

    new(
      name: json.dig(:properties, :Name, :title, 0, :plain_text),
      number: json.dig(:properties, :Number, :number),
      date: json.dig(:properties, :収録日時, :date, :start),
      notion_page_id: json[:id]
    )
  end

  def self.create!(name:, number: nil, date: nil, user_ids: [], children: nil)
    client = NotionApi::Client.new

    people = user_ids.map { |id| {object: "user", id:} }

    additional_properties = {
      Number: {number:},
      "収録日時": {date: {start: date}},
      "ホスト": (people.length >= 1) ? {people:} : nil
    }.compact

    response = client.create_page_to_database(
      database_id: ENV["NOTION_SHOW_NOTES_DATABASE_ID"].to_s,
      name:,
      emoji_icon: "📝",
      additional_properties:,
      children:
    )

    json = JSON.parse(response.body, symbolize_names: true)

    new(
      name: json[:properties][:Name][:title][0][:plain_text],
      number: json[:properties][:Number][:number],
      date: json[:properties][:収録日時][:date][:start],
      notion_page_id: json[:id]
    )
  end
end
