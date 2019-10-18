import React from 'react'
import ReactDOM from 'react-dom'

import '../stylesheets/admin.scss'

import '../layouts/AdminLayout'
import AdminLayout from "../layouts/AdminLayout";

document.addEventListener('DOMContentLoaded', () => {
    ReactDOM.render(
        <AdminLayout/>,
        document.body.appendChild(document.getElementById('my_app'))
    )
});
