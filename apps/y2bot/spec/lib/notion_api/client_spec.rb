# frozen_string_literal: true

require_relative "../../spec_helper"

require_relative "../../../lib/notion_api/client"

RSpec.describe NotionApi::Client, vcr: true do
  let(:instance) { described_class.new }

  describe "#create_page_to_database" do
    subject {}

    let(:response) { instance.create_page_to_database(database_id: ENV["NOTION_SHOW_NOTES_DATABASE_ID"], name: "for testing") }
    let(:json) { JSON.parse(response.body, symbolize_names: true) }

    it "creates a new page" do
      expect(response.success?).to eq true

      expect(json[:object]).to eq "page"
      expect(json[:parent]).to eq({type: "database_id", database_id: ENV["NOTION_SHOW_NOTES_DATABASE_ID"]})
      expect(json[:properties][:Name][:title][0][:text][:content]).to eq "for testing"
    end
  end
end
