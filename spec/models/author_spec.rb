# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Author, type: :model do
  it { expect(subject).to validate_presence_of :first_name }
  it { expect(subject).to validate_uniqueness_of :first_name }
  it { expect(subject).to validate_presence_of :last_name }
  it { expect(subject).to validate_uniqueness_of :last_name }
  it { expect(subject).to have_many :authors_books }
  it { expect(subject).to have_many :books }
end
