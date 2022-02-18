# frozen_string_literal: true

class ApplicationService
  include Pagy::Backend
  def self.call(*args, &block)
    new(*args, &block).call
  end
end
