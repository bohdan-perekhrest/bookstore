require 'rails_helper'

RSpec.describe Coupon, type: :model do
  it { expect(subject).to validate_presence_of :code }
  it { expect(subject).to validate_presence_of :value }
  it { expect(subject).to validate_length_of(:code).is_equal_to 15 }
  it { expect(subject).to validate_numericality_of(:value) }
  it { expect(subject).to have_many :orders }
end
