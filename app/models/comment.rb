class Comment
  include Mongoid::Document
  field :title, type: String
  field :description, type: String
  field :created_at, type: Time
  field :updated_at, type: Time
  belongs_to :user
  belongs_to :tweet
end
