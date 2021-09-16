import axios from "axios";

const list = () => axios.get("/tasks");
const create = payload => axios.post("/tasks/", payload);
const show = slug => axios.get(`/tasks/${slug}`);

const tasksApi = {
  list,
  create,
  show
};

export default tasksApi;
