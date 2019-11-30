import React from 'react'
import CollectionForm from "./Form"
import ajax from "../../utils/Request";
import {message} from "antd";

class Creator extends React.Component {
    constructor(props) {
        super(props);
        this.state = {};
    }

    onSubmit = (collection) => {
        ajax.post("/api/admin/collections", {
            data: { collection: collection }
        }).then(response => {
            this.props.history.push("/admin/collections");
            message.success("创建成功");
        })
    };

    render() {
        return (<div> <CollectionForm onSubmit={this.onSubmit}/> </div>)
    }
}

export default Creator;
