require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'relationships' do
    it { should belong_to(:conversation) }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:conversation_id) }
    it { should validate_presence_of(:user_id) }
  end

  describe '#broadcast_message' do
    let!(:conversation) { FactoryBot.create(:conversation) }
    let!(:user) { FactoryBot.create(:user) }

    it 'should broadcast the message to the ConversationChannel' do
      expect { Message.create(text: 'hi!', conversation_id: conversation.id, user_id: user.id) }.to(
      have_broadcasted_to(conversation).from_channel(ConversationChannel))
    end
  end

  describe '#as_broadcast' do
    let!(:conversation) { FactoryBot.create(:conversation) }
    let!(:user) { FactoryBot.create(:user) }
    let(:message) { FactoryBot.create(:message, user_id: user.id, conversation_id: conversation.id) }

    it 'should convert the message into a formatted message hash' do
      expect(message.as_broadcast).to eq(
        {
          conversation_id: message.conversation_id,
          sender_name: message.user.username,
          sent_at: message.created_at,
          message_text: message.text
        }
      )
    end
  end
end
