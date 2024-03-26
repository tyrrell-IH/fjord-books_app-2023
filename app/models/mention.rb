# frozen_string_literal: true

class Mention < ApplicationRecord
  belongs_to :mentioning, class_name: 'Report'
  belongs_to :mentioned, class_name: 'Report'

  validates :mentioned_id, uniqueness: { scope: :mentioning_id }

  module ManagementMentions
    URL_REGEXP = %r{http://localhost:3000/reports/(\d+)}
    def search_mentioned_ids
      self[:content].scan(URL_REGEXP).flatten.uniq.map(&:to_i)
    end

    def create_mentioning(mentioned_ids)
      existing_ids = Report.where(id: mentioned_ids).ids
      existing_ids.each do |id|
        active_mentions.create!(mentioned_id: id)
      end
    end

    def destroy_mentioning(mentioned_ids)
      mentioned_ids.each do |id|
        active_mentions.find_by(mentioned_id: id).destroy!
      end
    end

    def save_with_mentions
      mentioned_ids = search_mentioned_ids
      ActiveRecord::Base.transaction do
        save
        create_mentioning(mentioned_ids)
      end
    rescue ActiveRecord::RecordInvalid
      false
    end

    def update_mentioning
      mentioned_ids_in_content = search_mentioned_ids
      mentioned_ids_already_saved = mentioning_reports.ids
      create_mentioning(mentioned_ids_in_content - mentioned_ids_already_saved)
      destroy_mentioning(mentioned_ids_already_saved - mentioned_ids_in_content)
    end

    def update_with_mentions
      ActiveRecord::Base.transaction do
        save
        update_mentioning
      end
    rescue ActiveRecord::RecordInvalid
      false
    end
  end
end
