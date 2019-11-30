import React from 'react'
import { Link } from "react-router-dom";
import { Table, Divider, Tag, Button, Input, Select, Form, Row, Col, message, Modal } from 'antd';
const { confirm } = Modal;
import ajax from "../../utils/Request"

class SearchForm extends React.Component {
    handleSearch = (e) => {
        e.preventDefault();
        this.props.onSubmit(this.props.form)
    };

    handleReset = () => {
        this.props.form.resetFields();
        this.props.onReset()
    };

    handleSelect = () => {
        this.props.onSubmit(this.props.form)
    };

    render() {
        const { getFieldDecorator } = this.props.form;

        return (
          <Form onSubmit={this.handleSearch}>
              <Row gutter={10}>
                  <Col span={2}>
                      <Form.Item>
                          {
                              getFieldDecorator('published', {
                                  initialValue: ""
                              })
                              (
                                <Select onChange={this.handleSelect}>
                                    <Select.Option value="">全部</Select.Option>
                                    <Select.Option value="true">已上架</Select.Option>
                                    <Select.Option value="false">已下架</Select.Option>
                                </Select>
                              )
                          }
                      </Form.Item>
                  </Col>
                  <Col span={6}>
                      <Form.Item>
                          {
                              getFieldDecorator('keyword', { initialValue: "" })
                              (<Input placeholder="文章标题"/>)
                          }
                      </Form.Item>
                  </Col>
                  <Col span={5} style={{paddingTop: 4}}>
                      <Button type="primary" icon="search" htmlType="submit">查询</Button>
                      <Button style={{ marginLeft: 8 }} onClick={this.handleReset}>重置</Button>
                  </Col>
              </Row>
          </Form>
        )
    }
}
const ArticleSearchForm = Form.create({ name: 'article_search' })(SearchForm);

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
            },
            searchData: {}
        };
        this.columns = [
            {
                title: '标题',
                dataIndex: 'title',
                render: (text, record) => (
                  <Link to={`/admin/articles/${record.id}`}>{text}</Link>
                ),
            },
            {
                title: '浏览人数',
                dataIndex: 'pageview'
            },
            {
                title: '状态',
                dataIndex: 'published',
                render: published => (
                  <span>
                <Tag color={published ? 'blue' : '#838486'}>{published ? '已上架' : '未上架'}</Tag>
            </span>
                ),
            },
            {
                title: '上架时间',
                dataIndex: 'published_at'
            },
            {
                title: '创建时间',
                dataIndex: 'created_at'
            },
            {
                title: '',
                render: (text, record) => (
                  <span>
                      {
                          record.published ?
                            <a onClick={ (e) => { this.unpublish(record.id, e); }}>下架</a>
                            :
                            <a onClick={ (e) => { this.publish(record.id, e); }}>上架</a>
                      }
                      <Divider type="vertical" />
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
        let data = this.state.searchData;
        let params = this.mergeJsonObject(data, { per_page: pagination.pageSize, page: pagination.current });
        this.fetchData(params)
    };

    handleReset = () => {
        let pager = this.state.pagination;
        this.setState({ searchData: {} });
        this.fetchData({ per_page: pager.pageSize, page: pager.current })
    };

    handleSearch = (form) => {
        form.validateFields((err, values) => {
            let pager = this.state.pagination;
            pager.current = 1;

            this.setState({ searchData: values, pagination: pager });
            let params = this.mergeJsonObject(values, { per_page: pager.pageSize, page: pager.current } );
            this.fetchData(params)
        });
    };

    showTotal = (total) => {
        return <span>{total} 条记录</span>;
    };

    onSelectChange = (keys) => {
        this.setState({ selectedRowKeys: keys });
    };

    batchPublish = () => {
        confirm({
            title: '你确定要上架选中的文章?',
            okType: 'danger',
            onOk: () => {
                this.batchOperation("/api/admin/articles/batch_publish", this.state.selectedRowKeys)
            }
        });
    };

    batchUnpublish = () => {
        confirm({
            title: '你确定要下架选中的文章?',
            okType: 'danger',
            onOk: () => {
                this.batchOperation("/api/admin/articles/batch_unpublish", this.state.selectedRowKeys)
            }
        });
    };

    batchOperation = (url, keys) => {
        if(keys.length == 0){
            message.info("无选中记录！");
            return
        }
        ajax.patch(url, {
            data: { ids: keys.join(",") }
        }).then(response => {
            this.refreshData();
        })
    };

    deleteRecord = (id, e) => {
        confirm({
            title: '你确定要删除此文章?',
            okType: 'danger',
            onOk: () => {
                ajax.delete(`/api/admin/articles/${id}`).then(response => {
                    this.refreshData()
                })
            }
        });
    };

    publish = (id, e) => {
        confirm({
            title: '你确定要上架此文章?',
            okType: 'danger',
            onOk: () => {
                this.batchOperation("/api/admin/articles/batch_publish", [id])
            }
        });
    };

    unpublish = (id, e) => {
        confirm({
            title: '你确定要下架此文章?',
            okType: 'danger',
            onOk: () => {
                this.batchOperation("/api/admin/articles/batch_unpublish", [id])
            }
        });
    };

    refreshData = () => {
        let pager = this.state.pagination;
        let params = this.mergeJsonObject(this.state.searchData, { per_page: pager.pageSize, page: pager.current });
        this.fetchData(params)
    };

    fetchData = (params = {}) => {
        this.setState({ loading: true, selectedRowKeys: [] });
        ajax.get("/api/admin/articles", { data: params})
          .then(response => {
              let pager = this.state.pagination;
              pager.total = response.count;
              this.setState({
                  articles: response.articles,
                  loading: false,
                  pagination: pager
              });
        });
    };

    mergeJsonObject = (obj1, obj2) => {
        let jsonObj = {};
        for(let attr in obj1){
            jsonObj[attr] = obj1[attr];
        }
        for(let attr in obj2){
            jsonObj[attr] = obj2[attr];
        }
        return jsonObj;
    };

    render() {
        let { selectedRowKeys, articles, loading, pagination } = this.state;
        let rowSelection = {
            selectedRowKeys,
            onChange: this.onSelectChange,
            hideDefaultSelections: true
        };

        return (
            <div className='index-page'>
                <ArticleSearchForm onSubmit={this.handleSearch} onReset={this.handleReset}/>
                <div className="table-operations">
                    <Button onClick={this.batchPublish}>批量上架</Button>
                    <Button onClick={this.batchUnpublish}>批量下架</Button>
                    <Link to={"/admin/articles/new"} style={{float: 'right' }}>
                        <Button type="primary">创建</Button>
                    </Link>
                </div>
                <Table
                  rowSelection={rowSelection}
                  columns={this.columns}
                  dataSource={articles}
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
