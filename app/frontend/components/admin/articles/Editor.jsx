import React from 'react'
import { Divider, Tag, Button, Input, Select, Form, Row, Col, message, Modal } from 'antd';
import ArticleForm from "./Form"
import ajax from "../../utils/Request";

class Editor extends React.Component {
    constructor(props) {
        super(props);
        this.state = {};
        this.id = props.match.params.id;
    }

    componentDidMount() {
        ajax.get(`/api/admin/articles/${this.id}`)
          .then(response => {
              console.log(response)
          });
    }

    render() {
        return (<div> <ArticleForm/> </div>)
    }
}

export default Editor;
