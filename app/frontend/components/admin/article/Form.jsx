import React from 'react'
import { Button, Input, Form, Drawer, Select } from 'antd';
import Markdown from 'react-markdown/with-html';
import ajax from "../../utils/Request";

const { TextArea } = Input;

class ArticleForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      visible: false,
      content: null,
      article: {},
      selectedCollections: [],
      collections: []
    };
    this.articleId = this.props.articleId;
  }
  handleSelectChange = (_, selectedItems) => {
    this.setState({ selectedCollections: selectedItems.map(item => item.key)});
  };

  componentDidMount() {
    if(this.articleId){
      ajax.get(`/api/admin/articles/${this.articleId}`)
        .then(response => {
          this.setState({ article: response.article });
          let collections = response.article.collections.map((c) => {
            return { key: c.id, label: c.name }
          });
          this.setState({ selectedCollections: collections});
        });
    }
    ajax.get("/api/admin/collections")
      .then(response => {
        this.setState({ collections: response.collections });
      });
  }

  handleSubmit = (e) => {
      e.preventDefault();
      this.props.form.validateFields((err, values) => {
          if (!err) {
            values.collection_ids = values.collection_ids.map(c => c.key);
            this.props.onSubmit(values);
          }
      });
  };

  showDrawer = () => {
    if(this.state.visible) {
      this.setState({ visible: false });
    } else {
      this.setState({content: this.props.form.getFieldValue("content")});
      this.setState({ visible: true });
    }
  };

  onClose = () => {
    this.setState({ visible: false });
  };

  render() {
      let { getFieldDecorator } = this.props.form;
      let { article, selectedCollections, collections } = this.state;
      let filteredOptions = collections.filter(o => !selectedCollections.includes(o.id));

      return (
        <div className="form-page">
          <Form onSubmit={this.handleSubmit}>
            <div style={{display: 'flex'}}>
              <Form.Item style={{width: '30%', marginRight: '15px', marginBottom: '15px'}}>
                {
                  getFieldDecorator('collection_ids', {
                    rules: [{ required: true, message: '请选择所属专辑' }],
                    initialValue: selectedCollections
                  })
                  (
                    <Select
                      showSearch={true}
                      labelInValue={true}
                      mode="multiple"
                      size="large"
                      placeholder="所属专辑"
                      onChange={this.handleSelectChange}
                    >
                      {filteredOptions.map(item => (
                        <Select.Option key={item.id}>
                          {item.name}
                        </Select.Option>
                      ))}
                    </Select>
                  )
                }
              </Form.Item>

              <Form.Item style={{flex: '1', marginBottom: '15px'}}>
                {
                  getFieldDecorator('title', {
                    rules: [{ required: true, message: '请输入标题' }],
                    initialValue: article.title
                  })
                  (<Input size="large" placeholder="标题"/>)
                }
              </Form.Item>
            </div>
            <div style={{height: 35}}>
              <Button style={{float: 'right'}} onClick={this.showDrawer}>预览</Button>
            </div>
            <div style={{overflow: 'hidden', position: 'relative'}}>
              <Form.Item>
                {
                  getFieldDecorator('content', {
                    rules: [],
                    initialValue: article.content
                  })
                  (<TextArea rows={25} />)
                }
              </Form.Item>

              <Drawer
                placement="right"
                closable={false}
                onClose={this.onClose}
                visible={this.state.visible}
                getContainer={false}
                width={'100%'}
                style={{ position: 'absolute', zIndex: '0'}}
                drawerStyle={{ }}
                bodyStyle={{height: '100%', border: '1px solid #d9d9d9'}}>

                <div className='markdown-body'>
                  <Markdown source={this.state.content}/>
                </div>
              </Drawer>
            </div>
            <Button type="primary" htmlType="submit">保存</Button>
          </Form>
        </div>
      )
  }
}

export default Form.create({ name: 'article_form' })(ArticleForm);