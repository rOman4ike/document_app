class DocumentActivityArea < ApplicationRecord
  has_paper_trail

  belongs_to :document
  belongs_to :activity_area

  validates_uniqueness_of :activity_area_id,
    scope: :document_id,
    message: I18n.t('errors.document_activity_area.activity_area_id.uniqueness')

  delegate :title, to: :activity_area

  def self.get_changeset(transaction_id)
    PaperTrail::Version
      .where(item_type: 'DocumentActivityArea', transaction_id: transaction_id)
      .map{ |version| ActivityArea.find_by(id: version.changeset['activity_area_id'][1])&.title }
  end
end

# == Schema Information
#
# Table name: document_activity_areas
#
#  id               :bigint           not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  activity_area_id :bigint
#  document_id      :bigint
#
# Indexes
#
#  index_document_activity_areas_on_activity_area_id  (activity_area_id)
#  index_document_activity_areas_on_document_id       (document_id)
#
# Foreign Keys
#
#  fk_rails_...  (activity_area_id => activity_areas.id)
#  fk_rails_...  (document_id => documents.id)
#
