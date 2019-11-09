import React from 'react'
import { Link } from "react-router-dom";
import { Table, Divider, Tag, Button, Input, Select, Form, Row, Col } from 'antd';
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
                                <Select>
                                    <Select.Option value="">全部</Select.Option>
                                    <Select.Option value="true">已发布</Select.Option>
                                    <Select.Option value="false">未发布</Select.Option>
                                </Select>
                              )
                          }
                      </Form.Item>
                  </Col>
                  <Col span={6}>
                      <Form.Item>
                          {
                              getFieldDecorator('title')
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
        this.handleSearch = this.handleSearch.bind(this);
        this.handleReset = this.handleReset.bind(this);
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

    handleSearch = (form) => {
        console.log(form, "1111111111");
        form.validateFields((err, values) => {
            console.log('Received values of form: ', err);
            console.log('Received values of form: ', values);
        });


        // e.preventDefault();
        // console.log(this.props.form);
        // this.props.form.validateFields((err, values) => {
        //     console.log('Received values of form: ', values);
        // });
    };

    handleReset = () => {

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
                <ArticleSearchForm onSubmit={this.handleSearch} onReset={this.handleReset}/>
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
