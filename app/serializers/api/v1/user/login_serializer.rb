# frozen_string_literal: true

class Api::V1::User::LoginSerializer < ActiveModel::Serializer
  include Util::JsonWebToken
  attribute :auth_token

  def auth_token
    payload = {
      user_uid: object.uid,
    }
    encode(payload)
  end
end
