class DocumentDocTag < ApplicationRecord
  has_paper_trail

  belongs_to :document
  belongs_to :doc_tag

  validates_uniqueness_of :doc_tag_id,
    scope: :document_id,
    message: I18n.t('errors.document_doc_tag.doc_tag_id.uniqueness')

  delegate :title, to: :doc_tag

  def self.get_changeset(transaction_id)
    PaperTrail::Version
      .where(item_type: 'DocumentDocTag', transaction_id: transaction_id)
      .map{ |version| DocTag.find_by(id: version.changeset['doc_tag_id'][1])&.title }
  end
end

# == Schema Information
#
# Table name: document_doc_tags
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  doc_tag_id  :bigint
#  document_id :bigint
#
# Indexes
#
#  index_document_doc_tags_on_doc_tag_id   (doc_tag_id)
#  index_document_doc_tags_on_document_id  (document_id)
#
# Foreign Keys
#
#  fk_rails_...  (doc_tag_id => doc_tags.id)
#  fk_rails_...  (document_id => documents.id)
#
