import React from 'react'
import ReactDOM from 'react-dom'

import { BrowserRouter } from "react-router-dom";
import { ConfigProvider } from 'antd';
import zhCN from 'antd/es/locale/zh_CN';

import '../stylesheets/admin.scss'
import App from "../components/admin/App";

document.addEventListener('DOMContentLoaded', () => {
    ReactDOM.render(
        <ConfigProvider locale={zhCN}>
            <BrowserRouter><App/></BrowserRouter>
        </ConfigProvider>,
        document.getElementById('root')
    )
});
