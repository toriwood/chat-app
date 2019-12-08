class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates_presence_of :conversation_id, :user_id

  after_create :broadcast_message

  def broadcast_message
    ConversationChannel.broadcast_to(self.conversation, self.as_broadcast)
  end

  def as_broadcast
    {
      conversation_id: self.conversation.id,
      sender_name: self.user.username,
      sent_at: self.created_at,
      message_text: self.text
    }
  end
end
