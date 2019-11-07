import React from 'react'
import ReactDOM from 'react-dom'

import '../stylesheets/admin.scss'
import AdminLayout from "../components/AdminLayout";

document.addEventListener('DOMContentLoaded', () => {
    ReactDOM.render(
        <AdminLayout/>,
        document.body.appendChild(document.getElementById('my_app'))
    )
});
