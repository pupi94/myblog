import React from 'react'
import { Button, Input, Form } from 'antd';

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
          <Form onSubmit={this.handleSubmit}>
              <Form.Item>
                  {
                    getFieldDecorator('username', { rules: [{ required: true, message: 'Please input your username!' }] })
                    (<Input placeholder="Username"/>)
                  }
              </Form.Item>
              <Form.Item>
                  {
                    getFieldDecorator('password', { rules: [{ required: true, message: 'Please input your Password!' }] })
                    (<Input type="password" placeholder="Password"/>)
                  }
              </Form.Item>
              <Form.Item>
                  <Button type="primary" htmlType="submit">Log in</Button>
              </Form.Item>
          </Form>
        )
    }
}

export default Form.create({ name: 'article_form' })(ArticleForm);