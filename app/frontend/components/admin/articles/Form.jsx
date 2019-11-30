import React from 'react'
import { Button, Input, Form, Drawer } from 'antd';
import Markdown from 'react-markdown/with-html';
import ajax from "../../utils/Request";

const { TextArea } = Input;

class ArticleForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      visible: false,
      content: null,
      article: {}
    };
    this.articleId = this.props.articleId;
  }

  componentDidMount() {
    if(this.articleId){
      ajax.get(`/api/admin/articles/${this.articleId}`)
        .then(response => {
          this.setState({ article: response.article });
        });
    }
  }

  handleSubmit = (e) => {
      e.preventDefault();
      this.props.form.validateFields((err, values) => {
          if (!err) {
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
      let { article } = this.state;
      return (
        <div className="article-form">
          <Form onSubmit={this.handleSubmit}>
            <Form.Item style={{marginBottom: 15, marginTop: 30}}>
              {
                getFieldDecorator('title', {
                  rules: [{ required: true, message: '请输入标题' }],
                  initialValue: article.title
                })
                (<Input size="large" placeholder="标题"/>)
              }
            </Form.Item>
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
            <Form.Item>
              <Button type="primary" htmlType="submit">保存</Button>
            </Form.Item>
          </Form>
        </div>
      )
  }
}

export default Form.create({ name: 'article_form' })(ArticleForm);