# frozen_string_literal: true

require_relative "../spec_helper"

require_relative "../../models/episode"
require_relative "../../lib/yuru28_feed_parser"

RSpec.describe Episode do
  let(:feed_parser) { instance_double(Yuru28FeedParser) }
  let(:raw_episodes) do
    [
      {title: "EP5 サンプル回", date: "2024-01-05"},
      {title: "EP4 サンプル回", date: "2024-01-04"},
      {title: "EP3 サンプル回", date: "2024-01-03"},
      {title: "EP2 サンプル回", date: "2024-01-02"},
      {title: "EP1 サンプル回", date: "2024-01-01"}
    ]
  end

  before do
    allow(feed_parser).to receive(:parse).and_return(raw_episodes)
    allow(Yuru28FeedParser).to receive(:new).and_return(feed_parser)
  end

  describe ".all" do
    subject { described_class.all }

    it { is_expected.to be_all { |episode| episode.is_a?(Episode) } }

    it "returns episodes in descending order of date" do
      raw_episodes.each_with_index do |raw_episode, index|
        expect(subject[index].title).to eq raw_episode[:title]
      end
    end
  end
end
