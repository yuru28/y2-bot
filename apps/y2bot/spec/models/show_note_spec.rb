# frozen_string_literal: true

require_relative "../spec_helper"

require_relative "../../models/show_note"

RSpec.describe ShowNote do
  describe ".create!", vcr: true do
    let(:name) { "for testing" }
    let(:number) { 123456 }
    let(:date) { Date.new(2024, 2, 23) }

    subject { described_class.create!(name:, number:, date:) }

    it { is_expected.to be_a(described_class) }
  end
end
