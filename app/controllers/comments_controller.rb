# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :load_task
  before_action :authenticate_user_using_x_auth_token

  def create
    comment = @task.comments.new(comment_params.merge(user: current_user))
    if comment.save
      render status: :ok, json: {}
    else
      render status: :unprocessable_entity,
        json: { error: comment.errors.full_messages.to_sentence }
    end
  end

  private

    def load_task
      @task = Task.find_by(id: comment_params[:task_id])
      unless @task
        render status: :not_found, json: { error: t("not_found", entity: "Task") }
      end
    end

    def comment_params
      params.require(:comment).permit(:content, :task_id)
    end
end
