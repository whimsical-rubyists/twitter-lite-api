# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :string(36)       not null, primary key
#  username        :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  before_create :set_uuid
  before_save :downcase_email

  has_secure_password

  PASSWORD_REQUIREMENT = /(?=.*[a-zA-Z])(?=.*[0-9]).{6,10}/

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: { case_sensitive: false },
            format: { with: URI::MailTo::EMAIL_REGEXP, message: :bad_email }
  validates :password, presence: true, format: { with: PASSWORD_REQUIREMENT, message: :bad_password }

  def set_uuid
    self.id = SecureRandom.uuid
  end

  def downcase_email
    self.email = email.to_s.strip.downcase
  end
end
