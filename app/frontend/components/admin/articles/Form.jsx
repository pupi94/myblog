import React from 'react'
import { Button, Input, Form } from 'antd';
const { TextArea } = Input;

class ArticleForm extends React.Component {
    handleSubmit = (e) => {
        e.preventDefault();
        this.props.form.validateFields((err, values) => {
            if (!err) {
                console.log('Received values of form: ', values);
            }
        });
    };

    render() {
        const { getFieldDecorator } = this.props.form;

        return (
          <div style={ { width: '70%', marginLeft: "auto", marginRight: "auto" } }>
            <Form onSubmit={this.handleSubmit}>
              <Form.Item>
                {
                  getFieldDecorator('title', { rules: [{ required: true, message: 'Please input title' }] })
                  (<Input size="large" placeholder="标题"/>)
                }
              </Form.Item>
              <Form.Item>
                {
                  getFieldDecorator('content', { rules: [] })
                  (<TextArea rows={25} />)
                }
              </Form.Item>
              <Form.Item>
                <Button type="primary" htmlType="submit">保存</Button>
              </Form.Item>
            </Form>
          </div>
        )
    }
}

export default Form.create({ name: 'article_form' })(ArticleForm);