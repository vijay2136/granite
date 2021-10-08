# frozen_string_literal: true

class RemoveUserIdFromTasks < ActiveRecord::Migration[6.1]
  def change
    remove_column :tasks, :user_id, :integer
  end
end
