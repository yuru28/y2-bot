# frozen_string_literal: true

require_relative "../spec_helper"

require_relative "../../lib/yuru28_feed_parser"

require "faraday"

RSpec.describe Yuru28FeedParser do
  let(:instance) { described_class.new }

  let(:client) do
    feed_file = File.open("spec/fixtures/yuru28_feed.xml")

    Faraday.new do |conn|
      conn.adapter :test, Faraday::Adapter::Test::Stubs.new do |stub|
        stub.get("/feed") { [200, {}, feed_file.read] }
      end
    end
  end

  before do
    allow(instance).to receive(:client).and_return(client)
  end

  describe ".parse" do
    subject { instance.parse }

    it { is_expected.to be_all { |item| item.is_a?(Hash) } }
    it { is_expected.to be_all { |item| item.key?(:title) && item.key?(:date) } }
  end
end
