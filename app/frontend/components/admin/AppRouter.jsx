import React from "react";
import { Switch, Route } from 'react-router-dom'

import Dashboard from "./Dashboard";
import ArticleIndex from "./articles/Index";
import ArticleEdit from "./articles/Edit";

const routes = [
    { path: "/admin", exact: true, component: Dashboard },
    { path: "/admin/articles/:id", component: ArticleEdit },
    { path: "/admin/articles", exact: true, component: ArticleIndex }
];

class AppRouter extends React.Component {
    render() {
        return (
            <Switch>
                {
                    routes.map( (route, index) => (
                        <Route path={route.path} exact={route.exact} component={route.component} key={index} />
                    ))
                }
            </Switch>
        )
    }
}

export default AppRouter;