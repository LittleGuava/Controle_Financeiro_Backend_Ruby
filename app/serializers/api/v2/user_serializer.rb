class Api::V2::UserSerializer < ActiveModel::Serializer
  attributes :id, :description, :value, :date, :user_id, :created_at, :updated_at
end
