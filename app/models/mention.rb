# frozen_string_literal: true

class Mention < ApplicationRecord
  belongs_to :mentioning, class_name: 'Report'
  belongs_to :mentioned, class_name: 'Report'

  module ManagementMentions
    URL_REGEXP = %r{http://localhost:3000/reports/(\d+)}
    def search_mentioned_ids
      self[:content].scan(URL_REGEXP).flatten.map(&:to_i)
    end

    def create_mentioning(mentioned_ids)
      mentioned_ids.each do |id|
        active_mentions.create(mentioned_id: id) if Report.find_by(id:)
      end
    end
  end
end
