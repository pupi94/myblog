import React from 'react'
import ReactDOM from 'react-dom'

import '../stylesheets/admin.scss'
import App from "../components/admin/App";
import { BrowserRouter } from "react-router-dom";

document.addEventListener('DOMContentLoaded', () => {
    ReactDOM.render(
        <BrowserRouter><App/></BrowserRouter>,
        document.getElementById('root')
    )
});
