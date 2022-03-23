# frozen_string_literal: true

class CheckoutController < ApplicationController
  include Wicked::Wizard
  include Showable
  include Updateable

  steps :login, :addresses, :delivery, :payment, :confirm, :complete

  def show
    send("show_#{step}") unless step == 'wicked_finish'
    render_wizard
  end

  def update
    send("update_#{step}")
    redirect_to next_wizard_path unless performed?
  end
end
