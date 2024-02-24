# frozen_string_literal: true

require_relative "../spec_helper"

require_relative "../../models/show_note"

RSpec.describe ShowNote do
  describe ".find", vcr: true do
    let(:notion_page_id) { "d722161b-7fe6-4ddb-99b0-8c452697fe01" }

    subject { described_class.find(notion_page_id) }

    it { is_expected.to be_a(described_class) }
  end

  describe ".create!", vcr: true do
    let(:name) { "for testing" }
    let(:number) { 123456 }
    let(:date) { Date.new(2024, 2, 23) }

    subject { described_class.create!(name:, number:, date:) }

    it { is_expected.to be_a(described_class) }
  end
end
