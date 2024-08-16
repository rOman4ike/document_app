class User < ApplicationRecord
  MAX_EMAIL_LENGTH = 255
  MAX_PASSWORD_LENGTH = 255
  VALID_EMAIL_REGEX = /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i

  ROLES = %i(
    user
    moderator
    admin
  )

  devise :database_authenticatable,
    :registerable,
    :jwt_authenticatable,
    jwt_revocation_strategy: JwtDenylist

  validates :email,
    presence: {
      message: I18n.t('errors.user.email.presence')
    },
    uniqueness: {
      message: I18n.t('errors.user.email.uniqueness'),
      case_sensitive: false
    },
    format: {
      with: VALID_EMAIL_REGEX,
      multiline: true,
      message: I18n.t('errors.user.email.format')
    }

  validates :password, presence: { message: I18n.t('errors.user.password.presence') }

  ROLES.each do |role|
    define_method("#{role}?") do
      permissions.map(&:role).include? role
    end
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
