# frozen_string_literal: true

class AddForeignKeyToAssignedUserIdTask < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :tasks, :users, column: :assigned_user_id
  end
end
