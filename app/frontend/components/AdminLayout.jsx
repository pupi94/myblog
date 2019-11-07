import React from 'react'
import { Layout, Menu, Breadcrumb, Icon, Dropdown, message } from 'antd';

const { Header, Content, Footer, Sider } = Layout;
const { SubMenu } = Menu;

class AdminLayout extends React.Component {
    render() {
        let onClick = ({ key }) => {
            message.info(`Click on item ${key}`);
        };

        let menu = (
            <Menu onClick={onClick}>
                <Menu.Item key="1"><Icon type="user"/><span style={{marginLeft: '5px'}}>账号信息</span></Menu.Item>
                <Menu.Item key="2"><Icon type="logout"/><span style={{marginLeft: '5px'}}>退出登录</span></Menu.Item>
            </Menu>
        );
        return (
            <Layout style={{ minHeight: '100vh' }}>
                <Sider style={{overflow: 'auto', height: '100vh', position: 'fixed'}}>
                    <div className="logo" style={{color: "#FFF"}}/>
                    <Menu theme="dark" defaultSelectedKeys={['1']} mode="inline">
                        <Menu.Item key="1">
                            <Icon type="pie-chart" />
                            <span>概览</span>
                        </Menu.Item>
                        <SubMenu key="sub1" title={<span><Icon type="container"/><span>博客</span></span>}>
                            <Menu.Item key="2">博客管理</Menu.Item>
                            <Menu.Item key="3">博客专辑</Menu.Item>
                        </SubMenu>
                        <SubMenu key="sub2" title={<span><Icon type="picture" /><span>相册</span></span>}>
                            <Menu.Item key="4">图片管理</Menu.Item>
                            <Menu.Item key="5">图片专辑</Menu.Item>
                        </SubMenu>
                    </Menu>
                </Sider>
                <Layout style={{marginLeft: '200px'}}>
                    <Header style={{ background: '#fff', height: '50px', lineHeight: '50px', position: 'fixed', zIndex: 1, width: '100%'}}>
                        <div style={{marginRight: '165px', float: 'right'}}>
                            <div style={{display: "inline-block", marginRight: '30px'}}>
                                <a href="#"><Icon type="home"/><span>店铺首页</span></a>
                            </div>
                            <Dropdown overlay={menu}>
                                <a className="ant-dropdown-link" href="#">
                                    <Icon type="user"/><span style={{marginLeft: '5px'}}>huangpuping</span><Icon type="down"/>
                                </a>
                            </Dropdown>
                        </div>

                    </Header>

                    <Content style={{ marginTop: '50px', background: '#eef0f5', padding: '15px 15px 15px 30px'}}>
                        <Breadcrumb style={{ marginBottom: '15px'}}>
                            <Breadcrumb.Item href=""><Icon type="home" /></Breadcrumb.Item>
                            <Breadcrumb.Item>Application</Breadcrumb.Item>
                            <Breadcrumb.Item>option1</Breadcrumb.Item>
                        </Breadcrumb>

                        <div style={{background: '#fff', padding: 15 }}>
                            中间内容
                            ...
                            <br />
                            ...
                            <br />
                            ...
                            <br />
                            ...
                            <br />
                            content
                        </div>
                    </Content>
                    <Footer style={{ textAlign: 'center',background: '#fff', padding: '15px 50px' }}>Ant Design ©2018 Created by Ant UED</Footer>
                </Layout>
            </Layout>
        );
    }
}
export default AdminLayout;
