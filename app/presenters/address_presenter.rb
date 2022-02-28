# frozen_string_literal: true

class AddressPresenter < BasePresenter
  attr_reader :user, :type

  def initialize(user, type)
    @user = user
    @type = type.downcase
  end

  def first_name
    return nil unless exist?

    send(type).first_name
  end

  def last_name
    return nil unless exist?

    send(type).last_name
  end

  def address
    return nil unless exist?

    send(type).address
  end

  def city
    return nil unless exist?

    send(type).city
  end

  def zip
    return nil unless exist?

    send(type).zip
  end

  def country
    return nil unless exist?

    send(type).country
  end

  def phone
    return nil unless exist?

    send(type).phone
  end

  private

  def exist?
    send(type).nil? ? false : true
  end

  def billing
    user.billing
  end

  def shipping
    user.shipping
  end
end
