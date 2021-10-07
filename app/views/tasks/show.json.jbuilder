json.task do
  json.extract! @task,
    :id,
    :slug,
    :title

  json.assigned_user do
    json.id @task.user.id
    json.name @task.user.name
  end

  json.task_owner do
    json.extract! @task.task_owner,
      :name
  end
end
