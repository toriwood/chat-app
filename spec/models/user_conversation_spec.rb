require 'rails_helper'

RSpec.describe UserConversation, type: :model do
  describe 'relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:conversation) }
  end

  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:conversation_id) }
    it { should validate_uniqueness_of(:user_id).scoped_to(:conversation_id) }
  end
end
