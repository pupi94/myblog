import React from 'react'
import { Layout, Menu, Icon, Dropdown, message } from 'antd';
import {useHistory} from "react-router-dom";
import axios from 'axios';

class AppHeader extends React.Component {
    render() {
        let logout = () => {
            useHistory().push("/users/sign_in")
            // fetch("/users/sign_out", {
            //     method: "DELETE",
            //     headers: {"X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content}
            // });

        };

        let menu = (
            <Menu>
                <Menu.Item key="1">
                    <Icon type="user"/><span style={{marginLeft: '5px'}}>账号信息</span>
                </Menu.Item>
                <Menu.Item key="2" onClick={logout} >
                    <Icon type="logout"/><span style={{marginLeft: '5px'}}>退出登录</span>
                </Menu.Item>
            </Menu>
        );
        return (
            <div className="admin-header">
                <div style={{marginRight: '230px', float: 'right'}}>
                    <div style={{display: "inline-block", marginRight: '30px'}}>
                        <a href="/"><Icon type="home"/><span>店铺首页</span></a>
                    </div>
                    <Dropdown overlay={menu}>
                        <a className="ant-dropdown-link" href="#">
                            <Icon type="user"/><span style={{marginLeft: '5px'}}>huangpuping</span><Icon type="down"/>
                        </a>
                    </Dropdown>
                </div>
            </div>
        );
    }
}
export default AppHeader;
