class InitialOrder < ApplicationRecord
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

  has_paper_trail

  belongs_to :document
  has_attached_file :file

  before_save :translit_file_file_name

  validates :file,
    attachment_presence: { message: I18n.t('errors.initial_order.file.presence') },
    attachment_size: {
      less_than: 15.megabytes,
      message: I18n.t('errors.initial_order.file.size')
    },
    attachment_content_type: {
      content_type: AVAILABLE_FILE_CONTENT_TYPE,
      message: I18n.t('errors.initial_order.file.content_type')
    },
    attachment_file_name: {
      matches: Proc.new{ |item| item.length < FILE_FILE_NAME_MAX_LENGTH },
      message: I18n.t('errors.document_file.file.length')
    }

  validates :number,
    presence: { message: I18n.t('errors.initial_order.number.presence') }

  validates :initial_date,
    presence: { message: I18n.t('errors.initial_order.initial_date.presence') }

  def get_data_for_history
    {
      'Номер приказа': self.number,
      'Дата введения в действие': self.initial_date.strftime('%d.%m.%Y')
    }
  end

  private
    def translit_file_file_name
      self.file_file_name = Russian.translit(self.file_file_name)
    end
end

# == Schema Information
#
# Table name: initial_orders
#
#  id                :bigint           not null, primary key
#  file_content_type :string
#  file_file_name    :string
#  file_file_size    :bigint
#  file_updated_at   :datetime
#  initial_date      :datetime
#  number            :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  document_id       :bigint
#
# Indexes
#
#  index_initial_orders_on_document_id  (document_id)
#
# Foreign Keys
#
#  fk_rails_...  (document_id => documents.id)
#
