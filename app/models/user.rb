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
#  remember_digest :string(255)
#  email_confirmed :boolean          default("0")
#  confirm_digest  :string(255)
#  confirmed_at    :datetime         default("2020-05-15 16:26:42")
#

class User < ApplicationRecord
  attr_accessor :remember_token, :confirm
  before_create :set_uuid#, :confirmation_token
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

  # Returns the hash digest of the given string.
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def token_valid?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?

    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def email_activate!
    self.email_confirmed = true
    self.confirmed_at = Time.now
    # save!(:validate => false)
  end

  def confirmation_token
    self.confirm = User.new_token
    update_attribute(:confirm_digest, User.digest(confirm))
  end
end
