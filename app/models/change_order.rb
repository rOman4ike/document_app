class ChangeOrder < ApplicationRecord
  AVAILABLE_STATE_VALUES = %w(active archived deleted)
  FILE_FILE_NAME_MAX_LENGTH = 255
  AVAILABLE_FILE_CONTENT_TYPE = ['application/pdf',
    'application/x-pdf',
    'application/msword',
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    'application/zip',
    'application/vnd.rar',
    'application/vnd.ms-excel',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
  ]

  belongs_to :document
  has_attached_file :file

  before_save :translit_file_file_name
  after_create :archive_change_orders

  validates :file,
    attachment_presence: { message: I18n.t('errors.change_order.file.presence') },
    attachment_size: {
      less_than: 15.megabytes,
      message: I18n.t('errors.change_order.file.size')
    },
    attachment_content_type: {
      content_type: AVAILABLE_FILE_CONTENT_TYPE,
      message: I18n.t('errors.change_order.file.content_type')
    },
    attachment_file_name: {
      matches: Proc.new{ |item| item.length < FILE_FILE_NAME_MAX_LENGTH },
      message: I18n.t('errors.document_file.file.length')
    }

  validates :number,
    presence: { message: I18n.t('errors.change_order.number.presence') }

  validates :change_date,
    presence: { message: I18n.t('errors.change_order.change_date.presence') }

  def replaced_file_file_name
    ChangeOrder.where(document_id: self.document_id)
  end

  def soft_destroy
    self.update_attribute(:state, 'deleted')
  end

  private
    def archive_change_orders
      ChangeOrder.where(document_id: self.document_id, state: 'active')
        .excluding(self)
        .update_all(deleted_at: DateTime.now, state: 'archived')
    end

    def translit_file_file_name
      self.file_file_name = Russian.translit(self.file_file_name)
    end
end

# == Schema Information
#
# Table name: change_orders
#
#  id                :bigint           not null, primary key
#  change_date       :datetime
#  deleted_at        :datetime
#  file_content_type :string
#  file_file_name    :string
#  file_file_size    :bigint
#  file_updated_at   :datetime
#  number            :string
#  state             :string           default("active")
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  document_id       :bigint
#
# Indexes
#
#  index_change_orders_on_document_id  (document_id)
#
# Foreign Keys
#
#  fk_rails_...  (document_id => documents.id)
#
