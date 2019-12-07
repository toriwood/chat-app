class User < ApplicationRecord
  has_many :user_conversations
  has_many :conversations, through: :user_conversations

  validates_presence_of :username
  validates_uniqueness_of :username
end
