import React, { useEffect, useState } from "react";

import { Route, Switch, BrowserRouter as Router } from "react-router-dom";
import { ToastContainer } from "react-toastify";

import { registerIntercepts, setAuthHeaders } from "apis/axios";
import { initializeLogger } from "common/logger";
import Signup from "components/Authentication/Signup";
import Dashboard from "components/Dashboard";
import PageLoader from "components/PageLoader";
import CreateTask from "components/Tasks/CreateTask";
import EditTask from "components/Tasks/EditTask";
import ShowTask from "components/Tasks/ShowTask";

const App = () => {
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    initializeLogger();
    registerIntercepts();
    setAuthHeaders(setLoading);
  }, []);

  if (loading) {
    return (
      <div className="h-screen">
        <PageLoader />
      </div>
    );
  }

  return (
    <Router>
      <ToastContainer />
      <Switch>
        <Route exact path="/signup" component={Signup} />
        <Route exact path="/tasks/:slug/edit" component={EditTask} />
        <Route exact path="/tasks/create" component={CreateTask} />
        <Route exact path="/dashboard" component={Dashboard} />
        <Route exact path="/tasks/:slug/show" component={ShowTask} />
      </Switch>
    </Router>
  );
};

export default App;
