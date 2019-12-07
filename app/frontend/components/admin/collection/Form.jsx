import React from 'react'
import { Button, Input, Form } from 'antd';
import ajax from "../../utils/Request";

const { TextArea } = Input;

class CollectionForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      collection: {}
    };
    this.collectionId = this.props.collectionId;
  }

  componentDidMount() {
    if(this.collectionId){
      ajax.get(`/api/admin/collections/${this.collectionId}`)
        .then(response => {
          this.setState({ collection: response.collection });
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

  render() {
      let { getFieldDecorator } = this.props.form;
      let { collection } = this.state;
      return (
        <div className='form-page'>
          <Form onSubmit={this.handleSubmit}>
            <Form.Item style={{marginBottom: 15}} label="专辑名称">
              {
                getFieldDecorator('name', {
                  rules: [{ required: true, message: '请输入专辑名称' }],
                  initialValue: collection.name
                })
                (<Input size="large"/>)
              }
            </Form.Item>
            <Form.Item label="专辑描述">
                {
                  getFieldDecorator('description', {
                    rules: [],
                    initialValue: collection.description
                  })
                  (<TextArea rows={5} />)
                }
            </Form.Item>
            <Button type="primary" htmlType="submit">保存</Button>
          </Form>
        </div>
      )
  }
}

export default Form.create({ name: 'collection_form' })(CollectionForm);