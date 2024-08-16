class ActivityArea < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_by_title, against: :title

  has_many :document_activity_areas,
    dependent: :restrict_with_error

  validates :title,
    presence: { message: I18n.t('errors.activity_area.title.presence') },
    uniqueness: { message: I18n.t('errors.activity_area.title.uniqueness') }

  def self.available_activity_areas
    ActivityArea.all.map do |activity_area|
      {
        value: activity_area.id,
        text: activity_area.title,
        default: false
      }
    end
  end
end

# == Schema Information
#
# Table name: activity_areas
#
#  id         :bigint           not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
