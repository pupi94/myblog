import React from 'react'
import { Link } from "react-router-dom";
import { Table, Button, Modal } from 'antd';
const { confirm } = Modal;
import ajax from "../../utils/Request"

class Index extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            collections: [],
            loading: true,
            pagination: {
                showTotal: this.showTotal,
                total: 0,
                current: 1,
                pageSize: 10,
                showSizeChanger: true
            }
        };
        this.columns = [
            {
                name: '标题',
                dataIndex: 'name',
                render: (text, record) => (
                  <Link to={`/admin/collections/${record.id}`}>{text}</Link>
                ),
            },
            {
                title: '文章数量',
                dataIndex: 'article_count'
            },
            {
                title: '创建时间',
                dataIndex: 'created_at'
            },
            {
                title: '',
                render: (text, record) => (
                  <span>
                      <a onClick={ (e) => { this.deleteRecord(record.id, e); }}>删除</a>
                  </span>
                ),
            },
        ]
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

    deleteRecord = (id, e) => {
        confirm({
            title: '你确定要删除此专辑?',
            okType: 'danger',
            onOk: () => {
                ajax.delete(`/api/admin/collections/${id}`).then(response => {
                    this.refreshData()
                })
            }
        });
    };

    refreshData = () => {
        let pager = this.state.pagination;
        this.fetchData({ per_page: pager.pageSize, page: pager.current })
    };

    fetchData = (params = {}) => {
        this.setState({ loading: true });
        ajax.get("/api/admin/collections", { data: params})
          .then(response => {
              let pager = this.state.pagination;
              pager.total = response.count;
              this.setState({
                  collections: response.collections,
                  loading: false,
                  pagination: pager
              });
        });
    };

    render() {
        let { collections, loading, pagination } = this.state;

        return (
            <div className='index-page'>
                <div className="table-operations">
                    <Link to={"/admin/collections/new"} style={{float: 'right' }}>
                        <Button type="primary">创建</Button>
                    </Link>
                </div>
                <Table
                  columns={this.columns}
                  dataSource={collections}
                  loading={loading}
                  pagination={pagination}
                  onChange={this.onTableChange}
                  rowKey={"id"}
                />
            </div>
        )
    }
}

export default Index;
