import React, { useState, useEffect } from "react";

import { useParams, useHistory } from "react-router-dom";

import tasksApi from "apis/tasks";
import Container from "components/Container";
import PageLoader from "components/PageLoader";

const ShowTask = () => {
  const { slug } = useParams();
  const [task, setTask] = useState([]);
  const [pageLoading, setPageLoading] = useState(true);

  let history = useHistory();

  const updateTask = () => {
    history.push(`/tasks/${task.slug}/edit`);
  };

  const fetchTaskDetails = async () => {
    try {
      const response = await tasksApi.show(slug);
      setTask(response.data.task);
    } catch (error) {
      logger.error(error);
    } finally {
      setPageLoading(false);
    }
  };

  useEffect(() => {
    fetchTaskDetails();
  }, []);

  if (pageLoading) {
    return <PageLoader />;
  }

  return (
    <Container>
      <h1 className="pb-3 pl-3 mt-3 mb-3 text-lg leading-5 text-gray-800 border-b border-gray-500">
        <span className="text-gray-600">Task Title : </span> {task?.title}
      </h1>
      <div className="bg-bb-env px-2 mt-2 mb-4 rounded">
        <i
          className="text-2xl text-center transition cursor-pointer duration-300ease-in-out ri-edit-line hover:text-bb-yellow"
          onClick={updateTask}
        ></i>
      </div>
      <h2 className="pb-3 pl-3 mt-3 mb-3 text-lg leading-5 text-gray-800 border-b border-gray-500">
        <span className="text-gray-600">Assigned To : </span>
        {task?.assigned_user.name}
      </h2>
      <h2 className="pb-3 mb-3 text-md leading-5 text-bb-gray-600 text-opacity-50">
        <span>Created By : </span>
        {task?.task_owner?.name}
      </h2>
    </Container>
  );
};

export default ShowTask;
