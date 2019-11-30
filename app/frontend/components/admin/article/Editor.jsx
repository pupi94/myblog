import React from 'react'
import ArticleForm from "./Form"
import ajax from "../../utils/Request";
import {message} from "antd";

class Editor extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            article: {}
        };
        this.id = props.match.params.id;
    }

    onSubmit = (article) => {
        ajax.patch(`/api/admin/articles/${this.id}`, {
            data: { article: article }
        }).then(response => {
            this.props.history.push("/admin/articles");
            message.success("修改成功");
        })
    };

    render() {
        return <ArticleForm articleId={ this.id } onSubmit={this.onSubmit} />
    }
}

export default Editor;
