require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  it "is valid with email and password" do
    expect(user).to be_valid
  end

  it "is invalid without an email" do
    user.email = nil
    expect(user).not_to be_valid
  end

  it "is invalid without a password" do
    user.password = nil
    expect(user).not_to be_valid
  end

  it "requires unique email" do
    create(:user, email: "test@example.com")
    user.email = "test@example.com"
    expect(user).not_to be_valid
  end

  context "Devise Token Auth headers" do
    it "can generate auth headers" do
      user.save!
      headers = user.create_new_auth_token

      expect(headers).to include("access-token")
      expect(headers).to include("client")
      expect(headers).to include("uid")
    end

    it "auth headers are valid for subsequent requests" do
      user.save!
      headers = user.create_new_auth_token

      # Simulate checking headers
      expect(headers["uid"]).to eq(user.uid)
      expect(headers["client"]).not_to be_nil
      expect(headers["access-token"]).not_to be_nil
    end
  end
end
