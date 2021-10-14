# frozen_string_literal: true

class PreferencesController < ApplicationController
  before_action :authenticate_user_using_x_auth_token
  before_action :load_preference, only: %i[update]

  def show
    preference = Preference.find_by(user_id: params[:id])
    authorize preference
    render status: :ok, json: { preference: preference }
  end

  def update
    if @preference.update(preference_params)
      authorize @preference
      render status: :ok, json: {
        notice: t("successfully_updated", entity: "Preference")
      }
    else
      errors = @preference.errors.full_messages.to_sentence
      render status: :unprocessable_entity, json: { error: errors }
    end
  end

  private

    def preference_params
      params.require(:preference).permit(:notification_delivery_hour, :receive_email)
    end

    def load_preference
      @preference = Preference.find_by(id: params[:id])
      unless @preference
        render status: :not_found, json: { error: t("not_found", entity: "Preference") }
      end
    end
end
