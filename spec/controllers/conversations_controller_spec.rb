require 'rails_helper'

RSpec.describe ConversationsController, type: :controller do
  describe 'GET #index' do
    context 'when user_id is present' do
      let!(:conversation1) { FactoryBot.create(:conversation) }
      let!(:conversation2) { FactoryBot.create(:conversation) }
      let(:user) { FactoryBot.create(:user) }

      it 'should only render conversations where the user is a participant' do
        conversation1.users = [user]
        conversation1.save

        get :index, params: { user_id: user.id }
        expect(@controller.view_assigns['user_id']).to eq(user.id.to_s)
        expect(@controller.view_assigns['conversations']).to eq([conversation1])
      end
    end

    context 'when user_id is not present' do
      let!(:conversation1) { FactoryBot.create(:conversation) }
      let!(:conversation2) { FactoryBot.create(:conversation) }
      let(:user) { FactoryBot.create(:user) }

      it 'should only render all conversations' do
        get :index
        expect(@controller.view_assigns.keys).to_not include('user_id')
        expect(@controller.view_assigns['conversations']).to eq([conversation1, conversation2])
      end
    end

  end

  describe 'POST #update' do
    context 'when user_id and text are present' do
      let!(:conversation1) { FactoryBot.create(:conversation) }
      let!(:conversation2) { FactoryBot.create(:conversation) }
      let(:user) { FactoryBot.create(:user) }

      it 'should create a new Message record' do
        expect { post :update, params: { id: conversation1.id, conversation: { id: conversation1.id, message: { user_id: user.id, text: 'Hi' } } } }.to change{Message.count}.by(1)
      end

      it 'should broadcast to the ConversationChannel' do
        expect { post :update, params: { id: conversation1.id, conversation: { id: conversation1.id, message: { user_id: user.id, text: 'Hi' } } } }.to(
        have_broadcasted_to(conversation1).from_channel(ConversationChannel))
      end
    end

    context 'when user_id or text are not present' do
      let!(:conversation1) { FactoryBot.create(:conversation) }
      let!(:conversation2) { FactoryBot.create(:conversation) }
      let(:user) { FactoryBot.create(:user) }

      it 'should create a new Message record' do
        expect { post :update, params: { id: conversation1.id, conversation: { id: conversation1.id, message: { user_id: user.id } } } }.to change{Message.count}.by(0)
      end

      it 'should broadcast to the ConversationChannel' do
        expect { post :update, params: { id: conversation1.id, conversation: { id: conversation1.id, message: { text: 'hi' } } } }.to change{Message.count}.by(0)
      end
    end
  end
end
