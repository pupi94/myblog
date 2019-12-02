import React from 'react'
import ArticleForm from "./Form"
import ajax from "../../utils/Request";
import {message} from "antd";

class Creator extends React.Component {
    constructor(props) {
        super(props);
        this.state = {};
    }

    onSubmit = (article) => {
        ajax.post("/api/admin/articles", {
            data: { article: article }
        }).then(response => {
            this.props.history.push("/admin/articles");
            message.success("创建成功");
        })
    };

    render() {
        return <ArticleForm onSubmit={this.onSubmit}/>
    }
}

export default Creator;
