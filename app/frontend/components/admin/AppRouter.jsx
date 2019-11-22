import React from "react";
import { Switch, Route } from 'react-router-dom'

import Dashboard from "./Dashboard";
import ArticleIndex from "./articles/Index";
import ArticleEditor from "./articles/Editor";

const routes = [
    { path: "/admin", exact: true, component: Dashboard },
    { path: "/admin/articles/:id", component: ArticleEditor },
    { path: "/admin/articles", exact: true, component: ArticleIndex }
];

class AppRouter extends React.Component {
    render() {
        return (
          <div style={{background: '#fff', padding: 15 }}>
              <Switch>
                  {
                      routes.map( (route, index) => (
                        <Route path={route.path} exact={route.exact} component={ route.component } key={index} />
                      ))
                  }
              </Switch>
          </div>
        )
    }
}

export default AppRouter;