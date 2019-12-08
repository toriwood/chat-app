class ConversationChannel < ApplicationCable::Channel
  def subscribed
    conversation = Conversation.find_by(id: params["conversation_id"])
    stream_for conversation
  end
end
