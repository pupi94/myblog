import React from 'react'
import { Menu, Icon, Dropdown } from 'antd';
import ajax from '../utils/Request'

class AppHeader extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            email: ""
        };
        this.logout = this.logout.bind(this);
    }
    componentDidMount() {
        ajax.get("/api/admin/user")
            .then(response => {
                this.setState(response)
            })
    }
    logout() {
        ajax.delete("/users/sign_out").then(response => {
            window.location.href="/";
        });
    }

    render() {
        let menu = (
            <Menu>
                {/*<Menu.Item key="1" onClick={showUserInfo()}>*/}
                {/*    <Icon type="user"/><span style={{marginLeft: '5px'}}>账号信息</span>*/}
                {/*</Menu.Item>*/}
                <Menu.Item key="2" onClick={this.logout} >
                    <Icon type="logout"/><span style={{marginLeft: '5px'}}>退出登录</span>
                </Menu.Item>
            </Menu>
        );
        return (
            <div className="admin-header">
                <div style={{marginRight: '230px', float: 'right'}}>
                    <div style={{display: "inline-block", marginRight: '30px'}}>
                        <a href="/"><Icon type="home"/><span>网站首页</span></a>
                    </div>
                    <Dropdown overlay={menu}>
                        <a className="ant-dropdown-link" href="#">
                            <Icon type="user"/><span style={{marginLeft: '5px'}}>{this.state.email}</span><Icon type="down"/>
                        </a>
                    </Dropdown>
                </div>
            </div>
        );
    }
}
export default AppHeader;
