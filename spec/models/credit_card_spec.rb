# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreditCard, type: :model do
    context 'validations' do
    it { expect(subject).to validate_presence_of :number }
    it { expect(subject).to validate_presence_of :name }
    it { expect(subject).to validate_presence_of :mm_yy }
    it { expect(subject).to validate_presence_of :cvv }

    it { expect(subject).to have_one :order }
    it { expect(subject).to validate_numericality_of(:cvv) }

    it { expect(subject).to allow_value('933').for(:cvv) }
    it { expect(subject).to allow_value('1234').for(:cvv) }
    it { expect(subject).not_to allow_value('1').for(:cvv) }
    it { expect(subject).to allow_value('09/22').for(:mm_yy) }
    it { expect(subject).to allow_value('12/23').for(:mm_yy) }
    it { expect(subject).to allow_value('02/24').for(:mm_yy) }
    it { expect(subject).not_to allow_value('00/17').for(:mm_yy) }
    it { expect(subject).not_to allow_value('21/17').for(:mm_yy) }
    it { expect(subject).not_to allow_value('1f/ac').for(:mm_yy) }
    it { expect(subject).to allow_value('1234567891234571').for(:number) }
    it { expect(subject).to allow_value('9996667776661112').for(:number) }
    it { expect(subject).not_to allow_value('123456').for(:number) }
    it { expect(subject).not_to allow_value('fffffffffffffff').for(:number) }
    it { expect(subject).to allow_value('Adam').for(:name) }
    it { expect(subject).to allow_value('Eva').for(:name) }
    it { expect(subject).not_to allow_value('').for(:name) }
    it { expect(subject).not_to allow_value('looong name '*10).for(:name) }
    it { expect(subject).not_to allow_value('!@#$%^&*_+').for(:name) }
  end
end
