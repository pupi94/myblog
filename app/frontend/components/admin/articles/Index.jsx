import React from 'react'
import { Link } from "react-router-dom";
import { Table, Divider, Tag } from 'antd';

const columns = [
    {
        title: '标题',
        dataIndex: 'title',
        key: 'title',
        render: (text, record) => (
            <Link to={"/admin/articles/" + record.id}>{text}</Link>
        ),
    },
    {
        title: '浏览人数',
        dataIndex: 'pageview',
        key: 'pageview',
    },
    {
        title: '状态',
        dataIndex: 'published',
        key: 'published',
        render: published => (
            <span>
                <Tag color={published ? 'blue' : '#838486'}>{published ? '已发布' : '未发布'}</Tag>
            </span>
        ),
    },
    {
        title: '发布时间',
        dataIndex: 'published_at',
        key: 'published_at',
    },
    {
        title: '创建时间',
        dataIndex: 'created_at',
        key: 'created_at',
    },
    {
        title: '',
        key: 'action',
        render: (text, record) => (
            <span>
                {
                    record.published ? <a>取消发布</a> : <a>发布</a>
                }
                <Divider type="vertical" />
                <a>删除</a>
            </span>
        ),
    },
];

const data = [
    {
        id: '1',
        title: 'John Brown',
        pageview: 32,
        published: true,
        published_at: '2010-10-11',
        created_at: '2010-10-11',
    }, {
        id: '2',
        title: 'John Brown',
        pageview: 32,
        published: false,
        published_at: '2010-10-11',
        created_at: '2010-10-11',
    }, {
        id: '3',
        title: 'John Brown',
        pageview: 32,
        published: true,
        published_at: '2010-10-11',
        created_at: '2010-10-11',
    }
];

class Index extends React.Component {
    state = {
        selectedRowKeys: [],
    };

    onSelectChange = selectedRowKeys => {
        console.log('selectedRowKeys changed: ', selectedRowKeys);
        this.setState({ selectedRowKeys });
    };

    render() {
        let { selectedRowKeys } = this.state;
        let rowSelection = {
            selectedRowKeys,
            onChange: this.onSelectChange,
            hideDefaultSelections: true,
            selections: [
                {
                    key: 'batch-delete',
                    text: '批量删除',
                    onSelect: () => {
                        console.log("批量删除")
                    },
                },
                {
                    key: 'batch-publish',
                    text: '批量发布',
                    onSelect: () => {
                        console.log("批量发布")
                    },
                },
                {
                    key: 'batch-unpublish',
                    text: '批量取消发布',
                    onSelect: () => {
                        console.log("批量取消发布")
                    },
                }
            ]
        };
        return <Table rowSelection={rowSelection} columns={columns} dataSource={data} />;
    }
}

export default Index;
