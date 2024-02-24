# frozen_string_literal: true

module NotionApi
  module Endpoints
    private

    # https://developers.notion.com/reference/retrieve-a-page
    def get_page_endpoint(page_id:)
      {
        method: :get,
        path: "/v1/pages/#{page_id}"
      }
    end

    # https://developers.notion.com/reference/post-page
    def post_page_endpoint
      {
        method: :post,
        path: "/v1/pages"
      }
    end
  end
end
