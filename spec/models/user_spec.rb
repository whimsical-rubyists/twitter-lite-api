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
#

# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  describe "validation" do
    let(:invalid_email) { "smaskaksas" }
    let(:valid_email) { "valid@mail.com" }
    let(:invalid_password) { "assadadhgsjkhd" }
    let(:valid_password) { "Passwor9" }
    let(:remember_token) { nil }

    let(:password_error) { "Password is invalid. A strong password should containt 6-10
    characters, have a small case letter, an upper case letter and a
    digit."}

    context "validate presence" do
      it { should validate_presence_of(:username) }
      it { should validate_presence_of(:email) }
      it { should validate_presence_of(:password) }
    end

    context "validates uniqueness" do
      it { should validate_uniqueness_of(:username).case_insensitive }
      it { should validate_uniqueness_of(:email).case_insensitive }
    end

    context "validates format" do
      # it { should validate_length_of(:password).is_at_least(6)}

      it { should_not allow_value(invalid_email).for(:email) }
      it { should_not allow_value(invalid_password).for(:password) }

      it { should allow_value(valid_email).for(:email) }
      it { should allow_value(valid_password).for(:password) }
    end

    context "presence of secure password" do
      it { should have_secure_password }
      it { expect(:remember_token.nil?).to be false }
    end
  end

  describe "Can remember users" do
    it "authenticates users by rememmber token" do
      user = create(:user, username: "testuser", password: "Password12")
      user.remember
      remember_token = user.remember_token
      expect(user.authenticated?(remember_token)).to be(true)
      expect(user.authenticated?("wrongtoken")).to be(false)
    end
  end
end
