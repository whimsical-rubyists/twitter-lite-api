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
#  confirm_token   :string(255)
#

# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { Faker::Name.unique.name }
    email { Faker::Internet.email }
    password { "Password12" }
  end
end
