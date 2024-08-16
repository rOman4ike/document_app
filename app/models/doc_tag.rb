class DocTag < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_by_title, against: :title

  has_many :document_doc_tags,
    dependent: :restrict_with_error

  validates :title,
    presence: { message: I18n.t('errors.doc_tag.title.presence') },
    uniqueness: { message: I18n.t('errors.doc_tag.title.uniqueness') }

  def self.available_doc_tags
    DocTag.all.map do |doc_tag|
      {
        value: doc_tag.id,
        text: doc_tag.title,
        default: false
      }
    end
  end

  def convert_to_json
    {
      value: self.id,
      text: self.title
    }
  end
end

# == Schema Information
#
# Table name: doc_tags
#
#  id         :bigint           not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
