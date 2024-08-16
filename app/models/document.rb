class Document < ApplicationRecord
  AVAILABLE_STATE_VALUES = %w(valid invalid)
  AVAILABLE_KIND_VALUES = %w(local federal regulatory other)

  include PgSearch::Model
  attr_accessor :is_initial_order_required, :is_change_order_required

  has_paper_trail

  pg_search_scope :search_by_title, against: :title
  pg_search_scope :search_by_doc_tag_id,
    associated_against: {
      document_doc_tags: [:doc_tag_id]
    },
    using: {
      tsearch: {
        any_word: true
      }
    }

  scope :filter_by_activity_areas, -> (activity_areas) {
    joins(:activity_areas).where(activity_areas: { id: activity_areas })
  }
  scope :filter_by_kinds, -> (kinds) {
    where(kind: kinds)
  }
  scope :filter_by_states, -> (states) {
    where(state: states)
  }
  scope :filter_by_initial_date, -> (year) {
    joins(:initial_orders)
      .where('extract(year from initial_date) = ?', year)
  }

  has_many :document_activity_areas,
    dependent: :destroy,
    autosave: true
  has_many :document_doc_tags,
    dependent: :destroy,
    autosave: true
  has_many :initial_orders,
    dependent: :destroy,
    autosave: true
  has_many :change_orders,
    dependent: :destroy,
    autosave: true
  has_many :doc_tags, through: :document_doc_tags
  has_many :activity_areas, through: :document_activity_areas
  has_many :document_files, dependent: :destroy

  accepts_nested_attributes_for :document_activity_areas, allow_destroy: true
  accepts_nested_attributes_for :document_doc_tags, allow_destroy: true
  accepts_nested_attributes_for :initial_orders
  accepts_nested_attributes_for :change_orders
  accepts_nested_attributes_for :document_files

  before_update :check_association_changes

  validates :title,
    presence: { message: I18n.t('errors.document.title.presence') }

  validates :state,
    presence: { message: I18n.t('errors.document.state.presence') },
    inclusion: {
      in: AVAILABLE_STATE_VALUES,
      message: I18n.t('errors.document.state.inclusion')
    }

  validates :kind,
    presence: { message: I18n.t('errors.document.kind.presence') },
    inclusion: {
      in: AVAILABLE_KIND_VALUES,
      message: I18n.t('errors.document.kind.inclusion')
    }

  validates :document_doc_tags,
    presence: { message: I18n.t('errors.document.document_doc_tags.presence') }

  validates :document_activity_areas,
    presence: { message: I18n.t('errors.document.document_activity_areas.presence') }

  validates :document_files,
    presence: { message: I18n.t('errors.document.document_files.presence') }

  validates :initial_orders,
    presence: true,
    if: :is_initial_order_required?

  validates :change_orders,
    presence: true,
    if: :is_change_order_required?

  def self.available_states_with_locales
    AVAILABLE_STATE_VALUES.map do |state|
      {
        value: state,
        text: I18n.t("document.state.#{state}"),
        default: state == 'valid'
      }
    end
  end

  def self.available_kinds_with_locales
    AVAILABLE_KIND_VALUES.map do |kind|
      {
        value: kind,
        text: I18n.t("document.kind.#{kind}"),
        default: false
      }
    end
  end

  def activity_areas_for_select
    self.document_activity_areas.map do |document_activity_area|
      {
        id: document_activity_area.id,
        value: document_activity_area.activity_area.id,
        text: document_activity_area.activity_area.title
      }
    end
  end

  def doc_tags_for_select
    self.document_doc_tags.map do |document_doc_tag|
      {
        id: document_doc_tag.id,
        value: document_doc_tag.doc_tag.id,
        text: document_doc_tag.doc_tag.title
      }
    end
  end

  def current_document_file
    self.document_files.find_by(deleted_at: nil)
  end

  def initial_order
    self.initial_orders.last
  end

  def change_order
    self.change_orders.last
  end

  def document_changes
    versions = self.versions.sort.reverse
    first_initial_order_index = versions.map { |version| version.reify(has_many: true) }.index { |version| version&.initial_order&.present? }
    versions.map.with_index do |version, index|
      user = User.find_by(id: version.whodunnit).email rescue 'Анонимный пользователь'
      changeset = version.changeset
        .except(:id, :user_id, :updated_at, :created_at)
        .map { |k, v| [ k, change_changeset_value(k, v) ] }.to_h
        .transform_keys { |key| I18n.t("document.version.attribute.#{key}") }
      next_document = version.reify(has_many: true)
      previous_document = versions[index - 1].reify(has_many: true) rescue nil
      get_self_for_initial_order = (!first_initial_order_index && index == 0) || (first_initial_order_index && index == first_initial_order_index)
      changeset = add_association_to_changeset(changeset, next_document, previous_document, get_self_for_initial_order)
      {
        action: I18n.t("document.version.actions.#{version.event}"),
        user: user,
        created_at: version.created_at,
        changeset: changeset
      }
    end
  end

  private
    def check_association_changes
      if (document_doc_tags.any?(&:changed?) || document_activity_areas.any?(&:changed?) || initial_order&.changed?) && !self.changed?
        self.touch
      end
    end

    def add_association_to_changeset(changeset, next_document, previous_document, get_self_for_initial_order)
      next_document_doc_tags = next_document&.document_doc_tags&.map(&:title)
      previous_document_doc_tags = previous_document.document_doc_tags.map(&:title) rescue self.document_doc_tags.map(&:title)
      if next_document_doc_tags != previous_document_doc_tags
        changeset = changeset.merge!(
          {
            I18n.t("document.version.attribute.document_doc_tags") => [
              next_document_doc_tags, previous_document_doc_tags
            ]
          }
        )
      end
      next_document_activity_areas = next_document&.document_activity_areas&.map(&:title)
      previous_document_activity_areas = previous_document.document_activity_areas.map(&:title) rescue self.document_activity_areas.map(&:title)
      if next_document_activity_areas != previous_document_activity_areas
        changeset = changeset.merge!(
          {
            I18n.t("document.version.attribute.document_activity_areas") => [
              next_document_activity_areas, previous_document_activity_areas
            ]
          }
        )
      end
      next_initial_order = next_document&.initial_order&.get_data_for_history
      previous_initial_order = previous_document&.initial_order&.get_data_for_history
      previous_initial_order = self&.initial_order&.get_data_for_history if get_self_for_initial_order
      if next_initial_order != previous_initial_order
        changeset = changeset.merge!(
          {
            I18n.t("document.version.attribute.initial_order") => [
              next_initial_order, previous_initial_order
            ],
          }
        )
      end
      changeset
    end

    def change_changeset_value(key, values)
      case key
      when 'state', 'kind'
        values.map{ |value| I18n.t("document.#{key}.#{value}") || nil }
      else
        values
      end
    end

    def is_initial_order_required?
      ActiveModel::Type::Boolean.new.cast(is_initial_order_required)
    end

    def is_change_order_required?
      ActiveModel::Type::Boolean.new.cast(is_change_order_required)
    end
end

# == Schema Information
#
# Table name: documents
#
#  id         :bigint           not null, primary key
#  is_public  :boolean          default(TRUE)
#  kind       :string
#  state      :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :string           not null
#
