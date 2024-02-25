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

    let(:params) { {name:, number:, date:} }

    subject { described_class.create!(**params) }

    it { is_expected.to be_a(described_class) }

    context "with user_ids" do
      let(:user_ids) {
        %w[
          64609878-9e13-4eed-abde-f34470c6ece9
          e3e92817-37b1-478e-ad41-1980c4cc1db5
          c9c0887b-ace2-4152-acf6-ad46cb27914e
        ]
      }
      let(:params) { {name:, number:, date:, user_ids:} }

      it { is_expected.to be_a(described_class) }
    end
  end
end
