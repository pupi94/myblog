import React from 'react'
import { Link, withRouter} from  'react-router-dom'
import {Icon, Breadcrumb} from 'antd';

const breadcrumbNameMap = {
    '/admin': <Icon type="home" />,
    //'/admin/articles/:id': '编辑',
    '/admin/articles': '博客管理',
};

class AppBreadcrumb extends React.Component {
    render() {
        const { location } = this.props;
        const pathSnippets = location.pathname.split('/').filter(i => i);
        const breadcrumbItems = pathSnippets.map((_, index) => {
            const url = `/${pathSnippets.slice(0, index + 1).join('/')}`;
            return (
                <Breadcrumb.Item key={url}>
                    <Link to={url}>{breadcrumbNameMap[url]}</Link>
                </Breadcrumb.Item>
            );
        });

        // const breadcrumbItems = [
        //     <Breadcrumb.Item key="home"><Link to="/"></Link></Breadcrumb.Item>,
        // ].concat(extraBreadcrumbItems);
        //

        return (
            <Breadcrumb style={{marginBottom: '15px'}}>{breadcrumbItems}</Breadcrumb>
        );
    }
}
export default withRouter(AppBreadcrumb);
