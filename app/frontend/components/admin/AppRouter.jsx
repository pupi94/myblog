import React from "react";
import { Switch, Route } from 'react-router-dom'

import Dashboard from "./Dashboard";
import ArticleIndex from "./article/Index";
import ArticleEditor from "./article/Editor";
import ArticleCreator from "./article/Creator";
import CollectionIndex from "./collection/Index";
import CollectionEditor from "./collection/Editor";
import CollectionCreator from "./collection/Creator";

import NoMatch from "./NoMatch";

const routes = [
  { path: "/admin", exact: true, component: Dashboard },
  { path: "/admin/articles/new", component: ArticleCreator },
  { path: "/admin/articles/:id", component: ArticleEditor },
  { path: "/admin/articles", exact: true, component: ArticleIndex },
  { path: "/admin/collections/new", component: CollectionCreator },
  { path: "/admin/collections/:id", component: CollectionEditor },
  { path: "/admin/collections", exact: true, component: CollectionIndex },
  { path: "/admin/*", component: NoMatch }
];

class AppRouter extends React.Component {
  render() {
    return (
      <Switch>
        {
          routes.map( (route, index) => (
            <Route path={route.path} exact={route.exact} component={ route.component } key={index} />
          ))
        }
      </Switch>
    )
  }
}

export default AppRouter;