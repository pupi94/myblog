import React from 'react'
import { Link } from "react-router-dom";
import { Table, Divider, Tag, Button, Pagination } from 'antd';
import ajax from "../../utils/Request"

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

class Index extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            articles: [],
            selectedRowKeys: [],
            loading: true,
            pagination: {
                showTotal: this.showTotal,
                total: 0,
                current: 1,
                pageSize: 10,
                showSizeChanger: true
            }
        };
        this.onSelectChange = this.onSelectChange.bind(this);
        this.batchPublish = this.batchPublish.bind(this);
        this.batchUnpublish = this.batchUnpublish.bind(this);
        this.fetchData = this.fetchData.bind(this);
        this.onTableChange = this.onTableChange.bind(this);
    }

    componentDidMount() {
        this.fetchData()
    }

    onTableChange = (pagination, filters, sorter) => {
        this.setState({ pagination: pagination });
        this.fetchData({ per_page: pagination.pageSize, page: pagination.current })
    };

    showTotal = (total) => {
        return <span>{total} 条记录</span>;
    };
    onSelectChange = (keys) => {
        this.setState({ selectedRowKeys: keys });
    };

    batchPublish = () => {

    };

    batchUnpublish = () => {

    };

    fetchData = (params = {}) => {
        this.setState({ loading: true });
        ajax.get("/api/admin/articles", { data: params})
          .then(response => {
              let pager = { ...this.state.pagination };
              pager.total = response.count;
              this.setState({
                  articles: response.articles,
                  loading: false,
                  pagination: pager
              });
        });
    };

    render() {
        let { selectedRowKeys, articles, loading, pagination } = this.state;
        let rowSelection = {
            selectedRowKeys,
            onChange: this.onSelectChange,
            hideDefaultSelections: true
        };
        return (
            <div>
                <div className="table-operations">
                    <Button onClick={this.batchPublish}>批量发布</Button>
                    <Button onClick={this.batchUnpublish}>批量下架</Button>
                </div>
                <Table
                  rowSelection={rowSelection}
                  columns={columns}
                  dataSource={articles}
                  loading={loading}
                  pagination={pagination}
                  onChange={this.onTableChange}
                />
            </div>
        )
    }
}

export default Index;
