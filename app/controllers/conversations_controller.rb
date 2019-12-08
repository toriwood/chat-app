class ConversationsController < ApplicationController
  def index
    @conversations = Conversation.includes(user_conversations: :user).all
  end

  def show
    @conversation = Conversation.includes(messages: :user).find(params[:id])
  end

  private
    def permitted_params
      params.require(:conversation).permit(:id)
    end
end
