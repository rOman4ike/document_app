class Permission < ApplicationRecord
  include AuthClient::Permission

  acts_as_auth_client_permission roles: %i(
    admin
    manager
  )

  validates_uniqueness_of :role,
    scope: [:user_id, :role],
    message: 'У пользователя не может быть несколько одинаковых ролей'

  validates :user_id, presence: true

  delegate :fullname,
    to: :user,
    prefix: true

  def self.available_roles_with_locales
    available_roles.excluding('admin').map do |role|
      {
        value: role,
        text: I18n.t("permissions.#{role}")
      }
    end
  end

  def text_role
    I18n.t "permissions.#{role}"
  end
end

# == Schema Information
#
# Table name: permissions
#
#  id           :bigint           not null, primary key
#  context_type :string
#  role         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  context_id   :bigint
#  user_id      :string           not null
#
# Indexes
#
#  by_user_and_context  (user_id,role,context_type,context_id) UNIQUE
#
