# frozen_string_literal: true

module Authorizable
  extend ActiveSupport::Concern

  included do
    rescue_from Pundit::NotAuthorizedError, with: :handle_authorization_error
    include Pundit
  end

  def handle_authorization_error
    render status: :forbidden, json: { error: t("authorization.denied") }
  end
end
