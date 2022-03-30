require 'rails_helper'

RSpec.describe Review, type: :model do
  it { expect(subject).to validate_presence_of :star }
  it { expect(subject).to validate_presence_of :text }
  it {
    expect(subject).to validate_numericality_of(:star).only_integer
      .is_greater_than_or_equal_to(1).is_less_than_or_equal_to(5)
  }
  it { expect(subject).to belong_to :user }
  it { expect(subject).to belong_to :book }
  it { expect(subject).to allow_value('Hello, world').for(:text) }

  describe 'scopes' do
    before do
      FactoryBot.create_list(:review, 3, status: :approved)
      FactoryBot.create_list(:review, 2, status: :rejected)
    end

    context 'approved' do
      it 'finds approved reviews' do
        expect(Review.approved.sample.status).to eq'approved'
      end
    end
  end
end
