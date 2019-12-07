require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'relationships' do
    it { should belong_to(:conversation) }
  end

  describe 'validations' do
    it { should validate_presence_of(:conversation_id) }
    it { should validate_presence_of(:user_id) }
  end
end
