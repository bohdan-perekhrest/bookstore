# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
    options = {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true,
      space_after_headers: true,
      highlight: true,
      underline: true
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end

  def bootstrap_class_for(flash_type)
    {
      success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-info',
      warning: 'alert-warning'
    }[flash_type.to_sym] || flash_type.to_s
  end

  def country_name(object)
    country = ISO3166::Country[object.country]
    country.translations[I18n.locale.to_s] || country.name
  end

  def active_step?(current_step)
    'active' if current_step == step
  end
end
