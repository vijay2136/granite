# frozen_string_literal: true

class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i.freeze
  has_many :tasks, dependent: :destroy
  has_many :created_tasks, foreign_key: :task_owner_id, class_name: "Task"
  has_secure_password
  has_secure_token :authentication_token
  validates :name, presence: true, length: { maximum: 35 }
  validates :email, presence: true,
  uniqueness: true,
  length: { maximum: 50 },
  format: { with: VALID_EMAIL_REGEX }
  validates :password, length: { minimum: 6 }, if: -> { password.present? }
  validates :password_confirmation, presence: true, on: :create
  before_save :to_lowercase
  before_destroy :assign_tasks_to_task_owners

  def assign_tasks_to_task_owners
    tasks_whose_owner_is_not_current_user = assigned_tasks.select { |task| task.task_owner_id != id }
    tasks_whose_owner_is_not_current_user.each do |task|
      task.update(assigned_user_id: task.task_owner_id)
    end
  end

  private

    def to_lowercase
      email.downcase!
    end
end
