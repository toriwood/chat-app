class ConversationsController < ApplicationController
  def index
    if params[:user_id]
      @user_id = params[:user_id]
      @conversations = Conversation.joins(:user_conversations).where('user_conversations.user_id = ?', @user_id)
    else
      @conversations = Conversation.includes(user_conversations: :user).all
    end
  end

  def show
    @user_id ||= params[:user_id]
    @conversation = Conversation.includes(messages: :user).find(params[:id])
  end

  def update
    @conversation = Conversation.includes(messages: :user).find(params[:conversation][:id])
    return unless user_id = params[:conversation][:message][:user_id]
    return unless text = params[:conversation][:message][:text]
    Message.create(user_id: user_id, text: text, conversation_id: @conversation.id)
  end

  private
    def permitted_params
      params.require(:conversation).permit(:id, :user_id, message_attributes: [:user_id, :text])
    end
end
