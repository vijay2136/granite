import axios from "axios";

const show = userId => axios.get(`/preferences/${userId}`);

const update = ({ id, payload }) => axios.put(`/preferences/${id}`, payload);

const preferencesApi = {
  show,
  update
};

export default preferencesApi;
