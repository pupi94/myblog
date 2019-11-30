import React from 'react'
import { Layout, Menu, Icon } from 'antd';
import { Link } from "react-router-dom";

import AppHeader from "./AppHeader";
import AppRouter from "./AppRouter";
import AppBreadcrumb from "./AppBreadcrumb";

const { Content, Footer, Sider } = Layout;
const { SubMenu } = Menu;

class AdminApp extends React.Component {
    render() {
        return (
            <Layout style={{ minHeight: '100vh' }}>
                <Sider width='160' style={{overflow: 'auto', height: '100vh', position: 'fixed'}}>
                    <div className="logo" style={{color: "#FFF"}}/>
                    <Menu theme="dark" defaultSelectedKeys={['1']} mode="inline">
                        <Menu.Item key="1">
                            <Link to="/admin"><Icon type="pie-chart"/><span>概览</span></Link>
                        </Menu.Item>
                        <SubMenu key="sub1" title={<span><Icon type="container"/><span>博客</span></span>}>
                            <Menu.Item key="2"><Link to="/admin/articles">博客管理</Link></Menu.Item>
                            <Menu.Item key="3"><Link to="/admin/collections">博客专辑</Link></Menu.Item>
                        </SubMenu>
                        <SubMenu key="sub2" title={<span><Icon type="picture" /><span>相册</span></span>}>
                            <Menu.Item key="4">图片管理</Menu.Item>
                            <Menu.Item key="5">图片专辑</Menu.Item>
                        </SubMenu>
                    </Menu>
                </Sider>
                <Layout style={{marginLeft: '160px'}}>
                    <AppHeader/>
                    <Content style={{ marginTop: '50px', background: '#eef0f5', padding: '15px 15px 15px 30px'}}>
                        <AppBreadcrumb/>
                        <AppRouter/>
                    </Content>
                    <Footer style={{ textAlign: 'center',background: '#fff', padding: '15px 50px' }}>Ant Design ©2018 Created by Ant UED</Footer>
                </Layout>
            </Layout>
        );
    }
}
export default AdminApp;
