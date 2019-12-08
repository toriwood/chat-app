class User < ApplicationRecord
  has_many :user_conversations, dependent: :destroy
  has_many :conversations, through: :user_conversations
  has_many :messages

  validates_presence_of :username
  validates_uniqueness_of :username
end
