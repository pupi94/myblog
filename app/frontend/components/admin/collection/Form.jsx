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
        <div className="collection-form">
          <Form onSubmit={this.handleSubmit}>
            <Form.Item style={{marginBottom: 15, marginTop: 30}}>
              {
                getFieldDecorator('title', {
                  rules: [{ required: true, message: '请输入标题' }],
                  initialValue: collection.title
                })
                (<Input size="large" placeholder="标题"/>)
              }
            </Form.Item>
            <Form.Item>
                {
                  getFieldDecorator('description', {
                    rules: [],
                    initialValue: collection.description
                  })
                  (<TextArea rows={10} />)
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

export default Form.create({ name: 'collection_form' })(CollectionForm);