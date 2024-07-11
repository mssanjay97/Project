import React from "react";
import { Routes, Route, Link } from "react-router-dom";
import "bootstrap/dist/css/bootstrap.min.css";
import "./App.css";

import AddTask from "./components/AddTask";
import Task from "./components/Task";
import TasksList from "./components/TasksList";

function App() {
  return (
    <div>
      <nav className="navbar navbar-expand navbar-dark bg-dark">
        <a href="/tasks" className="navbar-brand">
          Bug tracking system
        </a>
        <div className="navbar-nav mr-auto">
          <li className="nav-item">
            <Link to={"/tasks"} className="nav-link">
              Tasks
            </Link>
          </li>
          <li className="nav-item">
            <Link to={"/add"} className="nav-link">
              Add
            </Link>
          </li>
        </div>
      </nav>

      <div className="container mt-3">
        <Routes>
          <Route path="/" element={<TasksList/>} />
          <Route path="/tasks" element={<TasksList/>} />
          <Route path="/add" element={<AddTask/>} />
          <Route path="/tasks/:id" element={<Task/>} />
        </Routes>
      </div>
    </div>
  );
}

export default App;
