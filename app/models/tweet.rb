class Tweet
  include Mongoid::Document
  field :description, type: String
  field :created_at, type: Time
  field :updated_at, type: Time
  belongs_to :user
  has_many :comments, dependent: :destroy
end
